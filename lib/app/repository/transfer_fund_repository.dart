import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../helpers/env_helper.dart';
import '../helpers/log_helper.dart';
import '../helpers/persistent_storage_helper.dart';

final apiUrl = dotenv.get(Env.transferApiEndpoint, fallback: '');

class TransferFundRepository {
  static Future<void> transferFund(
      {required amountSend,
      required reference,
      required beneficiaryId,
      required accountId}) async {
    final url = Uri.parse(apiUrl);

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer${PersistentStorage.getAccessToken()}'
    };

    final body = {
      'amount_send': amountSend,
      'reference': reference,
      'beneficiary_id': beneficiaryId,
      'account_id': accountId,
    };

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      Log.printInfo('Response data: ${response.body}');
    } else {
      Log.printInfo('Response data: ${response.body}');
      throw Exception('Failed to load data from API');
    }
  }
}
