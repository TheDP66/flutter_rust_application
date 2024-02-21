import 'dart:async';
import 'dart:developer';

import 'package:InOut/core/hive/barang.dart';
import 'package:InOut/core/services/hive_boxes.dart';
import 'package:InOut/injection.dart';
import 'package:InOut/presentation/bloc/explore_screen/explore_screen_bloc.dart';
import 'package:InOut/presentation/pages/explore_screen/widgets/offline_package_section.dart';
import 'package:InOut/presentation/pages/offline_package_screen/offline_package_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  ConnectivityResult _connectionStatus = ConnectivityResult.other;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final List<BarangHive> barangs = [];

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (_connectionStatus == ConnectivityResult.none) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(20),
            content: Text("You're offline!"),
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Connection Status: ${(_connectionStatus != ConnectivityResult.none) ? "Online" : "Offline"}',
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => inject<ExploreScreenBloc>(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
              top: 14,
              left: 14,
              right: 14,
            ),
            child: Column(
              children: [
                ValueListenableBuilder<Box<BarangHive>>(
                  valueListenable: HiveBoxes.getBarangs().listenable(),
                  builder: (context, box, _) {
                    final barangs = box.values.toList().cast<BarangHive>();

                    return OfflinePackageSection(
                      barangs: barangs,
                      online: _connectionStatus != ConnectivityResult.none,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const OfflinePackageScreen(),
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
