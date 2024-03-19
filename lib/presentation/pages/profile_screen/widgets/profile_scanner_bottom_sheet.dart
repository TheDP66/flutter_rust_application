import 'dart:typed_data';

import 'package:InOut/core/widgets/scanned_barcode_label.dart';
import 'package:InOut/core/widgets/scanner_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: 200,
      height: 200,
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        Center(
          child: MobileScanner(
            fit: BoxFit.contain,
            controller: cameraController,
            scanWindow: scanWindow,
            errorBuilder: (context, error, child) {
              return ScannerErrorWidget(error: error);
            },
            onDetect: (BarcodeCapture capture) {
              final List<Barcode> barcodes = capture.barcodes;
              final Uint8List? image = capture.image;
              for (final barcode in barcodes) {
                debugPrint('Barcode found! ${barcode.rawValue}');
              }
            },
            overlay: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ScannedBarcodeLabel(barcodes: cameraController.barcodes),
              ),
            ),
          ),
        ),
        // ValueListenableBuilder(
        //   valueListenable: cameraController.,
        //   builder: (context, value, child) {
        //     if (!value.isInitialized ||
        //         !value.isRunning ||
        //         value.error != null) {
        //       return const SizedBox();
        //     }

        //     return CustomPaint(
        //       painter: ScannerOverlay(scanWindow: scanWindow),
        //     );
        //   },
        // ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  color: Colors.white,
                  icon: ValueListenableBuilder(
                    valueListenable: cameraController.torchState,
                    builder: (context, state, child) {
                      switch (state as TorchState) {
                        case TorchState.off:
                          return const Icon(Icons.flash_off,
                              color: Colors.grey);
                        case TorchState.on:
                          return const Icon(Icons.flash_on,
                              color: Colors.yellow);
                      }
                    },
                  ),
                  iconSize: 32.0,
                  onPressed: () => cameraController.toggleTorch(),
                ),
                IconButton(
                  color: Colors.white,
                  icon: ValueListenableBuilder(
                    valueListenable: cameraController.cameraFacingState,
                    builder: (context, state, child) {
                      switch (state as CameraFacing) {
                        case CameraFacing.front:
                          return const Icon(Icons.camera_front);
                        case CameraFacing.back:
                          return const Icon(Icons.camera_rear);
                      }
                    },
                  ),
                  iconSize: 32.0,
                  onPressed: () => cameraController.switchCamera(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// https://pub.dev/packages/mobile_scanner