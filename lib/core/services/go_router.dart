import 'package:InOut/core/widgets/scaffold_with_navbar.dart';
import 'package:InOut/presentation/pages/account_screen/account_screen.dart';
import 'package:InOut/presentation/pages/dashboard_screen/dashboard_screen.dart';
import 'package:InOut/presentation/pages/explore_screen/explore_screen.dart';
import 'package:InOut/presentation/pages/login_screen/login_screen.dart';
import 'package:InOut/presentation/pages/offline_package_screen/offline_package_screen.dart';
import 'package:InOut/presentation/pages/package_screen/package_screen.dart';
import 'package:InOut/presentation/pages/profile_screen/profile_screen.dart';
import 'package:InOut/presentation/pages/register_screen/register_screen.dart';
import 'package:InOut/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter goRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: "/splash",
  routes: _routes,
);

final _routes = <RouteBase>[
  GoRoute(
    name: "splash",
    path: "/splash",
    builder: (BuildContext context, GoRouterState state) {
      return const SplashScreen();
    },
  ),
  GoRoute(
    name: "login",
    path: "/login",
    builder: (BuildContext context, GoRouterState state) {
      return const LoginScreen();
    },
  ),
  GoRoute(
    name: "register",
    path: "/register",
    builder: (BuildContext context, GoRouterState state) {
      return const RegisterScreen();
    },
  ),
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return ScaffoldWithNavbar(
        navigationShell: navigationShell,
      );
    },
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: "/dashboard",
            builder: (context, state) => const DashboardScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: "/explore",
            builder: (context, state) => const ExploreScreen(),
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: "/profile",
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
    ],
  ),
  GoRoute(
    name: "package",
    path: "/package",
    builder: (BuildContext context, GoRouterState state) {
      return const PackageScreen();
    },
  ),
  GoRoute(
    name: "account",
    path: "/account",
    builder: (BuildContext context, GoRouterState state) {
      return const AccountScreen();
    },
  ),
  GoRoute(
    name: "offline-package",
    path: "/offline-package",
    builder: (BuildContext context, GoRouterState state) {
      return const OfflinePackageScreen();
    },
  ),
];
