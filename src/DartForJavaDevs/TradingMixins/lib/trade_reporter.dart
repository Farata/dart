part of trading_mixins;

class TradeReporter{

   reportMuniBondTrade(name){
     print('Trade for municipal bond $name has been reported to SEC');
   }

   reportCorpBondTrade(name){
     print('Trade for corporate bond $name has been reported to SEC');
   }
}