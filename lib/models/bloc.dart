abstract class Bloc<T> {
  Stream<T> get all;
  void update();
  void dispose();
}
