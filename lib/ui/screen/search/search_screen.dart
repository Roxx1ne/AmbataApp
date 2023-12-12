import 'package:ambataapp/data/repository/pastry_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/pastry.dart';
import '../../component/root.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isSearched = false;
  String _query = '';

  late List<Pastry> _pastries;

  @override
  void initState() {
    super.initState();

    _pastries = context.read<DefaultPastryRepository>().getPastries();
  }

  final categories = ['Bread', 'Cake', 'Donut', 'Local'];

  Widget searchContent(bool isSearched) => isSearched
      ? SearchPastriesContent(pastries: _pastries)
      : SearchCategoriesContent(categories: categories);

  @override
  Widget build(BuildContext context) {
    return AmbataScaffold(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBar(onSearch: (query) {
              setState(() {
                _isSearched = true;
                _query = query;
              });
            }),
            const SizedBox(
              height: 24.0,
            ),
            searchContent(
              _isSearched,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPastriesContent extends StatelessWidget {
  final List<Pastry> pastries;

  const SearchPastriesContent({super.key, required this.pastries});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          SizedBox(
            height: 32.0,
            child: Container(
              color: Colors.lightGreenAccent,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Flexible(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: pastries.length,
              padding: const EdgeInsets.only(bottom: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.475,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) =>
                  SearchPastryCard(pastry: pastries[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchPastryCard extends StatelessWidget {
  final Pastry pastry;

  const SearchPastryCard({super.key, required this.pastry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Image(
            //   image:,
            //   width: 189.5,
            //   height: 189.5,
            //   fit: BoxFit.cover,
            // ),
            SizedBox(
              width: 189.5,
              height: 189.5,
              child: Container(
                color: colorScheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(
              height: 2.0,
            ),
            Container(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pastry.name,
                    style: textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    '${pastry.price}',
                    style: textTheme.bodySmall,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SearchCategoriesContent extends StatelessWidget {
  final List<String> categories;

  const SearchCategoriesContent({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          'Categories',
          style: textTheme.headlineSmall,
        ),
        const SizedBox(
          height: 16.0,
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.35 / 1,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) => SearchCategoryCard(
            category: categories[index],
          ),
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}

// TODO: Clickable to SearchPastriesContent with clicked category for filter
class SearchCategoryCard extends StatelessWidget {
  const SearchCategoryCard({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.primary, colorScheme.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              category,
              style: textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            CircleAvatar(
              backgroundColor: colorScheme.onSecondaryContainer,
              radius: 72,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({super.key, required this.onSearch});

  final ValueSetter<String> onSearch;

  @override
  State<StatefulWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _isClearButtonVisible = false;

  final SearchController _searchController = SearchController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _isClearButtonVisible = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final containerColor = colorScheme.surfaceVariant;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(50.0),
      ),
      height: 56.0,
      child: Center(
        child: TextField(
          enableSuggestions: false,
          autocorrect: false,
          controller: _searchController,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) {
            widget.onSearch(_searchController.text);
          },
          decoration: InputDecoration(
            prefixIcon: const SizedBox(
              width: 4.0,
              height: 4.0,
            ),
            hintText: 'Search...',
            hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
            labelStyle: TextStyle(color: colorScheme.onSurface),
            // Add a clear button to the search bar
            suffixIcon: _isClearButtonVisible
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _searchController.clear(),
                  )
                : const Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
