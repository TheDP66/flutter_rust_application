import 'package:InOut/core/constant/url.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_bloc.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_event.dart';
import 'package:InOut/presentation/bloc/dashboard_screen/dashboard_screen_state.dart';
import 'package:InOut/presentation/pages/account_screen/account_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardScreenBloc, DashboardScreenState>(
      buildWhen: (prev, curr) {
        if (curr is MeLoading || curr is MeLoaded || curr is MeError) {
          return true;
        }

        return false;
      },
      builder: (context, state) {
        return SliverAppBar(
          centerTitle: true,
          leadingWidth: 42,
          floating: true,
          automaticallyImplyLeading: false,
          pinned: true,
          stretch: true,
          backgroundColor: Colors.grey[100],
          surfaceTintColor: Colors.grey[100],
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 14,
            ),
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AccountScreen(),
                  ),
                );

                FetchMeUser();
              },
              child: Center(
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor:
                      state is MeLoading ? Colors.grey[100] : Colors.grey[600]!,
                  child: Container(
                    width: 40,
                    height: 40,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: state is MeLoading
                        ? const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                          )
                        : CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: state is MeLoaded
                                ? "$baseUrl/storage/img/${state.user.photo!}"
                                : "",
                            errorWidget: (context, url, error) => const Icon(
                              Icons.person,
                              size: 23,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(
              top: 30,
              bottom: 20,
              right: 28,
            ),
            child: Center(
              child: Hero(
                tag: "icon-tag",
                child: Image.asset(
                  "assets/images/icon.png",
                  height: 85,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
