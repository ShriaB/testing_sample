import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testing_sample/models/todo.dart';

Future<Todo> fetchTodo(http.Client client) async {
  final apiRes = await client
      .get(Uri.parse("https://jsonplaceholder.typicode.com/todos/1"));

  if (apiRes.statusCode == 200) {
    return Todo.fromJson(jsonDecode(apiRes.body) as Map<String, dynamic>);
  } else {
    throw Exception("Data loading failed");
  }
}
