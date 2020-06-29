
class Orderline{

  final int id;
  final dynamic unitPrice;
  final dynamic totalPrice;
  final int units;
  final DateTime purchaseDate;
  final String productName;

  Orderline({
    this.id,
    this.unitPrice,
    this.totalPrice,
    this.units,
    this.purchaseDate,
    this.productName
});

}