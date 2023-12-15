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
  final Set<PastryCategory> _selectedCategory = {PastryCategory.none};

  late List<Pastry> _pastries;
  late List<PastryCategory> _pastryCategory;

  @override
  void initState() {
    super.initState();

    _pastries = context.read<DefaultPastryRepository>().getPastries();
    _pastryCategory = PastryCategory.values
        .where((pastry) => pastry != PastryCategory.none)
        .toList();
  }

  Widget searchContent(bool isSearched) {
    if (isSearched) {
      final pastries = _pastries
          .where((pastry) =>
              _selectedCategory.every((pastry) => pastry == PastryCategory.none)
                  ? true
                  : _selectedCategory.contains(pastry.category))
          .where((pastry) => _query.isEmpty
              ? true
              : pastry.name.toLowerCase().contains(_query))
          .toList();

      return SearchPastriesContent(
        pastries: pastries,
        categories: _pastryCategory,
        selectedCategories: _selectedCategory,
        onSelectedFilter: (selected, category) {
          setState(() {
            if (selected) {
              _selectedCategory.add(category);
            } else {
              _selectedCategory.remove(category);
              if (_selectedCategory.isEmpty) {
                _selectedCategory.add(PastryCategory.none);
              }
            }
          });
        },
      );
    } else {
      return SearchCategoriesContent(
        categories: _pastryCategory,
        onSelectedCategory: (category) {
          setState(() {
            _isSearched = true;
            _selectedCategory.add(category);
          });
        },
      );
    }
  }

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
  final List<PastryCategory> categories;
  final Set<PastryCategory> selectedCategories;
  final Function(bool, PastryCategory) onSelectedFilter;

  const SearchPastriesContent(
      {super.key,
      required this.pastries,
      required this.selectedCategories,
      required this.onSelectedFilter,
      required this.categories});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Flexible(
      child: Column(
        children: [
          Container(
            height: 32,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const Icon(Icons.filter_list_rounded),
                const SizedBox(
                  width: 8.0,
                ),
                Container(
                  height: 4.0,
                  width: 1.0,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Row(
                  children: [
                    for (var category in categories) ...[
                      FilterChip(
                        label: Text(
                          category.name,
                          style: textTheme.labelLarge,
                        ),
                        backgroundColor: colorScheme.surface,
                        selected: selectedCategories.contains(category),
                        onSelected: (selected) {
                          onSelectedFilter(selected, category);
                        },
                      ),
                      const SizedBox(
                        width: 16.0,
                      )
                    ],
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          if (pastries.isNotEmpty) ...[
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
          ] else ...[
            const SearchPastriesEmpty(),
          ]
        ],
      ),
    );
  }
}

class SearchPastriesEmpty extends StatelessWidget {
  const SearchPastriesEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          'No pastry found :(',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
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
  final List<PastryCategory> categories;
  final Function(PastryCategory) onSelectedCategory;

  const SearchCategoriesContent(
      {super.key, required this.categories, required this.onSelectedCategory});

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
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    onSelectedCategory(categories[index]);
                  },
                  child: SearchCategoryCard(
                    category: categories[index].name,
                  ),
                )),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}

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
