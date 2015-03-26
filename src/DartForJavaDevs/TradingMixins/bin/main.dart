import 'package:TradingMixins/trading_mixins.dart';

main() {

  Stock stock = new Stock('MSFT');

  Bond bond = new Bond('Metropolitan Transportation');

  bond.whereToReport = "SEC";      // from mixin

  bond.reportMuniBondTrade('Metropolitan Transportation'); // from mixin

}
