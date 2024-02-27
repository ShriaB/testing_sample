import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:testing_sample/models/fetch_todo.dart';
import 'package:testing_sample/models/todo.dart';

import 'fetch_todo_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group("fetchTodo", () {
    test("returns a Todo if API call is successful", () async {
      final client = MockClient();
      when(client
              .get(Uri.parse("https://jsonplaceholder.typicode.com/todos/1")))
          .thenAnswer((realInvocation) async => http.Response(
              '{"userId": 1, "id": 1, "title": "delectus aut autem", "completed": false}',
              200));

      expect(await fetchTodo(client), isA<Todo>());
    });

    test("throws an exception if API call fails", () async {
      final client = MockClient();
      when(client
              .get(Uri.parse("https://jsonplaceholder.typicode.com/todos/1")))
          .thenAnswer((realInvocation) async =>
              http.Response('Internal Server Error', 500));

      expect(fetchTodo(client), throwsException);
    });
  });
}
