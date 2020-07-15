import 'package:intl/intl.dart';

class Quote {

  final int id;
  final int totalAmountQuotes;
  final String posterName;
  final String quote;
  final DateTime created;

  Quote({
    this.id,
    this.posterName,
    this.quote,
    this.created,
    this.totalAmountQuotes
});

//  factory Quote.fromServerMap(Quote data){
//    DateTime tempDate = DateFormat("yyyy-MM-dd hh:mm:ss").parse(data['created_at']);
//    return Quote(
//        id: data['id'],
//        userId: data['user_id'],
//        quote: data["quote"],
//        created: tempDate
//    );
//  }
}