import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../data/model/user.dart';
import '../../../data/repository/authentication/authentication_repository.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        AppBar(
          title: Text('Account', style: textTheme.titleLarge),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthenticationRepository>().signOut();
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: FutureBuilder<User>(
                future: context.read<AuthenticationRepository>().currentUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final user = snapshot.data!;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: colorScheme.primaryContainer,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Icon(
                                  Icons.account_circle_rounded,
                                  color: colorScheme.onSurface,
                                  size: 50,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    user.name ?? 'Username',
                                    style: textTheme.bodyMedium,
                                  ),
                                  Text(
                                    user.email ?? 'Email',
                                    style: textTheme.labelSmall,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 16.0,
                            ),
                            const Icon(
                              Icons.link,
                            ),
                          ],
                        )
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text('An error occured'),
                    );
                  }
                },
              )),
        ),
        const Divider(),
        SizedBox(
          height: 40.0,
          width: double.infinity,
          child: InkWell(
            onTap: () {
              GoRouter.of(context).go("/account/transaction");
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.receipt_long),
                  const SizedBox(width: 16.0),
                  Text(
                    'Recent Transaction',
                    style: textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
