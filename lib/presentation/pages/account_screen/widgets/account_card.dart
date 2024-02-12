import 'package:InOut/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({
    super.key,
    required this.loading,
    this.user,
  });

  final bool loading;
  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Name",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    user?.name ?? "-",
                    style: TextStyle(
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    user?.email ?? "-",
                    style: TextStyle(
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
