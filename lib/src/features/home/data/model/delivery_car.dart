import 'package:yandex_mapkit/yandex_mapkit.dart';

class DeliveryCar {
  final String id;
  final List<Point> route;
  int currentIndex;

  DeliveryCar({
    required this.id,
    required this.route,
    this.currentIndex = 0,
  });

  Point get currentPosition => route[currentIndex];
  bool get hasReachedDestination => currentIndex >= route.length - 1;

  void moveForward() {
    if (!hasReachedDestination) {
      currentIndex++;
    }
  }
}