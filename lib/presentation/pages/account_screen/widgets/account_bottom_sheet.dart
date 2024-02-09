import 'package:flutter/material.dart';

class ListItem {
  final IconData icon;
  final String text;
  final Function() onTap;
  final Color? iconColor;

  ListItem({
    required this.icon,
    required this.text,
    required this.onTap,
    this.iconColor,
  });
}

class AccountBottomSheet extends StatelessWidget {
  const AccountBottomSheet({
    super.key,
    required this.items,
  });

  final List<ListItem> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              items[index].icon,
              color: items[index].iconColor ?? Colors.black,
            ),
            title: Text(
              items[index].text,
              style: TextStyle(
                color: items[index].iconColor ?? Colors.black,
              ),
            ),
            onTap: items[index].onTap,
          );
        },
      ),
    );
  }
}
