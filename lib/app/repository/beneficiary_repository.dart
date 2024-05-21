import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../helpers/env_helper.dart';
import '../helpers/persistent_storage_helper.dart';
import '../models/beneficiary_model.dart';

final apiUrl = dotenv.get(Env.beneficiaryApiEndpoint, fallback: '');

class BeneficiaryRepository {
  static Future<List<Beneficiary>> fetchBeneficiaryBeneficiary() async {
    final url = Uri.parse(apiUrl);
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer${PersistentStorage.getAccessToken()}'
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      final List<dynamic> dataList = jsonMap['data'];

      List<Beneficiary> beneficiary =
          dataList.map((item) => Beneficiary.fromJson(item)).toList();

      return beneficiary;
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}
