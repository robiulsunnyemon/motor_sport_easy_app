import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/api_model/notification_api_model.dart';
import '../../shared_pref_helper/shared_pref_helper.dart';
import '../contants.dart';


class NotificationApiService {

  static Future<List<NotificationApiModel>> fetchNotifications() async {
    String? fastAPIToken = await SharedPrefHelper.getToken();
    print("fastApIToke: $fastAPIToken");
    final response = await http.get(
        Uri.parse('$baseUrl/notification_box/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $fastAPIToken',
        },
    );
    print("notification response ${response.statusCode}");
    print("notification response ${response.body}");
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => NotificationApiModel.fromJson(e)).toList();
    } else {
      print("notification response ${response.statusCode}");
      print("notification response ${response.body}");
      throw Exception('Failed to load notifications');
    }
  }
}
