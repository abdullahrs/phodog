import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../config/router/routes.dart';
import '../../../services/dogs/dogs_service.dart';
import '../../../services/dogs/models/dog_model.dart';
import '../../../widgets/sheets/bottom_sheet_screen.dart';
import '../view/settings.screen.dart';
import '../widgets/dog_detail.dart';
import '../widgets/random_dog_dialog_content.dart';
import 'home_actions.dart';
import 'home_results.dart';

class HomeControllerBloc extends Bloc<HomeAction, HomeActionResult> {
  final DogService dogService;

  List<Dog> dogs = [];

  HomeControllerBloc(this.dogService) : super(const HomeInitialState()) {
    on<HomeAction>(
      (event, emit) async {
        if (event is GetDogsList) await onGetAllDogs(event, emit);
        if (event is GetRandomDogByBreed) await getRandomDog(event, emit);
      },
    );
  }

  Future<void> onGetAllDogs(
      GetDogsList event, Emitter<HomeActionResult> emit) async {
    try {
      final result = await dogService.getDogs(
          page: event.page, limit: event.limit, query: event.query);
      if (result.isEmpty) {
        emit(GetDogsEmptyResult(
            page: event.page, limit: event.limit, query: event.query));
      } else {
        for (int i = 0; i < result.length; i++) {
          String imageUrl =
              await dogService.getRandomImageByBreed(result[i].name);
          try {
            final imageProvider = NetworkImage(imageUrl);
            // ignore: use_build_context_synchronously
            await precacheImage(imageProvider, event.context);
            result[i] = result[i].copyWith(imageProvider: imageProvider);
          } catch (e) {
            // For 404 errors
          }
        }
        if (state is HomeInitialState) {
          FlutterNativeSplash.remove();
        }
        dogs = result;
        emit(GetDogsResult(dogs: result));
      }
    } catch (e) {
      emit(HomeActionFailure(e.toString()));
    }
  }

  Future<void> getRandomDog(
      GetRandomDogByBreed event, Emitter<HomeActionResult> emit) async {
    try {
      final result = await dogService.getRandomImageByBreed(event.breed);
      emit(RandomDogImageResult(imageURL: result));
    } catch (e) {
      emit(HomeActionFailure(e.toString()));
    }
  }

  Future<void> onTapSettings() async {
    await showBottomSheetScreen(
        globalNavigatorKey.currentState!.context, const SettingsScreen());
  }

  Future<void> onTapDog(Dog dog) async {
    await showDialog(
      context: globalNavigatorKey.currentState!.context,
      builder: (context) => DogDetail(
        dog: dog,
        onTapGenerate: () async {
          final randomImageURL = await getRandomDogByBreed(dog.name);
          // ignore: use_build_context_synchronously
          await showDialog(
            context: context,
            builder: (_) => RandomDogDialogContent(imageURL: randomImageURL),
          );
        },
      ),
    );
  }

  Future<String> getRandomDogByBreed(String breed) async {
    String randomImageURL = await dogService.getRandomImageByBreed(breed);
    return randomImageURL;
  }

  Future<void> onTapSearchBar() async {}
}
