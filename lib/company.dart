class Company {
  late String _name, _category;
  double volatility = 0.0;
  double stockprice = 0.0;
  Company(String name, cat, double vol, double stock){
    _name = name;
    _category = cat;
    volatility = vol;
    stockprice = stock;
  }

  String getName() {
    return _name;
  }
  String getCat(){
    return _category;
  }

  double getVol(){
    return volatility;
  }

  void setVol(double v){
    volatility = v;
  }

}

List<Company> companies = [
  Company('Starbucks', 'Food', 0.289, 173),
  Company('Uber', 'Transport', 1.247, 66),
  Company('Boeing', 'Transport', 0.197, 338),
  Company('Nike', 'Fashion', 0.282, 226),
  Company('Apple', 'Tech', 0.647, 340),
  Company('Intel', 'Tech', 0.633, 71),
  Company('Tesla', 'Transport', 1.124, 1760),
  Company('Spotify', 'Tech', 0.037, 240),
  Company('Amazon', 'Tech', 0.564, 285),
  Company('Nintendo', 'Tech', 1.166, 107),
];
