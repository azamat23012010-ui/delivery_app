import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:delivery_app/src/core/localization/locale_keys.g.dart';
import 'package:delivery_app/src/core/widgets/app_bar_widget.dart';
import 'package:delivery_app/src/features/history/presentation/widgets/history_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:delivery_app/src/features/history/presentation/cubit/history_cubit.dart';
import 'package:delivery_app/src/features/history/presentation/cubit/history_state.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                ? Colors.white
                : Colors.grey.shade800,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 21, backgroundColor: Colors.grey.shade300.withOpacity(0.4)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 16, width: 120, color: Colors.grey.shade300.withOpacity(0.4)),
                        const SizedBox(height: 6),
                        Container(height: 12, width: 80, color: Colors.grey.shade300.withOpacity(0.4)),
                      ],
                    ),
                  ),
                  Container(
                    height: 24,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 12, width: 50, color: Colors.grey.shade300.withOpacity(0.4)),
                      const SizedBox(height: 6),
                      Container(height: 16, width: 100, color: Colors.grey.shade300.withOpacity(0.4)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(height: 12, width: 50, color: Colors.grey.shade300.withOpacity(0.4)),
                      const SizedBox(height: 6),
                      Container(height: 16, width: 100, color: Colors.grey.shade300.withOpacity(0.4)),
                    ],
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No History Yet',
              style: GoogleFonts.workSans(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your completed and active deliveries will appear here.',
              textAlign: TextAlign.center,
              style: GoogleFonts.workSans(
                fontSize: 15,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: GoogleFonts.workSans(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.workSans(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                context.read<HistoryCubit>().getHistory();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
          ? const Color(0xffEEEDF3)
          : const Color(0xff0F1115),
      appBar: CustomAppBar(
        title: LocaleKeys.history.tr(),
        isDark: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  hintText: LocaleKeys.search_orders_hint.tr(),
                  hintStyle: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                        ? const Color(0xff717786)
                        : Colors.white70,
                  ),
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    size: 24,
                    color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                        ? const Color(0xff717786)
                        : Colors.white70,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, size: 20),
                          onPressed: () => _searchController.clear(),
                        )
                      : null,
                  filled: true,
                  fillColor: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                      ? Colors.grey.shade300
                      : Colors.grey.shade600,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                LocaleKeys.recent_deliveries.tr(),
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: BlocBuilder<HistoryCubit, HistoryState>(
                  builder: (context, state) {
                    if (state.status == HistoryStatus.loading) {
                      return _buildShimmerLoading(context);
                    } else if (state.status == HistoryStatus.error) {
                      return _buildErrorState(context, state.errorMessage ?? 'An error occurred');
                    }

                    final query = _searchController.text.toLowerCase().trim();
                    final filteredList = state.historyList.where((item) {
                      return item.from.toLowerCase().contains(query) ||
                          item.to.toLowerCase().contains(query) ||
                          item.status.toLowerCase().contains(query) ||
                          item.id.toLowerCase().contains(query);
                    }).toList();

                    if (filteredList.isEmpty) {
                      return _buildEmptyState(context);
                    }

                    return RefreshIndicator(
                      onRefresh: () => context.read<HistoryCubit>().getHistory(),
                      child: ListView.builder(
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          return DeliveryCard(delivery: filteredList[index]);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
