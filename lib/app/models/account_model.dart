class Account {
  final String id;
  final AccountNumber accountNumber;
  final String balance;
  final String alias;
  final Currency currency;
  final String icon;
  final String color;
  final String isPrimary;
  final String status;
  final String createdAt;

  Account({
    required this.id,
    required this.accountNumber,
    required this.balance,
    required this.alias,
    required this.currency,
    required this.icon,
    required this.color,
    required this.isPrimary,
    required this.status,
    required this.createdAt,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      accountNumber: AccountNumber.fromJson(json['account_number']),
      balance: json['balance'],
      alias: json['alias'],
      currency: Currency.fromJson(json['currency']),
      icon: json['icon'],
      color: json['color'],
      isPrimary: json['is_primary'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_number': accountNumber.toJson(),
      'balance': balance,
      'alias': alias,
      'currency': currency.toJson(),
      'icon': icon,
      'color': color,
      'is_primary': isPrimary,
      'status': status,
      'created_at': createdAt,
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
  final int accountNumber;
  final String prefix;
  final String suffix;

  AccountNumber({
    required this.accountNumber,
    required this.prefix,
    required this.suffix,
  });

  factory AccountNumber.fromJson(Map<String, dynamic> json) {
    return AccountNumber(
      accountNumber: json['account_number'],
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
