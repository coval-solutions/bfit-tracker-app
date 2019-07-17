import 'dart:async';

enum HomeScreenBottomNavBarItems { HOME, TARGETS, COURSES, ANALYTICS, PROFILE }

class HomeScreenBottomNavBarBloc {
  final StreamController<HomeScreenBottomNavBarItems> _navBarController =
    StreamController<HomeScreenBottomNavBarItems>.broadcast();

  HomeScreenBottomNavBarItems defaultItem = HomeScreenBottomNavBarItems.HOME;

  Stream<HomeScreenBottomNavBarItems> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(HomeScreenBottomNavBarItems.HOME);
        break;
      case 1:
        _navBarController.sink.add(HomeScreenBottomNavBarItems.TARGETS);
        break;
      case 2:
        _navBarController.sink.add(HomeScreenBottomNavBarItems.COURSES);
        break;
      case 3:
        _navBarController.sink.add(HomeScreenBottomNavBarItems.ANALYTICS);
        break;
      case 4:
        _navBarController.sink.add(HomeScreenBottomNavBarItems.PROFILE);
        break;
    }
  }

  close() {
    _navBarController?.close();
  }
}