import 'package:InOut/injection.dart';
import 'package:InOut/main.dart';
import 'package:InOut/presentation/bloc/account_screen/account_screen_bloc.dart';
import 'package:InOut/presentation/bloc/account_screen/account_screen_event.dart';
import 'package:InOut/presentation/bloc/account_screen/account_screen_state.dart';
import 'package:InOut/presentation/pages/account_screen/widgets/account_detail_section.dart';
import 'package:InOut/presentation/pages/account_screen/widgets/account_profile_picture.dart';
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
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  Future<void> _initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> _logoutUser() async {
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
        body: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<AccountScreenBloc>(context).add(
              FetchMeUser(),
            );
          },
          child: Padding(
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
                  height: 24,
                ),
                const AccountProfilePicture(),
                const SizedBox(
                  height: 24,
                ),
                const AccountDetailSection(),
                const SizedBox(
                  height: 36,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Expanded(
                    child: BlocConsumer<AccountScreenBloc, AccountScreenState>(
                      listener: (context, state) {
                        if (state is LogoutLoaded) {
                          _logoutUser();
                        }

                        if (state is LogoutError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              margin: const EdgeInsets.all(20),
                              content: Text(state.message),
                            ),
                          );
                        }
                      },
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

                        return TextButton.icon(
                          style: TextButton.styleFrom(
                            iconColor: Colors.red[400],
                            foregroundColor: Colors.red[400],
                          ),
                          onPressed: () {
                            BlocProvider.of<AccountScreenBloc>(context).add(
                              LogoutUser(),
                            );
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
      ),
    );
  }
}
