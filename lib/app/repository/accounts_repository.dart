import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/account_model.dart';

class AccountRepository {
  static String apiUrl = 'https://jsonplaceholder.typicode.com/users';

  static Future<List<Account>> fetchAccounts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Account> accounts =
          data.map((json) => Account.fromJson(json)).toList();
      return accounts;
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}
