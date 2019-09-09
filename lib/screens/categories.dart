import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/components/single_product.dart';
import 'package:my_ecommerce_app/db/produt_services.dart';
import 'package:my_ecommerce_app/models/product_model.dart';
import 'package:my_ecommerce_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';

import 'cart.dart';

class CategoriesPage extends StatefulWidget {

  final String catgName;

  const CategoriesPage(this.catgName);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  CategoryServices services = new CategoryServices();
  ProductModel model;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.catgName),
        actions: <Widget>[
          new IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
                height: 150.0,
                width: 30.0,
                child: new GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                  },
                  child: new Stack(
                    children: <Widget>[
                      new IconButton(
                        icon: new Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        onPressed: null,
                      ),
                      new Positioned(
                          child: new Stack(
                        children: <Widget>[
                          new Icon(Icons.brightness_1,
                              size: 20.0, color: Colors.green[700]),
                          new Positioned(
                              top: 3.0,
                              right: 7,
                              child: new Center(
                                child: new Text(
                                  "${bloc.getCount()}",
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              )),
                        ],
                      )),
                    ],
                  ),
                )),
          )
        ],
      ),
      body: Container(
        color: Colors.grey[350],
        child: StreamBuilder<QuerySnapshot>(
            stream: services.getProductByCategory(widget.catgName),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                print("retrieve users do not have data.");
                return Container();
              }
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot userDoc =
                        snapshot.data.documents[index];
                    model = new ProductModel(
                      prodName: userDoc["name"],
                      prodId: userDoc["id"],
                      prodBrand: userDoc["brand"],
                      prodImage: userDoc["imageURL"],
                      prodCategory: userDoc["category"],
                      prodPrice: userDoc["price"],
                      size: userDoc["size"],
                      color: userDoc["color"],
                    );
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: SingleProduct(model, index),
                    );
                  },
                  itemCount: snapshot.data.documents.length);
            }),
      ),
    );
  }
}
