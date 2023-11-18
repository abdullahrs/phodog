import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/home/controller/home_controller_bloc.dart';
import '../../features/home/view/home_screen.dart';
import '../../services/dogs/dogs_service.dart';

final GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

class CustomAppRouter {
  static RouteInformationParser<Object> routeInformationParser =
      _AppRouteInformationParser();
  static RouterDelegate<Object> routerDelegate = _AppRouterDelegate();
}

class _AppRouteInformationParser extends RouteInformationParser<Object> {
  @override
  Future<Object> parseRouteInformation(
      RouteInformation routeInformation) async {
    return '';
  }

  @override
  RouteInformation restoreRouteInformation(Object configuration) {
    return RouteInformation(uri: Uri.parse('/'));
  }
}

class _AppRouterDelegate extends RouterDelegate<Object>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<Object> {
  @override
  GlobalKey<NavigatorState>? get navigatorKey => globalNavigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: _generateRoute,
    );
  }

  Route<Object> _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => HomeControllerBloc(
              DogService(),
            ),
            child: const HomeScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => HomeControllerBloc(
              DogService(),
            ),
            child: const HomeScreen(),
          ),
        );
    }
  }

  @override
  Future<void> setNewRoutePath(Object configuration) async {}
}
