import 'package:InOut/core/params/barang_params.dart';
import 'package:InOut/domain/entities/barang_entity.dart';
import 'package:InOut/injection.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_bloc.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_event.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_state.dart';
import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_appbar.dart';
import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_package_section.dart';
import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_searchbar.dart';
import 'package:InOut/presentation/pages/package_screen/package_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => inject<DashboardScreenBloc>()
          ..add(
            FetchBarang(
              GetBarangParams(
                name: null,
              ),
            ),
          ),
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
              const DashboardAppBar(),
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(
                top: 14,
                left: 14,
                right: 14,
              ),
              child: Column(
                children: [
                  const DashboardSearchBar(),
                  const SizedBox(
                    height: 28,
                  ),
                  BlocBuilder<DashboardScreenBloc, DashboardScreenState>(
                    builder: (context, state) {
                      if (state is DashboardLoading) {
                        return const CircularProgressIndicator();
                      }

                      if (state is DashboardError) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(20),
                              content: Text(state.message),
                            ),
                          );
                        });
                      }

                      if (state is DashboardLoaded) {
                        final List<BarangEntity> barangs = state.barang;

                        return DashboardPackageSection(barangs: barangs);
                      }

                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PackageScreen(),
            ),
          );

          FetchBarang(
            GetBarangParams(
              name: null,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
