import 'package:InOut/core/params/auth_params.dart';
import 'package:InOut/core/utils/validator.dart';
import 'package:InOut/core/widgets/button_full_width.dart';
import 'package:InOut/core/widgets/text_field_form.dart';
import 'package:InOut/presentation/bloc/register_screen/register_screen_bloc.dart';
import 'package:InOut/presentation/bloc/register_screen/register_screen_event.dart';
import 'package:InOut/presentation/bloc/register_screen/register_screen_state.dart';
import 'package:InOut/presentation/pages/dashboard_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.nameController,
    required this.passwordController,
    required this.passwordConfirmController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  Future<void> _initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 48),
                    TextFieldForm(
                      title: "Email",
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Field is required!';
                        }
                        if (!val.validEmail) {
                          return 'Email is invalid';
                        }
                        return null;
                      },
                      controller: widget.emailController,
                    ),
                    TextFieldForm(
                      title: "Name",
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Field is required!';
                        }
                        if (!val.validName) {
                          return 'Name is invalid';
                        }
                        return null;
                      },
                      controller: widget.nameController,
                    ),
                    TextFieldForm(
                      title: "Password",
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Field is required!';
                        }
                        if (!val.validPassword) {
                          return "Password is invalid";
                        }
                        return null;
                      },
                      controller: widget.passwordController,
                      obscureText: true,
                    ),
                    TextFieldForm(
                      title: "Password Confirmation",
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Field is required!';
                        }
                        if (val != widget.passwordController.text) {
                          return "Password doesn't match";
                        }
                        return null;
                      },
                      controller: widget.passwordConfirmController,
                      obscureText: true,
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<RegisterScreenBloc, RegisterScreenState>(
              builder: (context, state) {
                if (state is RegisterUserLoading) {
                  return ButtonFullWidth(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    child: const CupertinoActivityIndicator(
                      color: Colors.white,
                    ),
                  );
                }

                if (state is RegisterUserError) {
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

                if (state is RegisterUserLoaded) {
                  BlocProvider.of<RegisterScreenBloc>(context).add(
                    FetchLoginUser(
                      LoginUserParams(
                        email: state.user.email!,
                        password: widget.passwordController.text,
                      ),
                    ),
                  );

                  return ButtonFullWidth(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                    ),
                    child: const CupertinoActivityIndicator(
                      color: Colors.white,
                    ),
                  );
                }

                if (state is RegisterUserLoginLoaded) {
                  prefs.setString("token", state.token.token!);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const DashboardScreen(),
                      ),
                    );
                  });
                }

                return ButtonFullWidth(
                  onPressed: () {
                    if (widget._formKey.currentState!.validate()) {
                      BlocProvider.of<RegisterScreenBloc>(context).add(
                        FetchRegisterUser(
                          RegisterUserParams(
                            email: widget.emailController.text,
                            name: widget.nameController.text,
                            password: widget.passwordController.text,
                            passwordConfirm:
                                widget.passwordConfirmController.text,
                          ),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text(
                    "Next",
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
    );
  }
}
