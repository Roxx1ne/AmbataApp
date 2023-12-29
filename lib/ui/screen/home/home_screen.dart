import 'package:ambataapp/data/model/pastry.dart';
import 'package:ambataapp/ui/screen/home/cubit/home_cubit.dart';
import 'package:ambataapp/ui/screen/notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeCubit>().state;
    return _homeContent(state);
  }

  Widget _homeContent(HomeUiState uiState) {
    switch (uiState) {
      case Loading():
        return const Center(
          child: CircularProgressIndicator(),
        );
      case Success():
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
                GestureDetector(
                  onTap: () {
                    context.go("/home/notification");
                  },
                  child: Icon(
                    Icons.notifications_outlined,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(
                  width: 22.0,
                ),
                IconButton(
                  onPressed: () {
                    context.go("/home/cart");
                  },
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(
                  width: 22.0,
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
              child: SizedBox(
                height: 221,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    for (var pastry in uiState.data.sublist(0, 5)) ...[
                      HomePastryCard(
                        pastry: pastry,
                      ),
                    ],
                  ],
                ),
              ),
            ),
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
                    for (var pastry in uiState.data.sublist(13, 20)) ...[
                      HomePastryCardVariant(
                        pastry: pastry,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        );
      case Error():
        return Center(
          child: Text(uiState.message),
        );
    }
  }
}

class HomePastryCard extends StatelessWidget {
  final Pastry pastry;

  const HomePastryCard({super.key, required this.pastry});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        context.go("/home/detail/${pastry.id}");
      },
      child: Card(
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
              stops: const [0.0, 0.5, 0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SizedBox(
            height: 160,
            width: 176,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  HomePastryCircleImage(
                    imageUrl: pastry.imageUrl,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    pastry.name,
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
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
    return InkWell(
      onTap: () {
        context.go("/home/detail/${pastry.id}");
      },
      child: SizedBox(
        height: 160,
        width: 176,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16.0,
              ),
              HomePastryCircleImage(imageUrl: pastry.imageUrl),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                pastry.name,
                style: textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePastryCircleImage extends StatelessWidget {
  const HomePastryCircleImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CircleAvatar(
      backgroundColor: colorScheme.onSecondaryContainer,
      backgroundImage: NetworkImage(imageUrl),
      radius: 72,
    );
  }
}
