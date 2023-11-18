import 'package:flutter/foundation.dart';

import '../../../services/dogs/models/dog_model.dart';

@immutable
abstract class HomeActionResult {
  const HomeActionResult();
}

@immutable
class HomeInitialState implements HomeActionResult {
  const HomeInitialState();
}

@immutable
class GetDogsResult implements HomeActionResult {
  final List<Dog> dogs;

  const GetDogsResult({required this.dogs});
}

@immutable
class GetDogsEmptyResult implements HomeActionResult {
  final int page;
  final int limit;
  final String query;
  const GetDogsEmptyResult(
      {required this.page, required this.limit, required this.query});

  @override
  String toString() =>
      'GetDogsEmptyResult(page: $page, limit: $limit, query: $query)';
}

@immutable
class RandomDogImageResult implements HomeActionResult {
  final String imageURL;

  const RandomDogImageResult({required this.imageURL});
}

@immutable
class HomeActionFailure implements HomeActionResult {
  final String? errorMessage;
  final StackTrace? stackTrace;
  const HomeActionFailure(this.errorMessage, {this.stackTrace});
}
