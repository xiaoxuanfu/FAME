class Company {
  late String _name, _category;
  double volatility = 0.0;
  double stockprice = 0.0;
  bool isFavourite = false;
  Company(String name, cat, double vol, double stock){
    _name = name;
    _category = cat;
    volatility = vol;
    stockprice = stock;
    this.isFavourite = false;
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

  void toggleFavourite(){
    isFavourite = !isFavourite;

  }

}

List<Company> companies = [
  Company('Starbucks', 'food', 0.289, 173),
  Company('Uber', 'transport', 1.247, 66),
  Company('Boeing', 'transport', 0.197, 338),
  Company('Nike', 'fashion', 0.282, 226),
  Company('Apple', 'tech', 0.647, 340),
  Company('Intel', 'tech', 0.633, 71),
  Company('Tesla', 'transport', 1.124, 1760),
  Company('Spotify', 'tech', 0.037, 240),
  Company('Amazon', 'tech', 0.564, 285),
  Company('Nintendo', 'tech', 1.166, 107),
];

List<Company> filteredCo = [];
