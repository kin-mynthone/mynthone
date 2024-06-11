class Beneficiary {
  final String id;
  final String alias;
  final String name;
  final String address;
  final String? addressNumber;
  final String? address2;
  final String? city;
  final String? region;
  final String? postalCode;
  final String? country;
  final String? email;
  final Currency currency;
  final AccountNumber accountNumber;

  Beneficiary({
    required this.id,
    required this.alias,
    required this.name,
    required this.address,
    this.addressNumber,
    this.address2,
    this.city,
    this.region,
    this.postalCode,
    this.country,
    this.email,
    required this.currency,
    required this.accountNumber,
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) {
    return Beneficiary(
      id: json['id'],
      alias: json['alias'],
      name: json['name'],
      address: json['address'],
      addressNumber: json['address_number'],
      address2: json['address2'],
      city: json['city'],
      region: json['region'],
      postalCode: json['postal_code'],
      country: json['country'],
      email: json['email'],
      currency: Currency.fromJson(json['currency']),
      accountNumber: AccountNumber.fromJson(json['account_number']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'alias': alias,
      'name': name,
      'address': address,
      'address_number': addressNumber,
      'address2': address2,
      'city': city,
      'region': region,
      'postal_code': postalCode,
      'country': country,
      'email': email,
      'currency': currency.toJson(),
      'account_number': accountNumber.toJson(),
    };
  }
}

class Currency {
  final String id;
  final String name;
  final String assetType;
  final String assetClass;
  final String symbolPrefix;
  final String symbolSuffix;

  Currency({
    required this.id,
    required this.name,
    required this.assetType,
    required this.assetClass,
    required this.symbolPrefix,
    required this.symbolSuffix,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'],
      name: json['name'],
      assetType: json['asset_type'],
      assetClass: json['asset_class'],
      symbolPrefix: json['symbol_prefix'],
      symbolSuffix: json['symbol_suffix'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'asset_type': assetType,
      'asset_class': assetClass,
      'symbol_prefix': symbolPrefix,
      'symbol_suffix': symbolSuffix,
    };
  }
}

class AccountNumber {
  final String accountNumber;

  AccountNumber({
    required this.accountNumber,
  });

  factory AccountNumber.fromJson(Map<String, dynamic> json) {
    return AccountNumber(
      accountNumber: json['account_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_number': accountNumber,
    };
  }
}
