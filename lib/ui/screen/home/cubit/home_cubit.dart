import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../../data/model/pastry.dart';
import '../../../../data/repository/pastry/pastry_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeUiState> {
  HomeCubit(
    this._pastryRepository,
  ) : super(Loading()) {
    _subscribe();
    _pastryRepository.getAllPastries();
  }

  final PastryRepository _pastryRepository;

  late final StreamSubscription _subscription;

  void _subscribe() {
    _subscription = _pastryRepository.pastries.listen(
      (pastries) {
        emit(Success(pastries));
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
