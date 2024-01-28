import 'package:InOut/core/widgets/appbar_custom.dart';
import 'package:InOut/injection.dart';
import 'package:InOut/presentation/bloc/register_screen/register_screen_bloc.dart';
import 'package:InOut/presentation/bloc/register_screen/register_screen_state.dart';
import 'package:InOut/presentation/pages/register_screen/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late SharedPreferences prefs;
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

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
    return Scaffold(
      appBar: const AppbarCustom(),
      body: BlocProvider(
        create: (context) => inject<RegisterScreenBloc>(),
        child: BlocBuilder<RegisterScreenBloc, RegisterScreenState>(
          builder: (context, state) {
            return RegisterForm(
              formKey: _formKey,
              emailController: emailController,
              nameController: nameController,
              passwordController: passwordController,
              passwordConfirmController: passwordConfirmController,
            );
          },
        ),
      ),
    );
  }
}
