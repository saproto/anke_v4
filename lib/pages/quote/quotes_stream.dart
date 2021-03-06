import 'dart:async';
import 'package:ankev928/models/quote.dart';
import 'package:ankev928/pages/quote/get_quotes.dart';

class QuotesStream {
  Stream<List<Quote>> stream;

  bool hasMore;
  bool _isLoading;
  List<Quote> _data;
  StreamController<List<Quote>> _controller;
  int pageNumber;

  QuotesStream() {
    _data = List<Quote>();
    _controller = StreamController<List<Quote>>.broadcast();
    _isLoading = false;
    pageNumber = 0;
    stream = _controller.stream.map((List<Quote> quotesData) {
      return quotesData;
    });
    hasMore = true;
    refresh();
  }

  Future<void> refresh(){
    return loadMore(clearCachedData: true);
  }

  Future<void> loadMore({bool clearCachedData = false}){
    if(clearCachedData){
      _data = List<Quote> ();
      pageNumber = 1;
      hasMore = true;
    }

    if( _isLoading || !hasMore){
      return Future.value();
    }

    _isLoading = true;
    return getQuotes(pageNumber).then((quoteData){
      _isLoading = false;
      _data.addAll(quoteData);
      pageNumber ++;
      hasMore = (_data.length < getTotalAmountQuotes());
      _controller.add(_data);
    });

  }
}