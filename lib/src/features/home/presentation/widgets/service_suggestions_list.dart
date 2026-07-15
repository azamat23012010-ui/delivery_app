import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:delivery_app/src/features/home/data/model/service_model.dart';
import 'package:delivery_app/src/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceSuggestionsList extends StatelessWidget {
  final List<ServiceModel> services;

  const ServiceSuggestionsList({
    super.key,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 250),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: services.length,
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
            ),
            itemBuilder: (context, index) {
              final service = services[index];
              return InkWell(
                onTap: () {
                  context.read<HomeCubit>().selectService(service);
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.deepPurple, size: 22),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          service.serviceName,
                          style: GoogleFonts.workSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light
                                ? Colors.black87
                                : Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
