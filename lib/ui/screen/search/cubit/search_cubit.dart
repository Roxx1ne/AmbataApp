import 'dart:async';

import 'package:ambataapp/data/repository/pastry/pastry_repository.dart';
import 'package:ambataapp/ui/screen/search/filter.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../data/model/pastry.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchUiState> {
  SearchCubit(
    this._pastryRepository,
    this._filter,
  ) : super(Loading()) {
    _query.sink.add('');
    _categories.sink.add(_selectedCategories);
    _subscribe();
    _pastryRepository.getAllPastries();
  }

  final PastryRepository _pastryRepository;
  final SearchFilter _filter;

  late final StreamSubscription _subscription;

  bool _isSearched = false;

  final _query = StreamController<String>();
  final Set<PastryCategory> _selectedCategories = {PastryCategory.none};
  final _categories = StreamController<Set<PastryCategory>>();

  void setQuery(String query) {
    _query.sink.add(query);
    if (!_isSearched) {
      _isSearched = true;
    }
  }

  void addSelectedCategories(PastryCategory category) {
    _selectedCategories.add(category);
    if (!_isSearched) {
      _isSearched = true;
    }
    _categories.sink.add(_selectedCategories);
  }

  void removeSelectedCategories(PastryCategory category) {
    _selectedCategories.remove(category);
    if (_selectedCategories.isEmpty) {
      _selectedCategories.add(PastryCategory.none);
    }

    if (!_isSearched) {
      _isSearched = true;
    }

    _categories.sink.add(_selectedCategories);
  }

  void _subscribe() {
    _subscription = CombineLatestStream.combine3(
        _pastryRepository.pastries, _query.stream, _categories.stream,
        (pastries, query, categories) {
      final pastriesByCategories =
          _filter.filterByCategories(pastries, categories);

      final pastriesByCategoriesAndName =
          _filter.filterByName(pastriesByCategories, query);

      return Success(
        _isSearched,
        categories,
        pastriesByCategoriesAndName,
      );
    }).listen(
      (uiState) {
        emit(uiState);
      },
      onError: (error) => emit(Error(message: '$error')),
    );
  }

  @override
  Future<void> close() async {
    _subscription.cancel();
    super.close();
  }
}
