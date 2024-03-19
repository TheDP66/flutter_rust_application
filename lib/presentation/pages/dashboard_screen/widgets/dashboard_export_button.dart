import 'package:InOut/core/params/barang_params.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_bloc.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_event.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_state.dart';
import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_sign_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardExportButton extends StatelessWidget {
  const DashboardExportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardScreenBloc, DashboardScreenState>(
      listener: (context, state) {
        if (state is ExportPackageError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(20),
              content: Text(state.message),
            ),
          );
        }

        if (state is ExportPackageLoaded) {
          showModalBottomSheet(
            useRootNavigator: true,
            useSafeArea: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            showDragHandle: true,
            context: context,
            builder: (_) => DashboardSignBottomSheet(
              user: state.user,
              barangs: state.barang,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ExportPackageLoading) {
          return IconButton(
            onPressed: null,
            icon: const SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.grey,
              ),
            ),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey,
            ),
          );
        }

        return IconButton(
          onPressed: () async {
            BlocProvider.of<DashboardScreenBloc>(context).add(
              PrepExportPackage(
                GetBarangParams(
                  name: null,
                ),
              ),
            );
          },
          icon: const Icon(Icons.print),
        );
      },
    );
  }
}
