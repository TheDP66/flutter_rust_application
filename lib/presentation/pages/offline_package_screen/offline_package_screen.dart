import 'package:InOut/core/hive/barang.dart';
import 'package:InOut/core/services/hive_boxes.dart';
import 'package:InOut/core/utils/validator.dart';
import 'package:InOut/core/widgets/button_full_width.dart';
import 'package:InOut/core/widgets/date_field_form.dart';
import 'package:InOut/core/widgets/text_field_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflinePackageScreen extends StatefulWidget {
  const OfflinePackageScreen({super.key});

  @override
  State<OfflinePackageScreen> createState() => _OfflinePackageScreenState();
}

class _OfflinePackageScreenState extends State<OfflinePackageScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController expiredAtController = TextEditingController();

  late SharedPreferences prefs;

  Future<void> _initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _resetPackageForm() {
    Future.delayed(Duration.zero, () {
      if (mounted) {
        _formKey.currentState!.reset();
        expiredAtController.text = "";
      }
    });
  }

  void _packageStored() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(20),
        content: Text("Package stored!"),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    expiredAtController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        border: Border.all(
          width: 0,
          color: Colors.transparent,
        ),
        leading: CupertinoButton(
          alignment: Alignment.centerLeft,
          onPressed: () {
            context.pop();
          },
          padding: EdgeInsets.zero,
          child: const Icon(
            CupertinoIcons.back,
            size: 28,
            color: CupertinoColors.systemBlue,
          ),
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
                  if (_formKey.currentState!.validate()) {
                    final barangs = BarangHive(
                      name: nameController.text,
                      price: int.parse(priceController.text),
                      stock: int.parse(stockController.text),
                      expired_at: expiredAtController.text,
                    );

                    final box = HiveBoxes.getBarangs();
                    box.add(barangs);

                    _packageStored();
                    _resetPackageForm();
                  }
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
