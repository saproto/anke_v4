import 'package:ankev928/models/quote.dart';
import 'package:ankev928/shared/helpers/api_call.dart';
import 'package:intl/intl.dart';

Future<List<Quote>> getQuotes() async{
  var _quotes = await  requestApiCallResult('quotes');
  List<Quote> quotes = [];

  for(var i in _quotes["data"]["data"]){
    DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(i['created_at']);
    Quote quote = Quote(
      id: i['id'],
      userId: i['user_id'],
      quote: i["quote"],
      created: tempDate
    );
    quotes.add(quote);
  }

  return quotes;
  //print();
}