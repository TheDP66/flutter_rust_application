import 'dart:async';

import 'package:InOut/core/channels/chat_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.payload});

  final String? payload;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String text = "Stop Service";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service App'),
      ),
      body: Column(
        children: [
          Text("notification payload: ${widget.payload}"),
          StreamBuilder<Map<String, dynamic>?>(
            stream: FlutterBackgroundService().on('update'),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final data = snapshot.data!;
              String? device = data["device"];
              DateTime? date = DateTime.tryParse(data["current_date"]);
              return Column(
                children: [
                  Text(device ?? 'Unknown'),
                  Text(date.toString()),
                ],
              );
            },
          ),
          ElevatedButton(
            child: const Text("Foreground Mode"),
            onPressed: () {
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
          ElevatedButton(
            child: const Text("Background Mode"),
            onPressed: () {
              FlutterBackgroundService().invoke("setAsBackground");
            },
          ),
          ElevatedButton(
            child: Text(text),
            onPressed: () async {
              final service = FlutterBackgroundService();
              var isRunning = await service.isRunning();
              if (isRunning) {
                service.invoke("stopService");
              } else {
                service.startService();
              }

              if (!isRunning) {
                text = 'Stop Service';
              } else {
                text = 'Start Service';
              }
              setState(() {});
            },
          ),
          ElevatedButton(
            child: const Text("Send notification"),
            onPressed: () async {
              final channel = ChatChannel();
              channel.sendNotification(
                header: "Notification header",
                content: "Notification content chat",
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
