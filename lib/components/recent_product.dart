import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/commens/loading.dart';
import 'package:my_ecommerce_app/components/single_product.dart';
import 'package:my_ecommerce_app/db/produt_services.dart';
import 'package:my_ecommerce_app/models/product_model.dart';

class Product extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateProduct();
  }
}

class StateProduct extends State<Product> {
  CategoryServices services = new CategoryServices();
  ProductModel model;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: services.getProduct(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            print("retrieve users do not have data.");
            return Loading();
          }
          return GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                try {
                  final DocumentSnapshot userDoc =
                      snapshot.data.documents[index];
                  model = new ProductModel(
                      prodName: userDoc["name"],
                      prodId: userDoc["id"],
                      prodBrand: userDoc["brand"],
                      prodImage: userDoc["imageURL"],
                      prodCategory: userDoc["category"],
                      prodPrice: userDoc["price"],
                      quantity: userDoc["quantity"],
                      color: userDoc["color"],
                      size: userDoc["size"]);
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SingleProduct(model, index),
                  );
                } catch (e) {
                  print(e);
                  return (Container());
                }
              },
              itemCount: snapshot.data.documents.length);
        });
  }
}
