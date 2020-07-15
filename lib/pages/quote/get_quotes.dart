import 'package:ankev928/models/quote.dart';
import 'package:ankev928/shared/helpers/api_call.dart';
import 'package:intl/intl.dart';
int totalAmountQuotes;
Future<List<Quote>> getQuotes(int page) async{
  var _quotes = await  doApiGetRequest('quotes?page=$page');
  List<Quote> quotes = [];
  setTotalAmountQuotes(_quotes['data']['total']);
  for(var i in _quotes["data"]["data"]){
    DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(i['created_at']);
    Quote quote = Quote(
      id: i['id'],
      posterName: i['user_info']['name'],
      quote: i["quote"],
      created: tempDate
    );
    quotes.add(quote);
  }

  return quotes;
  //print();
}
void setTotalAmountQuotes(int _totalAmountQuotes){
  totalAmountQuotes = _totalAmountQuotes;
}
int getTotalAmountQuotes() {
  return totalAmountQuotes;
}