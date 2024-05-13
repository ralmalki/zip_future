import 'package:test/test.dart';
import 'package:zip_future/zip_future.dart';

void main() {
  test('ZipFuture', () async {
    final future1 = Future.value(1);
    final future2 = Future.value(2);
    final future3 = Future.value(3);

    final zipFuture = ZipFuture.zip([future1, future2, future3]);

    final results = await zipFuture.execute();
    expect(results, [1, 2, 3]);

    final result = await zipFuture.executeThenMap<num>((results) {
      return results.fold(
          0, (previousValue, element) => previousValue + element);
    });
    expect(result, 6);
  });

  test('ZipFuture with different types', () async {
    final future1 = Future.value(1);
    final future2 = Future.value('2');
    final future3 = Future.value(3.0);

    final zipFuture = ZipFuture.zip([future1, future2, future3]);

    final results = await zipFuture.execute();
    expect(results, [1, '2', 3.0]);

    final result = await zipFuture.executeThenMap<num>((results) {
      return results.fold(
          0, (previousValue, element) => previousValue + element);
    });
    expect(result, 6);
  });
}
