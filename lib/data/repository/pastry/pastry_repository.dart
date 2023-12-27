import 'dart:async';

import 'package:ambataapp/data/model/pastry.dart';

abstract class PastryRepository {
  Stream<List<Pastry>> get pastries;

  void getAllPastries();

  Future<Pastry?> getPastryById(int id);
}
