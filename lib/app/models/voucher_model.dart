class Voucher {
  final String productSid;
  final String code;
  final String name;
  final String description;
  final int productTypeId;
  final String productTypeName;
  final int unitPrice;
  final String unitPriceCurrencyCode;
  final String imageUrl;
  final int minQty;
  final int maxQty;
  final int stockQty;
  final int defaultQty;
  final bool isBranchSpecific;
  final String branchSid;
  final String branchCode;
  final String branchName;
  final bool isShippingRequired;
  final bool isBirthdateRequired;
  final String accountSid;
  final int shippingAndHandlingFee;

  Voucher({
    required this.productSid,
    required this.code,
    required this.name,
    required this.description,
    required this.productTypeId,
    required this.productTypeName,
    required this.unitPrice,
    required this.unitPriceCurrencyCode,
    required this.imageUrl,
    required this.minQty,
    required this.maxQty,
    required this.stockQty,
    required this.defaultQty,
    required this.isBranchSpecific,
    required this.branchSid,
    required this.branchCode,
    required this.branchName,
    required this.isShippingRequired,
    required this.isBirthdateRequired,
    required this.accountSid,
    required this.shippingAndHandlingFee,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productSid': productSid,
      'code': code,
      'name': name,
      'description': description,
      'productTypeId': productTypeId,
      'productTypeName': productTypeName,
      'unitPrice': unitPrice,
      'unitPriceCurrencyCode': unitPriceCurrencyCode,
      'imageUrl': imageUrl,
      'minQty': minQty,
      'maxQty': maxQty,
      'stockQty': stockQty,
      'defaultQty': defaultQty,
      'isBranchSpecific': isBranchSpecific,
      'branchSid': branchSid,
      'branchCode': branchCode,
      'branchName': branchName,
      'isShippingRequired': isShippingRequired,
      'isBirthdateRequired': isBirthdateRequired,
      'accountSid': accountSid,
      'shippingAndHandlingFee': shippingAndHandlingFee,
    };
  }

  factory Voucher.fromMap(Map<String, dynamic> map) {
    return Voucher(
      productSid: map['productSid'] as String,
      code: map['code'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      productTypeId: map['productTypeId'] as int,
      productTypeName: map['productTypeName'] as String,
      unitPrice: map['unitPrice'] as int,
      unitPriceCurrencyCode: map['unitPriceCurrencyCode'] as String,
      imageUrl: map['imageUrl'] as String,
      minQty: map['minQty'] as int,
      maxQty: map['maxQty'] as int,
      stockQty: map['stockQty'] as int,
      defaultQty: map['defaultQty'] as int,
      isBranchSpecific: map['isBranchSpecific'] as bool,
      branchSid: map['branchSid'] as String,
      branchCode: map['branchCode'] as String,
      branchName: map['branchName'] as String,
      isShippingRequired: map['isShippingRequired'] as bool,
      isBirthdateRequired: map['isBirthdateRequired'] as bool,
      accountSid: map['accountSid'] as String,
      shippingAndHandlingFee: map['shippingAndHandlingFee'] as int,
    );
  }

  @override
  String toString() {
    return 'Voucher(productSid: $productSid, code: $code, name: $name, description: $description, productTypeId: $productTypeId, productTypeName: $productTypeName, unitPrice: $unitPrice, unitPriceCurrencyCode: $unitPriceCurrencyCode, imageUrl: $imageUrl, minQty: $minQty, maxQty: $maxQty, stockQty: $stockQty, defaultQty: $defaultQty, isBranchSpecific: $isBranchSpecific, branchSid: $branchSid, branchCode: $branchCode, branchName: $branchName, isShippingRequired: $isShippingRequired, isBirthdateRequired: $isBirthdateRequired, accountSid: $accountSid, shippingAndHandlingFee: $shippingAndHandlingFee)';
  }
}
