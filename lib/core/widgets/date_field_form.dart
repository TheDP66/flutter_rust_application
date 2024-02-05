import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateFieldForm extends StatefulWidget {
  const DateFieldForm({
    super.key,
    required this.controller,
    required this.title,
    this.validator,
    this.clearable = true,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String title;
  final bool clearable;

  @override
  State<DateFieldForm> createState() => _DateFieldFormState();
}

class _DateFieldFormState extends State<DateFieldForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
        TextFormField(
          controller: widget.controller,
          readOnly: true,
          onTap: () {
            _showDatePicker();
          },
          validator: widget.validator,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          decoration: const InputDecoration().copyWith(
            suffixIcon: widget.controller.text.isNotEmpty &&
                    widget.controller.text != "" &&
                    widget.clearable
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        widget.controller.clear();
                      });
                    },
                  )
                : null,
          ),
        ),
        const SizedBox(
          height: 32,
        ),
      ],
    );
  }

  Future<void> _showDatePicker() async {
    DateTime selectedDate = DateTime.now();

    await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 300.0,
          color: Colors.white,
          child: CupertinoDatePicker(
            dateOrder: DatePickerDateOrder.dmy,
            mode: CupertinoDatePickerMode.date,
            initialDateTime: selectedDate,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                widget.controller.text =
                    newDate.toLocal().toString().split(' ')[0];
              });
            },
          ),
        );
      },
    );
  }
}
