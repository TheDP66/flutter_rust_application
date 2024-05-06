import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileEmployee extends StatelessWidget {
  const ProfileEmployee({super.key});

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
            "Employee Menu",
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
                  context.push("/attendance");
                },
                child: const Text("Attendance"),
              ),
              const SizedBox(width: 12),
              FilledButton(
                onPressed: () {},
                child: const Text("Menu 2"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
