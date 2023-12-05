import '../classes/itm.dart';

///List of all the Fixed Items
var itmList = {
  "Regular Chai": 10,
  "Sugar Free Chai": 15,
  "Kulhaad Chai": 15,
  "Gudh Chai": 20,
  "Gudh with Masala Chai": 20,
  "Tulsi Chai": 20,
  "Masala Chai": 20,
  "Chocolate Tea": 20,
  "Lemon Grass Ginger": 20,
  "Black Lemon Tea": 15,
  "Black Tea": 20,
  "Green Tea": 20,
  "Hot Coffee": 25,
  "Chocolate Coffee": 30,
  "Gudh Coffee": 25,
  "Cold Coffee": 40,
  "Born(Milk) Dudh": 30,
  "Keshar Pista Badam Dudh": 30,
  "Masala Dudh": 30,
};


///This is a global variable which will store the details of Item in current order
Map<String,Item> current_transaction = {};
