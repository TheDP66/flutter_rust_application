import 'package:InOut/core/constant/url.dart';
import 'package:InOut/injection.dart';
import 'package:InOut/main.dart';
import 'package:InOut/presentation/bloc/account_screen/account_screen_bloc.dart';
import 'package:InOut/presentation/bloc/account_screen/account_screen_event.dart';
import 'package:InOut/presentation/bloc/account_screen/account_screen_state.dart';
import 'package:InOut/presentation/pages/account_screen/widgets/account_bottom_sheet.dart';
import 'package:InOut/presentation/pages/account_screen/widgets/account_card.dart';
import 'package:InOut/presentation/pages/login_screen/login_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

  void _photoSheet(BuildContext context) async {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) => AccountBottomSheet(
        items: [
          ListItem(
            icon: Icons.image_outlined,
            text: 'New profile picture',
            onTap: () {
              print('Sending email...');
              // Implement your email sending logic here
            },
          ),
          ListItem(
            icon: Icons.delete_outline,
            iconColor: Colors.red[500],
            text: 'Remove current picture',
            onTap: () {
              print('Making phone call...');
              // Implement your phone call logic here
            },
          ),
        ],
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
              GestureDetector(
                onTap: () {
                  _photoSheet(context);
                },
                child: Center(
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey[600]!,
                    child: Container(
                      height: 70,
                      width: 70,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: BlocBuilder<AccountScreenBloc, AccountScreenState>(
                        builder: (context, state) {
                          return CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: state is AccountLoaded
                                ? "$baseUrl/storage/img/${state.user.photo!}"
                                : "",
                            errorWidget: (context, url, error) => const Icon(
                              Icons.person,
                              size: 45,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    _photoSheet(context);
                  },
                  child: const Text(
                    "Edit picture",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
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
