import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/models/product_model.dart';
import 'package:my_ecommerce_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class CartProducts extends StatefulWidget {


  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {

  @override
  Widget build(BuildContext context) {
    final bloc=Provider.of<CartProvider>(context);
    bloc.cart;
    List<ProductModel >listItem=bloc.cart;
    return listItem.length==0?Center(child: Text("Empty"),): ListView.builder(
        itemCount: listItem.length,
        itemBuilder: (context, index) {
          return SingleCartProducts(
            cartProductName: listItem[index].prodName,
            cartProductPicture: listItem[index].prodImage,
            cartProductPrice: listItem[index].prodPrice,
            cartProductQuantity: listItem[index].quantity,
          );
        });
  }
}

class SingleCartProducts extends StatelessWidget {
  final String cartProductName;
  final String cartProductPicture;
  final String cartProductSize;
  final String cartProductColor;
  final int cartProductPrice;
  final int cartProductQuantity;

  SingleCartProducts(
      {this.cartProductName,
      this.cartProductPicture,
      this.cartProductSize,
      this.cartProductColor,
      this.cartProductPrice,
      this.cartProductQuantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
              leading: Image.network(
                cartProductPicture,
              ),
              title: new Text(cartProductName),
              subtitle: new Column(
                children: <Widget>[

                  Container(
                      alignment: Alignment.topLeft,
                      child: new Text(
                        "\$$cartProductPrice",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Column(
              children: <Widget>[
                IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: () {}),
                new Text("$cartProductQuantity"),
                IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: () {})
              ],
            ),
          )
        ],
      ),
    );
  }
}
