import 'package:ambataapp/ui/component/root.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool markAllAsReadClicked = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return AmbataScaffold(
      appBar: AppBar(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  markAllAsReadClicked = true;
                });
              },
              child: Text(
                'Mark all as read',
                style: textTheme.labelMedium
                    ?.copyWith(color: colorScheme.onSurfaceVariant),
              ),
            ),
          ),
        ],
      ),
      child: Column(
        children: [
          NotificationItemContainer(
            isRead: markAllAsReadClicked ? true : false,
            icon: const Icon(Icons.receipt_long_rounded),
            label: Text(
              'Promo',
              style:
                  textTheme.labelSmall?.copyWith(color: colorScheme.secondary),
            ),
            title: Text(
              'Holidays Discount',
              style: textTheme.titleSmall,
            ),
            body: Text(
              'Indulge in the sweetness of the holiday season with our tempting offer! Enjoy a delightful 35% discount on all our heavenly cakes at Ambata Bakery. Satisfy your cravings guilt-free and add some extra sweetness to your holidays!',
              style: textTheme.bodySmall,
              overflow: TextOverflow.visible,
            ),
          ),
          const Divider(
            height: 4.0,
          ),
          NotificationItemContainer(
            isRead: markAllAsReadClicked ? true : true,
            icon: const Icon(Icons.receipt_long_rounded),
            label: Text(
              'Promo',
              style:
                  textTheme.labelSmall?.copyWith(color: colorScheme.secondary),
            ),
            title: Text(
              'Weekend Discount',
              style: textTheme.titleSmall,
            ),
            body: Text(
              'Craving something sweet? Indulge guilt-free with a delightful 20% discount on all our heavenly cakes this weekend at Ambata Bakery!',
              style: textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationItemContainer extends StatelessWidget {
  const NotificationItemContainer({
    super.key,
    this.isRead = false,
    required this.icon,
    required this.label,
    required this.title,
    required this.body,
  });

  final bool isRead;
  final Widget icon;
  final Widget label;
  final Widget title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      color: isRead ? colorScheme.background : colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const SizedBox(
              width: 8.0,
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  label,
                  const SizedBox(
                    height: 8.0,
                  ),
                  title,
                  const SizedBox(
                    height: 8.0,
                  ),
                  body
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
