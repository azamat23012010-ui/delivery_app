import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:geolocator/geolocator.dart';

import 'package:delivery_app/src/core/utils/location_service.dart';
import 'package:delivery_app/src/features/home/data/model/service_model.dart';
import 'package:delivery_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:delivery_app/src/features/history/presentation/cubit/history_cubit.dart';
import 'package:delivery_app/src/features/home/presentation/widgets/delivery_animation_service.dart';

class RouteService {
  static Future<void> requireRoute({
    required BuildContext context,
    required YandexMapController mapController,
    required List<MapObject> mapObjects,
    required Point currentPoint,
    required Function(Point) onCurrentPointChanged,
    required bool isRouting,
    required Function(bool) onRoutingStateChanged,
    required VoidCallback onStateChanged,
    required DeliveryAnimationService animationService,
    required TickerProvider vsync,
  }) async {
    if (isRouting) return;

    final ServiceModel? selectedService = context.read<HomeCubit>().state.selectedService;
    if (selectedService == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a service first!'),
        ),
      );
      return;
    }

    onRoutingStateChanged(true);

    String userCity = "Tashkent"; // Default fallback
    Position? currentPosition;

    try {
      try {
        currentPosition = await LocationService.instance.getCurrentLocation();
        currentPoint = Point(latitude: currentPosition.latitude, longitude: currentPosition.longitude);
        onCurrentPointChanged(currentPoint);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not fetch current location: $e')),
        );
        await context.read<HistoryCubit>().createHistory(
          status: 'Cancelled',
          from: selectedService.serviceName,
          to: userCity,
        );
        return;
      }

      // Asynchronously reverse geocode user city name
      try {
        userCity = await LocationService.instance.reverseGeocode(
          currentPosition.latitude,
          currentPosition.longitude,
        );
      } catch (_) {
        // keep fallback
      }

      final destination = Point(
        latitude: selectedService.latitude,
        longitude: selectedService.longitude,
      );

      final record = await YandexDriving.requestRoutes(
        points: [
          RequestPoint(
            point: currentPoint,
            requestPointType: RequestPointType.wayPoint,
          ),
          RequestPoint(
            point: destination,
            requestPointType: RequestPointType.wayPoint,
          ),
        ],
        drivingOptions: const DrivingOptions(routesCount: 1, initialAzimuth: 0),
      );

      final result = await record.$2;

      if (result.error != null || result.routes == null || result.routes!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to request routes!')),
        );
        await context.read<HistoryCubit>().createHistory(
          status: 'Cancelled',
          from: selectedService.serviceName,
          to: userCity,
        );
        return;
      }

      final routePoints = result.routes!.first.geometry;

      // Clear old route polylines
      mapObjects.removeWhere((obj) => obj.mapId.value.startsWith('route_') || obj.mapId.value == 'route_polyline');
      
      // Draw route polyline
      mapObjects.add(
        PolylineMapObject(
          mapId: const MapObjectId('route_polyline'),
          polyline: routePoints,
          strokeColor: Colors.blue,
          strokeWidth: 5.5,
          arcApproximationStep: 3.0,
        ),
      );

      // Bounding box calculations with 20% padding
      final double minLat = math.min(currentPoint.latitude, destination.latitude);
      final double maxLat = math.max(currentPoint.latitude, destination.latitude);
      final double minLon = math.min(currentPoint.longitude, destination.longitude);
      final double maxLon = math.max(currentPoint.longitude, destination.longitude);

      final double latPadding = (maxLat - minLat) * 0.2;
      final double lonPadding = (maxLon - minLon) * 0.2;

      final bounds = BoundingBox(
        southWest: Point(
          latitude: minLat - (latPadding == 0 ? 0.005 : latPadding),
          longitude: minLon - (lonPadding == 0 ? 0.005 : lonPadding),
        ),
        northEast: Point(
          latitude: maxLat + (latPadding == 0 ? 0.005 : latPadding),
          longitude: maxLon + (lonPadding == 0 ? 0.005 : lonPadding),
        ),
      );

      await mapController.moveCamera(
        CameraUpdate.newGeometry(Geometry.fromBoundingBox(bounds)),
        animation: const MapAnimation(type: MapAnimationType.smooth, duration: 1.5),
      );

      // POST "In Transit" history item
      final newHistoryItem = await context.read<HistoryCubit>().createHistory(
        status: 'In Transit',
        from: selectedService.serviceName,
        to: userCity,
      );

      // Start animated delivery marker
      animationService.startMovementSimulation(
        vsync: vsync,
        context: context,
        routePoints: routePoints.points,
        mapObjects: mapObjects,
        onStateChanged: onStateChanged,
        historyId: newHistoryItem?.id,
      );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error drawing route: $e')),
      );
      await context.read<HistoryCubit>().createHistory(
        status: 'Cancelled',
        from: selectedService.serviceName,
        to: userCity,
      );
    } finally {
      onRoutingStateChanged(false);
    }
  }
}