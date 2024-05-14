import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mynthone/app/helpers/env_helper.dart';

import '../helpers/persistent_storage_helper.dart';
import '../models/account_model.dart';

final apiUrl = dotenv.get(Env.AccountApiEndpoint, fallback: '');

class AccountRepository {
  static Future<List<Account>> fetchAccounts() async {
    final url = Uri.parse(apiUrl);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer${PersistentStorage.getAccessToken()}'
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      final List<dynamic> dataList = jsonMap['data'];
      List<Account> accounts =
          dataList.map((item) => Account.fromJson(item)).toList();

      return accounts;
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}
