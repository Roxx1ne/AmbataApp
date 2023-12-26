import 'package:ambataapp/common/currency_formatter.dart';
import 'package:ambataapp/data/model/pastry.dart';
import 'package:ambataapp/data/repository/cart/cart_repository.dart';
import 'package:ambataapp/data/repository/pastry/pastry_repository.dart';
import 'package:ambataapp/ui/component/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Pastry?> _pastry;

  @override
  void initState() {
    super.initState();

    _pastry = context.read<PastryRepository>().getPastryById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return AmbataScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBar(
            leading: IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_rounded,
                color: colorScheme.onSurface,
              ),
            ),
            backgroundColor: colorScheme.surface,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<Pastry?>(
              future: _pastry,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final pastry = snapshot.data!;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image(
                              image:NetworkImage(pastry.imageUrl),
                              width: double.infinity,
                              height: 240,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                pastry.name,
                                style: textTheme.titleLarge
                                    ?.copyWith(color: colorScheme.secondary),
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                CurrencyFormatter.convertToIdr(pastry.price, 2),
                                style: textTheme.titleMedium,
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                'Description',
                                style: textTheme.titleSmall,
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                pastry.description,
                                style: textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AddToCart(
                        onAddToCart: (quantity) {
                          context
                              .read<CartRepository>()
                              .add(pastry, quantity);
                        },
                      )
                    ],
                  );
                } else {
                  return const Center(
                    child: Text('An error occured'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AddToCart extends StatefulWidget {
  const AddToCart({super.key, required this.onAddToCart});

  final Function(int) onAddToCart;

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  var quantity = 1;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: colorScheme.surface,
      height: 56.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Text(
                'Qty',
                style: textTheme.titleSmall,
              ),
            ),
            Flexible(
              flex: 2,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (quantity > 0) {
                          quantity--;
                        }
                      });
                    },
                    icon: Icon(
                      Icons.remove_circle_outline_rounded,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    '$quantity',
                    style: textTheme.titleSmall,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    icon: Icon(
                      Icons.add_circle_outline_rounded,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: FilledButton(
                onPressed: () {
                  widget.onAddToCart(quantity);
                },
                child: Text(
                  'Add to Cart',
                  style: textTheme.labelLarge
                      ?.copyWith(color: colorScheme.onPrimary),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
