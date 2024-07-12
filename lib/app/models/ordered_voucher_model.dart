class OrderedVoucher {
  final String productSid;
  final String code;
  final String name;
  final String description;
  final int unitPrice;
  final String unitPriceCurrencyCode;
  final String imageUrl;
  final int quantity;
  final String status;
  final String beneficiaryName;
  final String beneficiaryMobile;

  OrderedVoucher({
    required this.productSid,
    required this.code,
    required this.name,
    required this.description,
    required this.unitPrice,
    required this.unitPriceCurrencyCode,
    required this.imageUrl,
    required this.quantity,
    required this.status,
    required this.beneficiaryName,
    required this.beneficiaryMobile,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productSid': productSid,
      'code': code,
      'name': name,
      'description': description,
      'unitPrice': unitPrice,
      'unitPriceCurrencyCode': unitPriceCurrencyCode,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'status': status,
      'beneficiaryName': beneficiaryName,
      'beneficiaryMobile': beneficiaryMobile,
    };
  }

  factory OrderedVoucher.fromMap(Map<String, dynamic> map) {
    return OrderedVoucher(
      productSid: map['productSid'] as String,
      code: map['code'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      unitPrice: map['unitPrice'] as int,
      unitPriceCurrencyCode: map['unitPriceCurrencyCode'] as String,
      imageUrl: map['imageUrl'] as String,
      quantity: map['quantity'] as int,
      status: map['status'] as String,
      beneficiaryName: map['beneficiaryName'] as String,
      beneficiaryMobile: map['beneficiaryMobile'] as String,
    );
  }
}
