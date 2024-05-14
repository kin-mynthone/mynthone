import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mynthone/app/helpers/env_helper.dart';
import 'package:mynthone/app/models/statement_model.dart';

import '../helpers/persistent_storage_helper.dart';

final apiUrl = dotenv.get(Env.transactionApiEndpoint, fallback: '');

class StatementRepository {
  static Future<List<Statement>> fetchStatements() async {
    final url = Uri.parse(apiUrl);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer${PersistentStorage.getAccessToken()}'
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      final List<dynamic> dataList = jsonMap['data'];
      List<Statement> statement =
          dataList.map((item) => Statement.fromJson(item)).toList();

      return statement;
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}
