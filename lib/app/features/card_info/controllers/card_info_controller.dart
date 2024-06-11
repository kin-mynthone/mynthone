import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/statement_model.dart';
import '../../../repository/statement_repository.dart';

enum CardInfoStatus { initial, loading, succeeded, error }

class CardInfoController extends GetxController {
  static CardInfoController get find => Get.find();

  final _status = CardInfoStatus.initial.obs;
  Rx<CardInfoStatus> get status => _status;
  bool get isLoading => _status.value == CardInfoStatus.loading;

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  final _isBackCardShown = false.obs;
  bool get isBackCardShown => _isBackCardShown.value;

  final _obscuredCvv = true.obs;
  bool get obscuredCvv => _obscuredCvv.value;

  final _statement = <Statement>[].obs;
  List<Statement> get statement => _statement;

  final _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  String get currentState =>
      'CardInfoController(status: ${_status.value} errorMessage: ${_errorMessage.value}, statementLength: ${_statement.length})';

  @override
  void onInit() {
    super.onInit();
    _fetchCardStatement();
  }

  void toggleObscuredCvv() {
    _obscuredCvv.value = !_obscuredCvv.value;
  }

  void setIsBackCardShown(bool value) {
    _isBackCardShown.value = value;
  }

  Future<void> _fetchCardStatement() async {
    _status.value = CardInfoStatus.loading;
    try {
      await Future.delayed(const Duration(seconds: 1));
      _statement.value = await StatementRepository.fetchAllStatements();

      _status.value = CardInfoStatus.succeeded;
    } catch (e) {
      _errorMessage.value = 'Error description here';
      _status.value = CardInfoStatus.error;
    }
  }
}
