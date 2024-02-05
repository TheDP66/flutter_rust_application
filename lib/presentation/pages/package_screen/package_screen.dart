import 'package:InOut/core/params/barang_params.dart';
import 'package:InOut/core/utils/validator.dart';
import 'package:InOut/core/widgets/button_full_width.dart';
import 'package:InOut/core/widgets/date_field_form.dart';
import 'package:InOut/core/widgets/layout_app.dart';
import 'package:InOut/core/widgets/text_field_form.dart';
import 'package:InOut/injection.dart';
import 'package:InOut/presentation/bloc/package_screen/package_screen_bloc.dart';
import 'package:InOut/presentation/bloc/package_screen/package_screen_event.dart';
import 'package:InOut/presentation/bloc/package_screen/package_screen_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => inject<PackageScreenBloc>(),
        child: Scaffold(
          appBar: CupertinoNavigationBar(
            border: Border.all(
              width: 0,
              color: Colors.transparent,
            ),
            leading: CupertinoButton(
              alignment: Alignment.centerLeft,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LayoutApp(),
                  ),
                );
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
                  BlocBuilder<PackageScreenBloc, PackageScreenState>(
                    builder: (context, state) {
                      if (state is PackageLoading) {
                        return ButtonFullWidth(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ),
                          child: const CupertinoActivityIndicator(
                            color: Colors.white,
                          ),
                        );
                      }

                      if (state is PackageError) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(20),
                              content: Text(state.message),
                            ),
                          );
                        });
                      }

                      if (state is PackageLoaded) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(20),
                              content: Text("Package submitted!"),
                            ),
                          );
                        });

                        _resetPackageForm();
                      }

                      return ButtonFullWidth(
                        onPressed: () {
                          _resetPackageForm();

                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<PackageScreenBloc>(context).add(
                              InsertBarang(
                                InsertBarangParams(
                                  name: nameController.text,
                                  price: int.parse(priceController.text),
                                  stock: int.parse(stockController.text),
                                  expiredAt: expiredAtController.text,
                                ),
                              ),
                            );
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
                      );
                    },
                  ),
                  const SizedBox(
                    height: 21,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
