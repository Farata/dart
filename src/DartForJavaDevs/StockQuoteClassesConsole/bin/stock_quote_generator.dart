part of stock_quote;

class StockQuoteGenerator {

  static List<String> _supportedSymbols = ["AAPL", "MSFT", "IBM"];
  static Random rand = new Random();

  static Stock getQuote(String symbol) {

    Stock stock = new Stock(symbol);
    stock.symbol = symbol;

    if (_supportedSymbols.contains(symbol)) {

      stock.price = rand.nextDouble();
    }
      return stock;
    }
}