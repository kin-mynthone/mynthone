class Statement {
  final String id;
  final bool received;
  final String amount;
  final Account account;
  final String? type;
  final String? fee;
  final String status;
  final String? note;
  final String reference;
  final String paymentType;
  final String currency;
  final Beneficiary beneficiary;
  final Sender sender;
  final String createdAt;

  Statement({
    required this.id,
    required this.received,
    required this.amount,
    required this.account,
    this.type,
    this.fee,
    required this.status,
    this.note,
    required this.reference,
    required this.paymentType,
    required this.currency,
    required this.beneficiary,
    required this.sender,
    required this.createdAt,
  });

  factory Statement.fromJson(Map<String, dynamic> json) {
    return Statement(
      id: json['id'],
      received: json['received'],
      amount: json['amount'],
      account: Account.fromJson(json['account']),
      type: json['type'],
      fee: json['fee'],
      status: json['status'],
      note: json['note'],
      reference: json['reference'],
      paymentType: json['payment_type'],
      currency: json['currency'],
      beneficiary: Beneficiary.fromJson(json['beneficiary']),
      sender: Sender.fromJson(json['sender']),
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'received': received,
      'amount': amount,
      'account': account.toJson(),
      'type': type,
      'fee': fee,
      'status': status,
      'note': note,
      'reference': reference,
      'payment_type': paymentType,
      'currency': currency,
      'beneficiary': beneficiary.toJson(),
      'sender': sender.toJson(),
      'created_at': createdAt,
    };
  }
}

class Account {
  final String id;
  final AccountNumber accountNumber;
  final String alias;

  Account({
    required this.id,
    required this.accountNumber,
    required this.alias,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      accountNumber: AccountNumber.fromJson(json['account_number']),
      alias: json['alias'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_number': accountNumber.toJson(),
      'alias': alias,
    };
  }
}

class AccountNumber {
  final String accountNumber;
  final String prefix;
  final String suffix;

  AccountNumber({
    required this.accountNumber,
    required this.prefix,
    required this.suffix,
  });

  factory AccountNumber.fromJson(Map<String, dynamic> json) {
    return AccountNumber(
      accountNumber: json['account_number'].toString(),
      prefix: json['prefix'],
      suffix: json['suffix'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_number': accountNumber,
      'prefix': prefix,
      'suffix': suffix,
    };
  }
}

class Beneficiary {
  final String type;
  final String alias;
  final String name;
  final Address address;
  final String email;
  final BeneficiaryAccountNumber accountNumber;

  Beneficiary({
    required this.type,
    required this.alias,
    required this.name,
    required this.address,
    required this.email,
    required this.accountNumber,
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) {
    return Beneficiary(
      type: json['type'],
      alias: json['alias'],
      name: json['name'],
      address: Address.fromJson(json['address']),
      email: json['email'],
      accountNumber: BeneficiaryAccountNumber.fromJson(json['account_number']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'alias': alias,
      'name': name,
      'address': address.toJson(),
      'email': email,
      'account_number': accountNumber.toJson(),
    };
  }
}

class Address {
  final String address;
  final String? address2;
  final String city;
  final String? state;
  final String zipcode;
  final String country;
  final String? number;

  Address({
    required this.address,
    this.address2,
    required this.city,
    this.state,
    required this.zipcode,
    required this.country,
    this.number,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      address2: json['address2'],
      city: json['city'],
      state: json['state'],
      zipcode: json['zipcode'],
      country: json['country'],
      number: json['number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'address2': address2,
      'city': city,
      'state': state,
      'zipcode': zipcode,
      'country': country,
      'number': number,
    };
  }
}

class BeneficiaryAccountNumber {
  final String alias;
  final String accountNumber;
  final String? bank;

  BeneficiaryAccountNumber({
    required this.alias,
    required this.accountNumber,
    this.bank,
  });

  factory BeneficiaryAccountNumber.fromJson(Map<String, dynamic> json) {
    return BeneficiaryAccountNumber(
      alias: json['alias'],
      accountNumber: json['account_number'].toString(),
      bank: json['bank'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'alias': alias,
      'account_number': accountNumber,
      'bank': bank,
    };
  }
}

class Sender {
  final String? type;
  final String? alias;
  final String name;
  final Address? address;
  final String? email;
  final dynamic accountNumber;

  Sender({
    this.type,
    this.alias,
    required this.name,
    this.address,
    this.email,
    required this.accountNumber,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      type: json['type'],
      alias: json['alias'],
      name: json['name'],
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      email: json['email'],
      accountNumber: json['account_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'alias': alias,
      'name': name,
      'address': address?.toJson(),
      'email': email,
      'account_number': accountNumber,
    };
  }
}
