import 'package:InOut/presentation/pages/profile_screen/widgets/profile_qrcode_bottom_sheet.dart';
import 'package:InOut/presentation/pages/profile_screen/widgets/profile_scanner_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ProfileScannerButton extends StatelessWidget {
  const ProfileScannerButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 21,
        vertical: 18,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "QR Code",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              FilledButton(
                onPressed: () {
                  showModalBottomSheet(
                    useRootNavigator: true,
                    useSafeArea: true,
                    isScrollControlled: true,
                    showDragHandle: true,
                    context: context,
                    builder: (_) => const ProfileQrcodeBottomSheet(),
                  );
                },
                child: const Text("Generate"),
              ),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: () {
                  showModalBottomSheet(
                    useRootNavigator: true,
                    useSafeArea: true,
                    isScrollControlled: true,
                    showDragHandle: true,
                    context: context,
                    builder: (_) => const ProfileScannerBottomSheet(),
                  );
                },
                child: const Text("Scan"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
