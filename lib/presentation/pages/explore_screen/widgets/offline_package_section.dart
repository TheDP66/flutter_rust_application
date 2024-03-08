import 'dart:developer';

import 'package:InOut/core/hive/barang.dart';
import 'package:InOut/core/params/barang_params.dart';
import 'package:InOut/core/services/hive_boxes.dart';
import 'package:InOut/presentation/bloc/explore_screen/explore_screen_bloc.dart';
import 'package:InOut/presentation/bloc/explore_screen/explore_screen_event.dart';
import 'package:InOut/presentation/bloc/explore_screen/explore_screen_state.dart';
import 'package:InOut/presentation/pages/explore_screen/widgets/offlline_package_datatable_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfflinePackageSection extends StatefulWidget {
  const OfflinePackageSection({
    super.key,
    required this.barangs,
    required this.online,
  });

  final List<BarangHive> barangs;
  final bool online;

  @override
  State<OfflinePackageSection> createState() => _OfflinePackageSectionState();
}

class _OfflinePackageSectionState extends State<OfflinePackageSection> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExploreScreenBloc, ExploreScreenState>(
      listener: (context, state) {
        if (state is SyncLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(20),
              content: Text(state.message),
            ),
          );

          final boxBarangs = HiveBoxes.getBarangs();
          boxBarangs.clear();
        }

        if (state is SyncError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(20),
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Offline Packages",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 21,
                  ),
                ),
                IconButton(
                  onPressed: widget.online
                      ? () {
                          try {
                            final listBarang =
                                HiveBoxes.getBarangs().values.toList();
                            var jsonBarang =
                                BarangHive.jsonFromList(listBarang);

                            BlocProvider.of<ExploreScreenBloc>(context).add(
                              SyncBarang(
                                SyncBarangParams(
                                  barang: jsonBarang,
                                ),
                              ),
                            );
                          } catch (e) {
                            log(e.toString());
                          }
                        }
                      : null,
                  icon: state is SyncLoading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.grey,
                          ),
                        )
                      : Icon(
                          widget.online ? Icons.sync : Icons.sync_disabled,
                        ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            OfflinePackageDatatableView(
              barangs: widget.barangs,
            ),
          ],
        );
      },
    );
  }
}
