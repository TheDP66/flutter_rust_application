import 'package:InOut/core/params/auth_params.dart';
import 'package:InOut/core/utils/validator.dart';
import 'package:InOut/core/widgets/button_full_width.dart';
import 'package:InOut/core/widgets/text_field_form.dart';
import 'package:InOut/injection.dart';
import 'package:InOut/presentation/bloc/login_screen/login_screen_bloc.dart';
import 'package:InOut/presentation/bloc/login_screen/login_screen_event.dart';
import 'package:InOut/presentation/bloc/login_screen/login_screen_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.isKeyboardOpen,
  });

  final bool isKeyboardOpen;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  static final _formKey = GlobalKey<FormState>();
  late SharedPreferences prefs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _redirectDashboard(BuildContext context) async {
    context.go("/dashboard");
  }

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => inject<LoginScreenBloc>(),
      child: AutofillGroup(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Column(
              children: [
                TextFieldForm(
                  autofillHints: const [
                    AutofillHints.email,
                  ],
                  title: "Email",
                  key: const Key("email"),
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
                  autofillHints: const [
                    AutofillHints.password,
                  ],
                  keyboardType: TextInputType.visiblePassword,
                  title: "Password",
                  key: const Key("password"),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Field is required!';
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: true,
                ),
                widget.isKeyboardOpen
                    ? const Expanded(
                        child: SizedBox(),
                      )
                    : const SizedBox(),
                BlocConsumer<LoginScreenBloc, LoginScreenState>(
                  listener: (context, state) {
                    if (state is LoginUserError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(20),
                          content: Text("Wrong email/password!"),
                        ),
                      );
                    }

                    if (state is LoginUserLoaded) {
                      _redirectDashboard(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginUserLoading) {
                      return ButtonFullWidth(
                        style: ElevatedButton.styleFrom(
                            // backgroundColor: Colors.blueAccent,
                            ),
                        child: const CupertinoActivityIndicator(
                          color: Colors.white,
                        ),
                      );
                    }

                    return ButtonFullWidth(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          TextInput.finishAutofillContext();

                          BlocProvider.of<LoginScreenBloc>(context).add(
                            FetchLoginUser(
                              LoginUserParams(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
