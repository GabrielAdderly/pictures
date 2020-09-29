abstract class IRequest<T> {
  Future<T> call();
}