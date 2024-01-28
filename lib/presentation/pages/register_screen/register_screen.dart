import 'package:InOut/core/widgets/appbar_custom.dart';
import 'package:InOut/injection.dart';
import 'package:InOut/presentation/bloc/register_screen/register_screen_bloc.dart';
import 'package:InOut/presentation/bloc/register_screen/register_screen_state.dart';
import 'package:InOut/presentation/pages/register_screen/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarCustom(
        middle: Text("Get Started"),
      ),
      body: BlocProvider(
        create: (context) => inject<RegisterScreenBloc>(),
        child: BlocBuilder<RegisterScreenBloc, RegisterScreenState>(
          builder: (context, state) {
            return const RegisterForm();
          },
        ),
      ),
    );
  }
}
