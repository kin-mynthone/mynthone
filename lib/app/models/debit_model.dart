class DebitCards {
  final String id;
  final String cardName;
  final String accountNumber;
  final String currency;
  final String amount;
  final String iconUrl;
  final String validity;
  final String cvv;

  DebitCards({
    required this.id,
    required this.cardName,
    required this.accountNumber,
    required this.currency,
    required this.amount,
    required this.iconUrl,
    required this.validity,
    required this.cvv,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cardName': cardName,
      'accountNumber': accountNumber,
      'currency': currency,
      'amount': amount,
      'validity': validity,
      'cvv': cvv,
    };
  }

  factory DebitCards.fromMap(Map<String, dynamic> map) {
    return DebitCards(
      id: map['id'] as String,
      cardName: map['name'] as String,
      accountNumber: map['accountNumber'] as String,
      currency: map['currency'] as String,
      amount: map['amount'] as String,
      iconUrl: map['iconUrl'] as String,
      validity: map['validity'] as String,
      cvv: map['cvv'] as String,
    );
  }

  @override
  String toString() =>
      'Event(id: $id, name: $cardName, accountNumber: $accountNumber, currency: $currency, amount: $amount, iconUrl: $iconUrl, validity: $validity, cvv: $cvv)';
}
