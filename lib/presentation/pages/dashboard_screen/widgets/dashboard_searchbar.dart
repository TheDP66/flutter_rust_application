import 'package:InOut/core/params/barang_params.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_bloc.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardSearchBar extends StatefulWidget {
  const DashboardSearchBar({super.key});

  @override
  State<DashboardSearchBar> createState() => _DashboardSearchBarState();
}

class _DashboardSearchBarState extends State<DashboardSearchBar> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: CupertinoSearchTextField(
        controller: searchController,
        onChanged: (String value) {
          BlocProvider.of<DashboardScreenBloc>(context).add(
            FetchBarang(
              GetBarangParams(
                name: searchController.text,
              ),
            ),
          );
        },
        onSubmitted: (String value) {
          BlocProvider.of<DashboardScreenBloc>(context).add(
            FetchBarang(
              GetBarangParams(
                name: searchController.text,
              ),
            ),
          );
        },
      ),
    );
  }
}
