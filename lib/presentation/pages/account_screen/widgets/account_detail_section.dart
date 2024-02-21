import 'package:InOut/presentation/bloc/account_screen/account_screen_bloc.dart';
import 'package:InOut/presentation/bloc/account_screen/account_screen_event.dart';
import 'package:InOut/presentation/bloc/account_screen/account_screen_state.dart';
import 'package:InOut/presentation/pages/account_screen/widgets/account_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountDetailSection extends StatelessWidget {
  const AccountDetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: BlocConsumer<AccountScreenBloc, AccountScreenState>(
        listener: (context, state) {
          if (state is AccountError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(20),
                content: Text(state.message),
              ),
            );
          }
        },
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
            return Expanded(
              child: Column(
                children: [
                  const Opacity(
                    opacity: .8,
                    child: Text("Fetching failed"),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      BlocProvider.of<AccountScreenBloc>(context).add(
                        FetchMeUser(),
                      );
                    },
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
    );
  }
}
