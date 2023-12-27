import 'package:ambataapp/data/model/pastry.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/currency_formatter.dart';
import '../../../data/repository/cart/cart_repository.dart';
import '../../component/root.dart';
import 'cubit/cart_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<CartCubit>().state;
    return _homeContent(state);
  }

  Widget _homeContent(CartUiState uiState) {
    switch (uiState) {
      case Loading():
        return const Center(
          child: CircularProgressIndicator(),
        );
      case Success():
        final colorScheme = Theme.of(context).colorScheme;
        final textTheme = Theme.of(context).textTheme;
        return AmbataScaffold(
          child: Column(
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
                title: const Text('Cart'),
                backgroundColor: colorScheme.surface,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 52,
                      child: TextButton(
                        onPressed: () {
                          context.read<CartRepository>().removeAll();
                        },
                        style: const ButtonStyle(
                            splashFactory: NoSplash.splashFactory),
                        child: Text(
                          'Remove all',
                          style: textTheme.titleSmall
                              ?.copyWith(color: colorScheme.onErrorContainer),
                        ),
                      ),
                    ),
                    const Divider(),
                    for (var entry in uiState.data.entries) ...[
                      CartPastryItem(
                        pastry: entry.key,
                        quantity: entry.value,
                      )
                    ],
                  ],
                ),
              ),
              Checkout(
                  totalPrice:
                      uiState.data.keys.map((pastry) => pastry.price).sum)
            ],
          ),
        );
      case Error():
        return Center(
          child: Text(uiState.message),
        );
    }
  }
}

class CartPastryItem extends StatelessWidget {
  const CartPastryItem(
      {super.key, required this.pastry, required this.quantity});

  final Pastry pastry;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      height: 120.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4), // Image border
              child: Image(
                image: NetworkImage(pastry.imageUrl),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  pastry.name,
                  style: textTheme.titleSmall
                      ?.copyWith(color: colorScheme.secondary),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  CurrencyFormatter.convertToIdr(pastry.price, 2),
                  style: textTheme.titleSmall,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                PastryQuantityChange(
                  initialQuantity: quantity,
                  onQuantityChanged: (quantity) {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PastryQuantityChange extends StatefulWidget {
  const PastryQuantityChange(
      {super.key,
      required this.initialQuantity,
      required this.onQuantityChanged});

  final int initialQuantity;
  final Function(int) onQuantityChanged;

  @override
  State<PastryQuantityChange> createState() => _PastryQuantityChangeState();
}

class _PastryQuantityChangeState extends State<PastryQuantityChange> {
  var quantity = 0;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
          border: Border.all(
            color: colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (quantity > 0) {
                  quantity--;
                }
              });

              widget.onQuantityChanged(quantity);
            },
            icon: Icon(
              Icons.remove,
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

              widget.onQuantityChanged(quantity);
            },
            icon: Icon(
              Icons.add,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class Checkout extends StatelessWidget {
  const Checkout({super.key, required this.totalPrice});

  final double totalPrice;

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total',
                  style: textTheme.titleSmall
                      ?.copyWith(color: colorScheme.secondary),
                ),
                Text(
                  CurrencyFormatter.convertToIdr(totalPrice, 2),
                  style: textTheme.titleMedium,
                ),
              ],
            ),
            FilledButton(
              onPressed: () {},
              child: Text(
                'Checkout',
                style: textTheme.labelLarge
                    ?.copyWith(color: colorScheme.onPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
