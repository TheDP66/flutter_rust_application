import 'package:InOut/core/params/auth_params.dart';
import 'package:InOut/core/utils/validator.dart';
import 'package:InOut/core/widgets/button_full_width.dart';
import 'package:InOut/core/widgets/layout_app.dart';
import 'package:InOut/core/widgets/text_field_form.dart';
import 'package:InOut/injection.dart';
import 'package:InOut/presentation/bloc/login_screen/login_screen_bloc.dart';
import 'package:InOut/presentation/bloc/login_screen/login_screen_event.dart';
import 'package:InOut/presentation/bloc/login_screen/login_screen_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final _formKey = GlobalKey<FormState>();
  late SharedPreferences prefs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> _initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _redirectDashboard() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LayoutApp(),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => inject<LoginScreenBloc>(),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            children: [
              TextFieldForm(
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
              BlocBuilder<LoginScreenBloc, LoginScreenState>(
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

                  if (state is LoginUserError) {
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

                  if (state is LoginUserLoaded) {
                    _redirectDashboard();
                  }

                  return ButtonFullWidth(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
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
    );
  }
}
