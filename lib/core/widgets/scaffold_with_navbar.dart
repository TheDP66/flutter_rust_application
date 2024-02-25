import 'dart:developer';

import 'package:InOut/core/resources/receive_notification.dart';
import 'package:InOut/core/services/background_service.dart';
import 'package:InOut/core/services/notification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavbar extends StatefulWidget {
  const ScaffoldWithNavbar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithNavbar> createState() => _ScaffoldWithNavbarState();
}

class _ScaffoldWithNavbarState extends State<ScaffoldWithNavbar> {
  @override
  void initState() {
    super.initState();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                context.pop();

                await context.push("/profile", extra: {
                  "payload": receivedNotification.payload,
                });
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String? payload) async {
      log(payload ?? "blank");

      await context.push("/profile", extra: {
        "payload": payload,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.navigationShell.currentIndex,
        enableFeedback: true,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) => {
          widget.navigationShell.goBranch(
            index,
            initialLocation: index == widget.navigationShell.currentIndex,
          )
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_filled),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
