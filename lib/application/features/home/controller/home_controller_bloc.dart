// ignore_for_file: use_build_context_synchronously

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../../../../core/utils/cancelable_search_mixin.dart';
import '../../../common/constants.dart';
import '../../../config/router/routes.dart';
import '../../../services/dogs/dogs_service.dart';
import '../../../services/dogs/models/dog_model.dart';
import '../../../widgets/sheets/bottom_sheet_screen.dart';
import '../view/settings.screen.dart';
import '../widgets/dog_detail.dart';
import '../widgets/random_dog_dialog_content.dart';
import 'home_actions.dart';
import 'home_results.dart';

class HomeControllerBloc extends Bloc<HomeAction, HomeActionResult>
    with CancelableSearchOperationMixin {
  final DogService dogService;

  /// contains all of the dogs
  List<Dog> initialDogList = [];

  DraggableScrollableController? draggableScrollableController;
  TextEditingController? searchController;
  FocusNode? draggableFocusNode;
  FocusNode? searchBarFocus;

  /// whether the bottom sheet is open or not
  /// value changes when animations are finished
  bool sheetIsOpen = false;

  /// to avoid multiple onTapSearchBar events
  bool onTapSearchBarLock = false;

  /// to prevent multiple sheet closing events
  bool closeAnimationLock = false;

  // to store state of keyboard
  bool keyboardIsOpen = false;

  HomeControllerBloc(this.dogService) : super(const HomeInitialState()) {
    on<HomeAction>(
      (event, emit) async {
        if (event is GetDogsList) await onGetAllDogs(event, emit);
        // to prevent race condition between initial GetDogsList action
        // and initial KeyboardEvents
        if (initialDogList.isNotEmpty) {
          if (event is KeyboardOpenAction) {
            keyboardIsOpen = true;
            emit(const KeyboardStateChange(KeyboardStatus.open));
          }
          if (event is KeyboardCloseAction) {
            keyboardIsOpen = false;
            emit(const KeyboardStateChange(KeyboardStatus.close));
          }
          keyboardFocusListener();
        }
      },
    );
  }

  void initializeController() {
    searchController = TextEditingController();
    searchController?.addListener(searchListener);
    draggableScrollableController = DraggableScrollableController();
    draggableScrollableController?.addListener(draggableListener);
    draggableFocusNode = FocusNode();
    searchBarFocus = FocusNode(canRequestFocus: false);
  }

  void resetValues() {
    initialDogList = [];
    searchController?.removeListener(searchListener);
    searchController?.dispose();
    draggableScrollableController?.removeListener(draggableListener);
    draggableScrollableController?.dispose();
    sheetIsOpen = false;
    onTapSearchBarLock = false;
    closeAnimationLock = false;
  }

  Future<void> onGetAllDogs(
      GetDogsList event, Emitter<HomeActionResult> emit) async {
    // If the dog information is fetched from the service when the application is first opened,
    // manipulation is done over the initialDogList instead of sending a request to the service again
    // Note : if service has pagination or search query params it might change according to situation
    if (initialDogList.isNotEmpty) {
      try {
        final filteredDogs = List<Dog>.from(initialDogList)
            .where((element) => element.contains(event.query.toLowerCase()));
        if (filteredDogs.isEmpty) {
          emit(GetDogsEmptyResult(
              page: event.page, limit: event.limit, query: event.query));
        } else {
          emit(GetDogsResult(dogs: filteredDogs.toList()));
        }
        return;
      } catch (e) {
        emit(HomeActionFailure(e.toString()));
      }
    }
    try {
      final result = await dogService.getDogs(
          page: event.page, limit: event.limit, query: event.query);
      if (result.isEmpty) {
        emit(GetDogsEmptyResult(
            page: event.page, limit: event.limit, query: event.query));
      } else {
        for (int i = 0; i < result.length; i++) {
          bool hasError = false;
          const maxNumberOfRetries = 3;
          int numberOfRetry = 0;
          NetworkImage imageProvider;
          do {
            hasError = false;
            String imageUrl =
                await dogService.getRandomImageByBreed(result[i].name);
            imageProvider = NetworkImage(imageUrl);
            await precacheImage(
              imageProvider,
              event.context,
              onError: (exception, stackTrace) {
                hasError = true;
                numberOfRetry++;
              },
            );
          } while (numberOfRetry > maxNumberOfRetries && !hasError);
          result[i] = result[i].copyWith(imageProvider: imageProvider);
        }
      }
      if (state is HomeInitialState) {
        initialDogList = result;
        FlutterNativeSplash.remove();
      }
      emit(GetDogsResult(dogs: result));
    } catch (e) {
      if (state is HomeInitialState) {
        FlutterNativeSplash.remove();
      }
      emit(HomeActionFailure(e.toString()));
    }
  }

  Future<void> onTapSettings() async {
    await showBottomSheetScreen(
        globalNavigatorKey.currentState!.context, const SettingsScreen());
  }

  Future<void> onTapDog(Dog dog) async {
    if (sheetIsOpen) {
      await closeSheet();
    }
    await showDialog(
      context: globalNavigatorKey.currentState!.context,
      builder: (context) => DogDetail(
        dog: dog,
        onTapGenerate: () async {
          final randomImageURL = await getRandomDogByBreed(dog.name);
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

  Future<void> onTapSearchBar() async {
    if (!sheetIsOpen && !onTapSearchBarLock) {
      onTapSearchBarLock = true;
      await draggableScrollableController?.animateTo(0.55,
          duration: kAppAnimationDuration, curve: Curves.decelerate);
      draggableFocusNode?.requestFocus();
      sheetIsOpen = true;
      onTapSearchBarLock = false;
    }
  }

  Future<void> closeSheet() async {
    if (!closeAnimationLock) {
      closeAnimationLock = true;
      await draggableScrollableController?.animateTo(0,
          duration: kAppAnimationDuration, curve: Curves.decelerate);
      sheetIsOpen = false;
      closeAnimationLock = false;
      draggableFocusNode?.unfocus();
    }
  }

  Future<void> draggableListener() async {
    if (!sheetIsOpen) return;
    Size size = MediaQuery.of(globalNavigatorKey.currentState!.context).size;
    double height = size.height;
    final padding =
        MediaQuery.of(globalNavigatorKey.currentState!.context).viewPadding;
    // Height (without status and toolbar)
    height = height - padding.top - kToolbarHeight;
    if (draggableScrollableController!.pixels < height * 0.55) {
      await closeSheet();
    }
  }

  Future<void> keyboardFocusListener() async {
    if (keyboardIsOpen && sheetIsOpen) return;
    if (!keyboardIsOpen && !sheetIsOpen) return;
    // If keyboard is unfocused close the sheet too
    if (!keyboardIsOpen) await closeSheet();
  }

  void searchListener() {
    startOperation(
        searchController!.text,
        (query) => add(GetDogsList(globalNavigatorKey.currentState!.context,
            page: 1, limit: 10, query: query)));
  }
}
