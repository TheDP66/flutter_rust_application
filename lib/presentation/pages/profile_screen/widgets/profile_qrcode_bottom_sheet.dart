import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileQrcodeBottomSheet extends StatefulWidget {
  const ProfileQrcodeBottomSheet({super.key});

  @override
  State<ProfileQrcodeBottomSheet> createState() =>
      _ProfileQrcodeBottomSheetState();
}

class _ProfileQrcodeBottomSheetState extends State<ProfileQrcodeBottomSheet> {
  TextEditingController controller = TextEditingController();
  String qrData =
      "https://www.youtube.com/watch?v=dQw4w9WgXcQ&ab_channel=RickAstley";

  @override
  void initState() {
    controller.text = qrData;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 21,
      ),
      child: Column(
        children: [
          SizedBox(
            width: 250,
            child: QrImageView(
              data: qrData,
              version: QrVersions.auto,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 28),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.text = "";
                  setState(() {
                    qrData = "";
                  });
                },
              ),
              labelText: 'QR Data',
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                setState(() {
                  qrData = controller.text;
                });
              },
              child: const Text("Generate QR Code"),
            ),
          ),
        ],
      ),
    );
  }
}
