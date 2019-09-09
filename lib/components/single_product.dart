import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/commens/constants.dart';
import 'package:my_ecommerce_app/models/product_model.dart';
import 'package:my_ecommerce_app/provider/cart_provider.dart';
import 'package:my_ecommerce_app/screens/product_detailss.dart';
import 'package:provider/provider.dart';

class SingleProduct extends StatefulWidget {
  final ProductModel model;
  final int index;

    SingleProduct(this.model,this.index);

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  Color cartColor=Colors.black;
  IconData cartIcon = Icons.add_shopping_cart;
  List<String> productIds;



  @override
  Widget build(BuildContext context) {
    //cartColor=Colors.grey[900];
    final bloc=Provider.of<CartProvider>(context);
    productIds=bloc.prodIds;
    checkCartColor();
    return Card(
      child: Hero(
          tag: new Text("hero1"),
          child: Material(
            child: InkWell(
              onTap: () {

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetailss(widget.model)));
              },
              child: GridTile(
                  footer: Container(
                    color: Colors.black.withOpacity(0.6),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(widget.model.prodName,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )),
                          Column(
                            children: <Widget>[
                              Text(
                                "\$${widget.model.prodPrice}",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w800),
                              ),
                              Text(
                                "\$${widget.model.prodPrice + 27}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    decoration: TextDecoration.lineThrough),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                                if (cartColor == Colors.green) {
                                  bloc.removeFromCart(widget.model);
                                  cartColor = Colors.grey[900];
                                  cartIcon = Icons.add_shopping_cart;
                                } else {
                                  bloc.addToCart(widget.model);
                                  cartColor = Colors.green;
                                  cartIcon = Icons.shopping_cart;
                                }

                            },
                            child: CircleAvatar(
                                backgroundColor:cartColor,
                                radius: 15.0,
                                child: Icon(
                                cartIcon,
                                  color: Colors.white,
                                  size: 18.0,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  child: Image.network(
                    widget.model.prodImage,
                    fit: BoxFit.cover,
                  )),
            ),
          )),
    );
  }

  void checkCartColor() async{
    if(productIds!=null) {
      String value = (widget.model.prodId);
      if (productIds.contains(value)) {
        cartColor = Colors.green;
        cartIcon = Icons.shopping_cart;
      }
    }


  }
}
