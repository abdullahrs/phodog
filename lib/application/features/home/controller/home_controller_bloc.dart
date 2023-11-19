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

  HomeControllerBloc(this.dogService) : super(const HomeInitialState()) {
    on<HomeAction>(
      (event, emit) async {
        if (event is GetDogsList) await onGetAllDogs(event, emit);
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
          String imageUrl =
              await dogService.getRandomImageByBreed(result[i].name);
          try {
            final imageProvider = NetworkImage(imageUrl);
            // ignore: use_build_context_synchronously
            await precacheImage(
              imageProvider,
              event.context,
              onError: (exception, stackTrace) {},
            );
            result[i] = result[i].copyWith(imageProvider: imageProvider);
          } catch (e) {
            // For 404 errors
          }
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
    FocusManager.instance.primaryFocus?.unfocus();
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

  Future<void> onTapSearchBar() async {
    if (!sheetIsOpen && !onTapSearchBarLock) {
      onTapSearchBarLock = true;
      await draggableScrollableController?.animateTo(0.5,
          duration: kAppAnimationDuration, curve: Curves.decelerate);
      draggableFocusNode?.requestFocus();
      sheetIsOpen = true;
      onTapSearchBarLock = false;
    }
  }

  Future<void> closeSheet() async {
    closeAnimationLock = true;
    await draggableScrollableController?.animateTo(0,
        duration: kAppAnimationDuration, curve: Curves.decelerate);
    sheetIsOpen = false;
    closeAnimationLock = false;
    draggableFocusNode?.unfocus();
  }

  Future<void> draggableListener() async {
    if (!sheetIsOpen) return;
    Size size = MediaQuery.of(globalNavigatorKey.currentState!.context).size;
    double height = size.height;
    final padding =
        MediaQuery.of(globalNavigatorKey.currentState!.context).viewPadding;
    // Height (without status and toolbar)
    height = height - padding.top - kToolbarHeight;
    if (draggableScrollableController!.pixels < height / 2 &&
        !closeAnimationLock) {
      await closeSheet();
    }
  }

  Future<void> keyboardFocusListener() async {
    if (sheetIsOpen) await closeSheet();
  }

  void searchListener() {
    startOperation(
        searchController!.text,
        (query) => add(GetDogsList(globalNavigatorKey.currentState!.context,
            page: 1, limit: 10, query: query)));
  }
}
