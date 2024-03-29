import 'package:InOut/core/params/barang_params.dart';
import 'package:InOut/domain/entities/barang_entity.dart';
import 'package:InOut/injection.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_bloc.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_event.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_state.dart';
import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_appbar.dart';
import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_package_section.dart';
import 'package:InOut/presentation/pages/dashboard_screen/widgets/dashboard_searchbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: BlocProvider(
        create: (context) {
          final bloc = inject<DashboardScreenBloc>();

          bloc.add(FetchMeUser());
          bloc.add(FetchBarang(
            GetBarangParams(
              name: null,
            ),
          ));

          return bloc;
        },
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Container(
                  height: 20,
                  color: colorScheme.primaryContainer,
                ),
              ),
              const DashboardAppBar(),
            ];
          },
          body: BlocConsumer<DashboardScreenBloc, DashboardScreenState>(
            buildWhen: (prev, curr) {
              if (curr is DashboardLoading ||
                  curr is DashboardLoaded ||
                  curr is DashboardError) {
                return true;
              }

              return false;
            },
            listener: (context, state) {
              if (state is DashboardError) {
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
              return RefreshIndicator(
                onRefresh: () async {
                  searchController.text = "";

                  context.read<DashboardScreenBloc>().add(
                        FetchBarang(
                          GetBarangParams(
                            name: null,
                          ),
                        ),
                      );

                  context.read<DashboardScreenBloc>().add(
                        FetchMeUser(),
                      );
                },
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 14,
                      left: 14,
                      right: 14,
                    ),
                    child: Column(
                      children: [
                        DashboardSearchBar(
                          searchController: searchController,
                        ),
                        const SizedBox(
                          height: 28,
                        ),
                        if (state is DashboardLoading)
                          const CircularProgressIndicator(),
                        ...(state is DashboardLoaded
                            ? [
                                () {
                                  final List<BarangEntity> barangs =
                                      state.barang;

                                  return DashboardPackageSection(
                                    barangs: barangs,
                                  );
                                }(),
                              ]
                            : []),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "fab-dashboard",
        onPressed: () async {
          await context.push("/package");

          BlocProvider.of<DashboardScreenBloc>(context).add(
            FetchBarang(
              GetBarangParams(
                name: null,
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: colorScheme.secondaryContainer,
        ),
      ),
    );
  }
}
