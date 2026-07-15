import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:delivery_app/src/core/localization/locale_keys.g.dart';
import 'package:delivery_app/src/core/utils/location_service.dart';
import 'package:delivery_app/src/core/widgets/app_bar_widget.dart';
import 'package:delivery_app/src/features/home/data/model/service_model.dart';
import 'package:delivery_app/src/features/home/presentation/widgets/search_bar.dart';
import 'package:delivery_app/src/features/home/presentation/widgets/service_suggestions_list.dart';
import 'package:delivery_app/src/features/home/presentation/widgets/delivery_animation_service.dart';
import 'package:delivery_app/src/features/home/presentation/widgets/route_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import 'package:delivery_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:delivery_app/src/features/home/presentation/cubit/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late YandexMapController mapController;
  Point aPoint = const Point(latitude: 41.3134, longitude: 69.2499);
  Point? bPoint;
  List<MapObject> mapObjects = [];

  // UI State guards
  bool _isRouting = false;

  // Search and animation controllers
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final DeliveryAnimationService _animationService = DeliveryAnimationService();

  @override
  void initState() {
    super.initState();
    LocationService.instance.requistPermission().then((value) {
      aPoint = Point(latitude: value.latitude, longitude: value.longitude);
      mapObjects.add(
        CircleMapObject(
          mapId: const MapObjectId('zone_a'),
          circle: Circle(center: aPoint, radius: 50),
          fillColor: Colors.blue.withAlpha(50),
        ),
      );
      setState(() {});
      mapController.moveCamera(
        CameraUpdate.newCameraPosition(CameraPosition(target: aPoint)),
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _animationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) => previous.selectedService != current.selectedService,
      listener: (context, state) {
        if (state.selectedService != null) {
          final ServiceModel service = state.selectedService!;
          _searchFocusNode.unfocus();
          _searchController.text = service.serviceName;
          
          mapController.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: Point(latitude: service.latitude, longitude: service.longitude),
                zoom: 15.0,
              ),
            ),
            animation: const MapAnimation(type: MapAnimationType.smooth, duration: 1.5),
          );
        } else {
          _searchController.clear();
        }
      },
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          title: LocaleKeys.app_name.tr(),
          isLeading: true,
          actions: [
            CircleAvatar(
              radius: 20,
              backgroundImage: const NetworkImage(
                "https://images.unsplash.com/photo-1695927621677-ec96e048dce2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZSUyMHBpY3R1cmUlMjBwZXJzb258ZW58MHx8MHx8fDA%3D",
              ),
            ),
            const SizedBox(width: 5),
          ],
        ),

        body: Stack(
          children: [
            Positioned.fill(
              child: YandexMap(
                mapObjects: mapObjects,
                nightModeEnabled:
                    AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
                mapType: MapType.vector,
                onMapCreated: (controller) {
                  mapController = controller;
                  mapController.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(target: aPoint),
                    ),
                  );
                },
                onMapTap: (argument) {
                  bPoint = argument;
                  mapObjects.removeWhere((obj) => obj.mapId.value == 'zone_b');
                  mapObjects.add(
                    CircleMapObject(
                      mapId: const MapObjectId('zone_b'),
                      circle: Circle(center: argument, radius: 50),
                      strokeColor: Colors.red,
                      fillColor: Colors.red.withAlpha(50),
                    ),
                  );
                  setState(() {});
                },
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              top: 105,
              bottom: 110,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    final showSuggestions = state.searchQuery.isNotEmpty && state.filteredServices.isNotEmpty;
                    final showNoResults = state.searchQuery.isNotEmpty && state.filteredServices.isEmpty;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        HomeSearchBar(
                          controller: _searchController,
                          focusNode: _searchFocusNode,
                          onChanged: (val) {
                            context.read<HomeCubit>().searchServices(val);
                          },
                          onClear: () {
                            _searchController.clear();
                            context.read<HomeCubit>().clearSearch();
                          },
                        ),
                        if (showSuggestions)
                          ServiceSuggestionsList(services: state.filteredServices),
                        if (showNoResults)
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                                  ? Colors.white
                                  : Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.search_off, color: Colors.grey, size: 24),
                                const SizedBox(width: 12),
                                Text(
                                  "No services found",
                                  style: GoogleFonts.workSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const Spacer(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(110, 45),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              elevation: 4,
                              shadowColor: Colors.black26,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            onPressed: _isRouting
                                ? null
                                : () => RouteService.requireRoute(
                                      context: context,
                                      mapController: mapController,
                                      mapObjects: mapObjects,
                                      currentPoint: aPoint,
                                      onCurrentPointChanged: (pt) {
                                        setState(() {
                                          aPoint = pt;
                                        });
                                      },
                                      isRouting: _isRouting,
                                      onRoutingStateChanged: (val) {
                                        setState(() {
                                          _isRouting = val;
                                        });
                                      },
                                      onStateChanged: () {
                                        setState(() {});
                                      },
                                      animationService: _animationService,
                                      vsync: this,
                                    ),
                            child: _isRouting
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.deepPurple,
                                    ),
                                  )
                                : Text(
                                    'Route',
                                    style: GoogleFonts.workSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
