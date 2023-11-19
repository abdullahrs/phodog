import 'package:flutter/material.dart';

@immutable
abstract class HomeAction {
  const HomeAction();
}

@immutable
class GetDogsList implements HomeAction {
  /// it necessery for precacheImage(provider, context);
  final BuildContext context;
  final int page;
  final int limit;
  final String query;

  const GetDogsList(this.context,
      {required this.page, required this.limit, required this.query});
}

@immutable
class GetRandomDogByBreed implements HomeAction {
  final String breed;

  const GetRandomDogByBreed({required this.breed});
}

@immutable
class KeyboardOpenAction implements HomeAction {
  const KeyboardOpenAction();
}

@immutable
class KeyboardCloseAction implements HomeAction {
  const KeyboardCloseAction();
}

