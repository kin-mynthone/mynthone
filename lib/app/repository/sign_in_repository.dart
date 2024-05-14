import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../helpers/env_helper.dart';
import '../models/access_token_model.dart';

final apiUrl = dotenv.get(Env.signInApiEndpoint, fallback: '');

class SignInRepository {
  static Future<SignInResponse> signInAccount(
      {required String email, required String password}) async {
    final url = Uri.parse(apiUrl);
    final headers = {'Accept': 'application/json'};
    final body = {
      'email': email,
      'password': password,
    };

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final map = json.decode(response.body) as Map<String, dynamic>;
      final accessToken = SignInResponse.fromMap(map);

      return accessToken;
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}
