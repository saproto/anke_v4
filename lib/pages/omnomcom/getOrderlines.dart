
import 'package:ankev928/models/orderline.dart';
import 'package:ankev928/shared/helpers/api_call.dart';
import 'package:intl/intl.dart';

Future<List<Orderline>> getOrders() async{
  var _orders = await  await requestApiCallResult('user/orders');
  
  List<Orderline> orderlines = [];
  
  for (var _order in _orders){
    DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(_order['created_at']);
    orderlines.add(Orderline(
      id: _order['id'],
      unitPrice: _order['original_unit_price'],
      totalPrice: _order['total_price'],
      units: _order['units'],
      purchaseDate: tempDate,
      productName: _order["product"]["name"],
    ));
  }
   return orderlines;
}