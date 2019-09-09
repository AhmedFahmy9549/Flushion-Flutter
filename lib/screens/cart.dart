import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/components/cart_product_details.dart';
import 'package:my_ecommerce_app/components/cart_products.dart';
import 'package:my_ecommerce_app/db/users_services.dart';
import 'package:my_ecommerce_app/models/product_model.dart';
import 'package:my_ecommerce_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';

class CartPage extends StatefulWidget {

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int totalPrices = 0;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CartProvider>(context);
    List<int> pricesList = bloc.prodPrices;
    calculateTotalPrices(pricesList);

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Color(0xffffcb2b),
        title: InkWell(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage())),
          child: Text("Cart"),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text("Cart Subtotal (${bloc.cart.length} item): $totalPrices"),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 12.0, bottom: 20.0),
            child: MaterialButton(
              textColor: Colors.white,
              padding: EdgeInsets.all(15.0),
              child: Text("Proceed to CheckOut"),
              onPressed: () {},
              color: Color(0xff232323),
            ),
          ),
          Divider(
            height: 5.0,
            color: Colors.grey,
          ),
          Container(height: 400.0, child: CartProductDetails()),
        ],
      ),

      //CartProducts(),

      /*   bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text(
                  "Total:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("\$$totalPrices"),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: () {
                  checkOut();
                  bloc.deleteAllDatabase();
                },
                color: Colors.red,
                textColor: Colors.white,
                child: Text("Check out"),
              ),
            )
          ],
        ),
      ),*/
    );
  }

  void calculateTotalPrices(List<int> pricesList) {
    if(pricesList==null)return;
    if (pricesList.length > 0) {
      totalPrices = pricesList.reduce((a, b) => a + b);
    }
  }

  void checkOut() {
    UserServices services = new UserServices();
    Map<String, dynamic> data = {"total": totalPrices};
    services.checkOut("Ahmed", data);
    Fluttertoast.showToast(msg: "Check Out Complete");
    totalPrices = 0;
  }
}
