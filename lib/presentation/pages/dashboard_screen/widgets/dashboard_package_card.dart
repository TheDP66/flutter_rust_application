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
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
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
                  "Rp. $price",
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
                expiredDate == null ? "-" : "Exp. $expiredDate",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                "x$stock",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
