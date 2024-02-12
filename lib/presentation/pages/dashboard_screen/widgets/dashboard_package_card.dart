import 'package:InOut/core/utils/formatter.dart';
import 'package:flutter/material.dart';

class DashboardPackageCard extends StatelessWidget {
  const DashboardPackageCard({
    super.key,
    this.name,
    this.price,
    this.stock,
    this.expiredDate,
  });

  final String? name;
  final int? price;
  final int? stock;
  final String? expiredDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name ?? "-",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Opacity(
                opacity: .5,
                child: Text(
                  Formatter.price(price!),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                expiredDate == null ? "" : "Exp. $expiredDate",
                style: theme.textTheme.titleMedium,
              ),
              Text(
                "Stock: $stock",
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
