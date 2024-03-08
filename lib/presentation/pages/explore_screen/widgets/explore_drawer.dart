import 'dart:developer';

import 'package:InOut/core/widgets/cached_image_auth.dart';
import 'package:InOut/presentation/bloc/explore_screen/explore_screen_bloc.dart';
import 'package:InOut/presentation/bloc/explore_screen/explore_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExploreDrawer extends StatefulWidget {
  const ExploreDrawer({super.key});

  @override
  State<ExploreDrawer> createState() => _ExploreDrawerState();
}

class _ExploreDrawerState extends State<ExploreDrawer> {
  bool showUserDetails = false;
  String text = "Stop Service";

  Widget _buildUserDetail() {
    return Container(
      height: 60,
      color: Colors.black87,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.red.shade700,
            ),
            title: const Text("Logout"),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreScreenBloc, ExploreScreenState>(
      builder: (context, state) {
        return Column(
          children: [
            UserAccountsDrawerHeader(
              arrowColor: Colors.white,
              currentAccountPicture: Center(
                child: CircleAvatar(
                  radius: 35,
                  child: Container(
                    height: 70,
                    width: 70,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: state is MeLoading
                        ? const SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(),
                          )
                        : state is MeLoaded
                            ? CachedImageAuth(
                                photo: state.user.photo!,
                                size: 30,
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.person,
                                  size: 45,
                                ),
                              )
                            : state is MeError
                                ? const Icon(
                                    Icons.image_not_supported,
                                    size: 45,
                                  )
                                : const SizedBox(),
                  ),
                ),
              ),
              currentAccountPictureSize: const Size.square(70),
              accountName: Text(state is MeLoaded
                  ? state.user.name!
                  : state is MeError
                      ? ""
                      : ""),
              accountEmail: Text(state is MeLoaded
                  ? state.user.email!
                  : state is MeError
                      ? ""
                      : ""),
              onDetailsPressed: () {
                log("Detail pressed");
                setState(() {
                  showUserDetails = !showUserDetails;
                });
              },
            ),
            showUserDetails ? _buildUserDetail() : const SizedBox(),
            ListTile(
              leading: const Icon(Icons.flip_to_back),
              title: const Text("Foreground Mode"),
              onTap: () {
                Future.delayed(
                  const Duration(seconds: 5),
                  () {
                    final service = FlutterBackgroundService();
                    service.startService();
                    service.invoke("setAsForeground");
                    service.invoke("stopService");
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.flip_to_front_outlined),
              title: const Text("Background Mode"),
              onTap: () {
                FlutterBackgroundService().invoke("setAsBackground");
              },
            ),
            ListTile(
              leading: Icon(
                text.contains("Stop")
                    ? Icons.remove_circle_outline_outlined
                    : Icons.check_circle_outline_outlined,
              ),
              title: Text(text),
              onTap: () async {
                final service = FlutterBackgroundService();
                var isRunning = await service.isRunning();
                if (isRunning) {
                  service.invoke("stopService");
                } else {
                  service.startService();
                }

                if (isRunning) {
                  setState(() {
                    text = 'Start Service';
                  });
                } else {
                  setState(() {
                    text = 'Stop Service';
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }
}
