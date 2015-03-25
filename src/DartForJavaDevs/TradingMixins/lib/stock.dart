part of trading_mixins;

class Stock extends Security{

  String symbol;
  double previousClosingPrice;

  Stock(String name): super(name);

}