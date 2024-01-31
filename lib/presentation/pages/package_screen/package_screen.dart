import 'package:InOut/core/utils/validator.dart';
import 'package:InOut/core/widgets/button_full_width.dart';
import 'package:InOut/core/widgets/date_field_form.dart';
import 'package:InOut/core/widgets/text_field_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PackageScreen extends StatefulWidget {
  const PackageScreen({super.key});

  @override
  State<PackageScreen> createState() => _PackageScreenState();
}

class _PackageScreenState extends State<PackageScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController expiredAtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          width: 0,
          color: Colors.transparent,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "New package",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFieldForm(
                        autofocus: true,
                        title: "Name",
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Field is required!';
                          }

                          return null;
                        },
                        controller: nameController,
                      ),
                      TextFieldForm(
                        autofocus: true,
                        title: "Price",
                        keyboardType: TextInputType.number,
                        prefixText: "Rp ",
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Field is required!';
                          }
                          if (!val.validNumber) {
                            return 'Number only';
                          }
                          return null;
                        },
                        controller: priceController,
                      ),
                      TextFieldForm(
                        autofocus: true,
                        title: "Stock",
                        keyboardType: TextInputType.number,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return 'Field is required!';
                          }
                          if (!val.validNumber) {
                            return 'Number only';
                          }
                          return null;
                        },
                        controller: stockController,
                      ),
                      DateFieldForm(
                        title: "Expired at",
                        controller: expiredAtController,
                      ),
                    ],
                  ),
                ),
              ),
              ButtonFullWidth(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 21,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
