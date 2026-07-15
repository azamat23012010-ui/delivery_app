import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:delivery_app/src/features/history/presentation/cubit/history_cubit.dart';

class DeliveryAnimationService {
  AnimationController? _movementController;

  void startMovementSimulation({
    required TickerProvider vsync,
    required BuildContext context,
    required List<Point> routePoints,
    required List<MapObject> mapObjects,
    required VoidCallback onStateChanged,
    required String? historyId,
  }) {
    _movementController?.dispose();
    if (routePoints.isEmpty) return;

    final List<double> segmentLengths = [];
    double totalLength = 0;
    for (int i = 0; i < routePoints.length - 1; i++) {
      final p1 = routePoints[i];
      final p2 = routePoints[i + 1];
      final dx = p2.longitude - p1.longitude;
      final dy = p2.latitude - p1.latitude;
      final dist = math.sqrt(dx * dx + dy * dy);
      segmentLengths.add(dist);
      totalLength += dist;
    }

    _movementController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 10),
    );

    int lastSegmentIndex = 0;
    double currentDist = 0;

    _movementController!.addListener(() {
      final t = _movementController!.value;
      if (t >= 1.0) {
        syncDeliveryMarker(
          position: routePoints.last,
          rotation: 0.0,
          mapObjects: mapObjects,
          onStateChanged: onStateChanged,
        );
        onDeliveryArrived(context, historyId);
        return;
      }

      final targetDist = t * totalLength;

      // Stateful caching index scan avoids scanning from 0 every frame
      while (lastSegmentIndex < segmentLengths.length &&
          currentDist + segmentLengths[lastSegmentIndex] < targetDist) {
        currentDist += segmentLengths[lastSegmentIndex];
        lastSegmentIndex++;
      }

      if (lastSegmentIndex < segmentLengths.length) {
        final len = segmentLengths[lastSegmentIndex];
        final segmentT = len > 0 ? (targetDist - currentDist) / len : 0.0;
        final p1 = routePoints[lastSegmentIndex];
        final p2 = routePoints[lastSegmentIndex + 1];
        final lat = p1.latitude + (p2.latitude - p1.latitude) * segmentT;
        final lon = p1.longitude + (p2.longitude - p1.longitude) * segmentT;
        final currentPt = Point(latitude: lat, longitude: lon);
        final rotation = calculateBearing(p1, p2);
        syncDeliveryMarker(
          position: currentPt,
          rotation: rotation,
          mapObjects: mapObjects,
          onStateChanged: onStateChanged,
        );
      }
    });

    _movementController!.forward();
  }

  void syncDeliveryMarker({
    required Point position,
    required double rotation,
    required List<MapObject> mapObjects,
    required VoidCallback onStateChanged,
  }) {
    mapObjects.removeWhere((obj) => obj.mapId == const MapObjectId('moving_delivery_marker'));
    mapObjects.add(
      PlacemarkMapObject(
        mapId: const MapObjectId('moving_delivery_marker'),
        point: position,
        opacity: 1.0,
        direction: rotation,
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage('assets/icons/truck.png'),
            scale: 0.12,
            rotationType: RotationType.rotate,
          ),
        ),
      ),
    );
    onStateChanged();
  }

  double calculateBearing(Point from, Point to) {
    final double lat1 = from.latitude * math.pi / 180.0;
    final double lat2 = to.latitude * math.pi / 180.0;
    final double lon1 = from.longitude * math.pi / 180.0;
    final double lon2 = to.longitude * math.pi / 180.0;

    final double dLon = lon2 - lon1;

    final double y = math.sin(dLon) * math.cos(lat2);
    final double x = math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(dLon);

    final double radians = math.atan2(y, x);
    final double degrees = radians * 180.0 / math.pi;
    return (degrees + 360.0) % 360.0;
  }

  void onDeliveryArrived(BuildContext context, String? historyId) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Delivery arrived at destination!')),
    );
    if (historyId != null) {
      context.read<HistoryCubit>().updateHistoryStatus(
        id: historyId,
        status: 'Delivered',
      );
    }
  }

  void dispose() {
    _movementController?.dispose();
  }
}