import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:delivery_app/src/core/localization/locale_keys.g.dart';
import 'package:delivery_app/src/core/widgets/app_bar_widget.dart';
import 'package:delivery_app/src/features/home/presentation/widgets/search_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  YandexMapController? _mapController;
  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: LocaleKeys.app_name.tr(),
        isLeading: true,
        actions: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1695927621677-ec96e048dce2?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cHJvZmlsZSUyMHBpY3R1cmUlMjBwZXJzb258ZW58MHx8MHx8fDA%3D",
            ),
          ),
          SizedBox(width: 5),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: YandexMap(
              nightModeEnabled:
                  AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
              onMapCreated: (controller) async {
                _mapController = controller;
                await controller.moveCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                      target: Point(latitude: 41.311081, longitude: 69.240562),
                      zoom: 14,
                    ),
                  ),
                );
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
              child: Column(
                children: [
                  HomeSearchBar(),
                  Spacer(),
                  //HomeDeliveryCard();
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
