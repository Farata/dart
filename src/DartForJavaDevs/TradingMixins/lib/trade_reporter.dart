part of trading_mixins;

class TradeReporter{

  String whereToReport;

   reportMuniBondTrade(name){
     print('Trade for municipal bond $name has been reported to $whereToReport');
   }

   reportCorpBondTrade(name){
     print('Trade for corporate bond $name has been reported to $whereToReport');
   }
}