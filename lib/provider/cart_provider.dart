import 'package:flutter/foundation.dart';
import 'package:my_ecommerce_app/db/database_helper.dart';
import 'package:my_ecommerce_app/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  SharedPreferences prefs;
  List<ProductModel> _cart;
  int _count = 0;

  List<String> _prodIds;
  List<int> _prodTotalPrices;

  List<ProductModel> get cart => _cart;

  List<String> get prodIds => _prodIds;

  List<int> get prodPrices => _prodTotalPrices;

  CartProvider() {
    _readFromDatabase();
    queryIdFromDatabase();
    getTotalPrices();
  }

  int getCount() {
    if (_cart != null) _count = _cart.length;
    return _count;
  }

  void addToCart(ProductModel model) async {
    _saveToDataBase(model);
    _cart.add(model);
    _prodIds.add(model.prodId);
    _prodTotalPrices.add(model.prodPrice);
    notifyListeners();
  }

  void removeFromCart(ProductModel model) async {
    _deleteFromDatabase(model.prodId);
    _cart.removeWhere((item) {
      return item.prodId == model.prodId;
    });
    _prodIds.remove(model.prodId);
    _prodTotalPrices.remove(model.prodPrice);

    notifyListeners();
    print("Remove From ${cart.length}");
  }

  _saveToDataBase(ProductModel model) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    int id = await helper.insert(model);
    print("inserted row$id");
  }

  _readFromDatabase() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    List<ProductModel> rows = await helper.queryAll();
    _cart = rows;
    notifyListeners();
  }

  _deleteFromDatabase(String id) async {
    DatabaseHelper helper = DatabaseHelper.instance;
    await helper.delete(id);
  }

  queryIdFromDatabase() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    _prodIds = await helper.queryIds();
  }

  getTotalPrices() async {
    DatabaseHelper helper = DatabaseHelper.instance;
    _prodTotalPrices = await helper.queeryPrices();
  }

  deleteAllDatabase() async{
    DatabaseHelper helper = DatabaseHelper.instance;
     await helper.deleteAll();
    _cart.clear();
    _prodIds.clear();
    _prodTotalPrices.clear();
     notifyListeners();
  }
}
