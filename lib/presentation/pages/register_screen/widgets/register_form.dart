import 'package:InOut/core/params/auth_params.dart';
import 'package:InOut/core/utils/validator.dart';
import 'package:InOut/core/widgets/button_full_width.dart';
import 'package:InOut/core/widgets/text_field_form.dart';
import 'package:InOut/presentation/bloc/register_screen/register_screen_bloc.dart';
import 'package:InOut/presentation/bloc/register_screen/register_screen_event.dart';
import 'package:InOut/presentation/bloc/register_screen/register_screen_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                      controller: emailController,
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
                      controller: nameController,
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
                      controller: passwordController,
                      obscureText: true,
                    ),
                    TextFieldForm(
                      title: "Password Confirmation",
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Field is required!';
                        }
                        if (val != passwordController.text) {
                          return "Password does'nt match";
                        }
                        return null;
                      },
                      controller: passwordConfirmController,
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
                  print("present register error: ${state.message}");

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
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(20),
                        content: Text(state.user.name ?? "null"),
                      ),
                    );
                  });
                }

                return ButtonFullWidth(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<RegisterScreenBloc>(context).add(
                        FetchRegisterUser(
                          RegisterUserParams(
                            email: emailController.text,
                            name: nameController.text,
                            password: passwordController.text,
                            passwordConfirm: passwordConfirmController.text,
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
