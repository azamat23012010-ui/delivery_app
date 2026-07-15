import 'package:delivery_app/src/features/history/presentation/screens/history_screen.dart';
import 'package:delivery_app/src/features/home/presentation/screens/home_screen.dart';
import 'package:delivery_app/src/features/settings/screens/settings_screen.dart';
import 'package:delivery_app/src/features/settings/widgets/bottom_bar_widgets.dart';
import 'package:delivery_app/src/core/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:delivery_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:delivery_app/src/features/home/domain/usecase/get_service_location.dart';
import 'package:delivery_app/src/features/home/data/repository/home_repository_impl.dart';
import 'package:delivery_app/src/features/home/data/source/home_data_source_impl.dart';

import 'package:delivery_app/src/features/history/presentation/cubit/history_cubit.dart';
import 'package:delivery_app/src/features/history/domain/usecase/get_history_usecase.dart';
import 'package:delivery_app/src/features/history/domain/usecase/create_history_usecase.dart';
import 'package:delivery_app/src/features/history/domain/usecase/update_history_status_usecase.dart';
import 'package:delivery_app/src/features/history/data/repository/history_repository_impl.dart';
import 'package:delivery_app/src/features/history/data/source/history_remote_data_source_impl.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    const HistoryScreen(),
    Scaffold(body: Center(child: Text(LocaleKeys.profile_placeholder.tr()))),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(
            usecase: GetServiceLocationUsecase(
              repository: HomeRepositoryImpl(
                source: HomeDataSourceImpl(),
              ),
            ),
          )..getServices(),
        ),
        BlocProvider<HistoryCubit>(
          create: (context) => HistoryCubit(
            getHistoryUseCase: GetHistoryUseCase(
              repository: HistoryRepositoryImpl(
                remoteDataSource: HistoryRemoteDataSourceImpl(),
              ),
            ),
            createHistoryUseCase: CreateHistoryUseCase(
              repository: HistoryRepositoryImpl(
                remoteDataSource: HistoryRemoteDataSourceImpl(),
              ),
            ),
            updateHistoryStatusUseCase: UpdateHistoryStatusUseCase(
              repository: HistoryRepositoryImpl(
                remoteDataSource: HistoryRemoteDataSourceImpl(),
              ),
            ),
          )..getHistory(),
        ),
      ],
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(index: currentIndex, children: pages),
        bottomNavigationBar: GlassBottomBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
