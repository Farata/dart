library stock;

class Stock {
  String _symbol;
  double _price;

  Stock (this._symbol);

  double get price =>  _price;

  set price(double value){
    _price = value;
  }

  String get symbol => _symbol;

  set symbol(String value){
       _symbol = value;
  }
}