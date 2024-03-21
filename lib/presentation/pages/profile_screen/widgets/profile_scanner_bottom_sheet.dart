import 'dart:developer';

import 'package:InOut/core/utils/validator.dart';
import 'package:InOut/core/widgets/scanner_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfileScannerBottomSheet extends StatefulWidget {
  const ProfileScannerBottomSheet({super.key});

  @override
  State<ProfileScannerBottomSheet> createState() => _ProfileScannnerState();
}

class _ProfileScannnerState extends State<ProfileScannerBottomSheet> {
  final MobileScannerController cameraController = MobileScannerController(
    formats: const [
      BarcodeFormat.qrCode,
      BarcodeFormat.codebar,
    ],
  );

  @override
  void initState() {
    super.initState();
    cameraController.start();
  }

  @override
  void dispose() {
    super.dispose();
    cameraController.stop();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 500,
                  child: MobileScanner(
                    fit: BoxFit.contain,
                    controller: cameraController,
                    placeholderBuilder: (context, _) {
                      return const ColoredBox(
                        color: Colors.black,
                      );
                    },
                    errorBuilder: (context, error, child) {
                      return ScannerErrorWidget(error: error);
                    },
                    onDetect: (BarcodeCapture capture) {
                      final List<Barcode> barcodes = capture.barcodes;
                      final Uint8List? image = capture.image;

                      for (final barcode in barcodes) {
                        log('Barcode found! ${barcode.rawValue}');
                      }

                      if (image != null) {
                        showDialog(
                          context: context,
                          builder: (context) => Image(
                            image: MemoryImage(image),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.filled(
                  onPressed: () => cameraController.toggleTorch(),
                  iconSize: 36,
                  icon: ValueListenableBuilder(
                    valueListenable: cameraController.torchState,
                    builder: (context, state, child) {
                      switch (state) {
                        case TorchState.off:
                          return Icon(
                            Icons.flashlight_on,
                            color: theme.colorScheme.background,
                          );
                        case TorchState.on:
                          return Icon(
                            Icons.flashlight_off,
                            color: theme.colorScheme.background,
                          );
                      }
                    },
                  ),
                ),
                const SizedBox(width: 21),
                IconButton.filled(
                  onPressed: () => cameraController.switchCamera(),
                  iconSize: 36,
                  icon: ValueListenableBuilder(
                    valueListenable: cameraController.cameraFacingState,
                    builder: (context, state, child) {
                      switch (state) {
                        case CameraFacing.front:
                          return Icon(
                            Icons.camera_front,
                            color: theme.colorScheme.background,
                          );
                        case CameraFacing.back:
                          return Icon(
                            Icons.camera_rear,
                            color: theme.colorScheme.background,
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 21),
            StreamBuilder(
              stream: cameraController.barcodes,
              builder: (context, snapshot) {
                final scannedBarcodes = snapshot.data?.barcodes ?? [];

                if (scannedBarcodes.isEmpty) {
                  return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Scan something!',
                      overflow: TextOverflow.fade,
                    ),
                  );
                }

                final scannedQr = scannedBarcodes.first.displayValue ?? "";

                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        scannedQr,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () async {
                            if (!scannedQr.validUrl) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Could not open URL !'),
                                ),
                              );
                            } else {
                              await launchUrlString(
                                scannedQr,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                          child: const Text("Open in browser"),
                        ),
                        TextButton(
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: scannedQr),
                            ).then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Copied to your clipboard !'),
                                ),
                              );
                            });
                          },
                          child: const Text("Copy to clipboard"),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
