part of trading_mixins;

class Bond extends Security with TradeReporter{

  double faceValue;
  DateTime maturityDate;

  Bond(String name): super(name);

}