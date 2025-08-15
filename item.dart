
class Item {
  final int? id;
  final String name;
  final String? barcode;
  final String? sku;
  final String? unit;
  final double priceSale;
  final double pricePurchase;
  final double qty;
  final String? expDate; // ISO string yyyy-mm-dd

  Item({
    this.id,
    required this.name,
    this.barcode,
    this.sku,
    this.unit,
    required this.priceSale,
    required this.pricePurchase,
    required this.qty,
    this.expDate,
  });

  Item copyWith({
    int? id,
    String? name,
    String? barcode,
    String? sku,
    String? unit,
    double? priceSale,
    double? pricePurchase,
    double? qty,
    String? expDate,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      sku: sku ?? this.sku,
      unit: unit ?? this.unit,
      priceSale: priceSale ?? this.priceSale,
      pricePurchase: pricePurchase ?? this.pricePurchase,
      qty: qty ?? this.qty,
      expDate: expDate ?? this.expDate,
    );
  }

  factory Item.fromMap(Map<String, dynamic> m) => Item(
    id: m['id'] as int?,
    name: m['name'] as String,
    barcode: m['barcode'] as String?,
    sku: m['sku'] as String?,
    unit: m['unit'] as String?,
    priceSale: (m['price_sale'] as num).toDouble(),
    pricePurchase: (m['price_purchase'] as num).toDouble(),
    qty: (m['qty'] as num).toDouble(),
    expDate: m['exp_date'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'barcode': barcode,
    'sku': sku,
    'unit': unit,
    'price_sale': priceSale,
    'price_purchase': pricePurchase,
    'qty': qty,
    'exp_date': expDate,
  };
}
