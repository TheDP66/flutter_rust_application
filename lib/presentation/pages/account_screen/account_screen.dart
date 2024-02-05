import 'package:InOut/injection.dart';
import 'package:InOut/main.dart';
import 'package:InOut/presentation/bloc/account_screen/account_screen_bloc.dart';
import 'package:InOut/presentation/bloc/account_screen/account_screen_event.dart';
import 'package:InOut/presentation/bloc/account_screen/account_screen_state.dart';
import 'package:InOut/presentation/pages/account_screen/widgets/account_card.dart';
import 'package:InOut/presentation/pages/login_screen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? token;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  Future<void> _initializePrefs() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
      token = prefs.getString("token");
    });
  }

  Future<void> _logoutUser() async {
    prefs.remove("token");

    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => inject<AccountScreenBloc>()
        ..add(
          FetchMeUser(),
        ),
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          border: Border.all(
            width: 0,
            color: Colors.transparent,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              const Text(
                "Account detail",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12),
                child: BlocBuilder<AccountScreenBloc, AccountScreenState>(
                  buildWhen: (prev, curr) {
                    if (curr is AccountLoading ||
                        curr is AccountLoaded ||
                        curr is AccountError) {
                      return true;
                    }

                    return false;
                  },
                  builder: (context, state) {
                    if (state is AccountLoading) {
                      return const AccountCard(
                        loading: true,
                      );
                    }

                    if (state is AccountLoaded) {
                      return AccountCard(
                        loading: false,
                        user: state.user,
                      );
                    }

                    if (state is AccountError) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.all(20),
                            content: Text(state.message),
                          ),
                        );
                      });

                      return Expanded(
                        child: Column(
                          children: [
                            const Opacity(
                              opacity: .8,
                              child: Text("Fetching failed"),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.refresh),
                              label: const Text("Try again"),
                            ),
                          ],
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              SizedBox(
                width: double.infinity,
                child: Expanded(
                  child: BlocBuilder<AccountScreenBloc, AccountScreenState>(
                    builder: (context, state) {
                      if (state is LogoutLoading) {
                        return TextButton(
                          onPressed: () {},
                          child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.grey,
                            ),
                          ),
                        );
                      }

                      if (state is LogoutLoaded) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _logoutUser();
                        });
                      }

                      if (state is LogoutError) {
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

                      return TextButton.icon(
                        style: TextButton.styleFrom(
                          iconColor: Colors.red[400],
                          foregroundColor: Colors.red[400],
                        ),
                        onPressed: () => {
                          BlocProvider.of<AccountScreenBloc>(context).add(
                            LogoutUser(),
                          )
                        },
                        icon: const Icon(Icons.logout),
                        label: Text(
                          "Log out",
                          style: TextStyle(
                            color: Colors.red[400],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
