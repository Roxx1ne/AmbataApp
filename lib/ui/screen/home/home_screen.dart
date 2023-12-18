import 'package:ambataapp/data/model/pastry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/pastry_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Pastry> _pastries;

  @override
  void initState() {
    super.initState();

    _pastries = context.read<DefaultPastryRepository>().getPastries();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          title: Text(
            'Freshly Baked',
            style: textTheme.titleLarge,
          ),
          backgroundColor: colorScheme.surface,
          actions: [
            Icon(
              Icons.notifications_outlined,
              color: colorScheme.onSurface,
            ),
            const SizedBox(
              width: 22.0,
            ),
            Icon(
              Icons.shopping_cart_outlined,
              color: colorScheme.onSurface,
            ),
            const SizedBox(
              width: 22.0,
            ),
            Icon(
              Icons.settings_outlined,
              color: colorScheme.onSurface,
            ),
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Special Picks',
            style: textTheme.headlineSmall,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Flexible(
            child: Container(
          height: 221,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              for (var pastry in _pastries.sublist(0, 5)) ...[
                HomePastryCard(
                  pastry: pastry,
                ),
              ],
            ],
          ),
        )),
        const SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Popular',
            style: textTheme.headlineSmall,
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
        Flexible(
            child: SizedBox(
          height: 221,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              for (var pastry in _pastries.sublist(10, 15)) ...[
                HomePastryCardVariant(
                  pastry: pastry,
                ),
              ],
            ],
          ),
        )),
      ],
    );
  }
}

class HomePastryCard extends StatelessWidget {
  final Pastry pastry;

  const HomePastryCard({super.key, required this.pastry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colorScheme.primary,
              colorScheme.secondary,
              colorScheme.surface,
              colorScheme.surface,
            ],
            stops: [0.0, 0.5, 0.5, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SizedBox(
            height: 160,
            width: 176,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16.0,
                  ),
                  HomePastryCircleImage(),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    pastry.name,
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class HomePastryCardVariant extends StatelessWidget {
  final Pastry pastry;

  const HomePastryCardVariant({super.key, required this.pastry});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
        height: 160,
        width: 176,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 16.0,
              ),
              HomePastryCircleImage(),
              SizedBox(
                height: 8.0,
              ),
              Text(
                pastry.name,
                style: textTheme.titleMedium,
              ),
            ],
          ),
        ));
  }
}

class HomePastryCircleImage extends StatelessWidget {
  const HomePastryCircleImage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CircleAvatar(
      backgroundColor: colorScheme.onSecondaryContainer,
      radius: 72,
    );
  }
}
