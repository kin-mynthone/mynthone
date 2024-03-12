class Statement {
  final String id;
  final String senderName;
  final String senderAccountNumber;
  final String receiverName;
  final String receiverAccountNumber;
  final String currency;
  final String amount;
  final String transactionType;
  final String note;

  Statement({
    required this.id,
    required this.senderName,
    required this.senderAccountNumber,
    required this.receiverName,
    required this.receiverAccountNumber,
    required this.currency,
    required this.amount,
    required this.transactionType,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'senderName': senderName,
      'senderAccountNumber': senderAccountNumber,
      'receiverName': receiverName,
      'receiverAccountNumber': receiverAccountNumber,
      'currency': currency,
      'amount': amount,
      'note': note,
    };
  }

  factory Statement.fromMap(Map<String, dynamic> map) {
    return Statement(
      id: map['id'] as String,
      senderName: map['name'] as String,
      senderAccountNumber: map['senderAccountNumber'] as String,
      receiverName: map['receiverName'] as String,
      receiverAccountNumber: map['receiverAccountNumber'] as String,
      currency: map['currency'] as String,
      amount: map['amount'] as String,
      transactionType: map['transactionType'] as String,
      note: map['note'] as String,
    );
  }

  @override
  String toString() =>
      'Event(id: $id, name: $senderName, senderAccountNumber: $senderAccountNumber, receiverName: $receiverName, receiverAccountNumber: $receiverAccountNumber, currency: $currency, amount: $amount, transactionType: $transactionType, note: $note)';
}
