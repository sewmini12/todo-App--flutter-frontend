import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class ApiService {
  // Use this variable so we don't have to type the URL twice
  static const String baseUrl = "http://192.168.8.179:8000/tasks";

  // Get all tasks from backend
  static Future<List<Task>> getTasks() async {
    print("Attempting to fetch tasks from: $baseUrl"); // 🔍 Debug Log 1

    try {
      final response = await http.get(Uri.parse(baseUrl));
      
      print("Server responded with Code: ${response.statusCode}"); // 🔍 Debug Log 2
      print("Server body: ${response.body}"); // 🔍 Debug Log 3

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        return data.map((e) => Task.fromJson(e)).toList();
      } else {
        // This will show us the REAL error code on the phone screen
        throw Exception('Failed. Code: ${response.statusCode}'); 
      }
    } catch (e) {
      print("Error caught: $e"); // 🔍 Debug Log 4
      rethrow;
    }
  }
  
  // Add Task function (You will need this soon!)
  static Future<void> addTask(String title) async {
    await http.post(
      Uri.parse(baseUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": title}),
    );
  }
}