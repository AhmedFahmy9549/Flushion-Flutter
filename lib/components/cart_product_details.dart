import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/models/product_model.dart';
import 'package:my_ecommerce_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import '../commens/constants.dart';

class CartProductDetails extends StatefulWidget {
  @override
  _CartProductDetailsState createState() => _CartProductDetailsState();
}

class _CartProductDetailsState extends State<CartProductDetails> {
  List<ProductModel> listItem;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<CartProvider>(context);
    bloc.cart;
    listItem = bloc.cart;
    return listItem.length == 0
        ? Center(
            child: Text("Empty"),
          )
        : ListView.builder(
            itemCount: listItem.length,
            itemBuilder: (BuildContext context, int i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),

                // --------------- Deletes the items in the cart by swiping ----------
                child: Dismissible(
                    key: Key(listItem[i].prodName),
                    onDismissed: (direction) {
                      setState(() {
                        listItem.removeAt(i);
                      });
                      // ------------------- Trying to Implement Undo operation ------------------
                      // Scaffold.of(context).showSnackBar(
                      //   SnackBar(
                      //     content: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //       children: <Widget>[
                      //         Expanded(
                      //             child: Text(
                      //                 "${_productsAddedInTheCart[i]["name"]} dismissed")),
                      //         Expanded(child: Text("Undo")),
                      //       ],
                      //     ),
                      //   ),
                      // );
                    },
                    background: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: kPrimaryColor,
                      ),
                      child: Center(
                        child: ListTile(
                          leading: Text(
                            "Archive",
                            style: TextStyle(color: Colors.white),
                          ),
                          trailing: Icon(
                            Icons.delete_outline,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // color: Colors.red,
                    ),
                    child: CardRowItem(
                      listProduct: listItem[i],
                      incrementFunc: (){incrementInQty(i);},
                      decrementFunc:  (){decrementInQty(i);}
                      ,
                    )),
              );
            },
          );
  }

  void incrementInQty(int index) {
    setState(() {
      listItem[index].quantity += 1;
    });
  }

 decrementInQty(int index) {
    if(listItem[index].quantity==1)
      return;
    setState(() {
      listItem[index].quantity -= 1;
    });
  }
}

class CardRowItem extends StatelessWidget {
  final ProductModel listProduct;
  final Function incrementFunc;
  final Function decrementFunc;

  CardRowItem({@required this.listProduct,@required this.incrementFunc,@required this.decrementFunc});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.network(
                listProduct.prodImage,
              ),
              title: Text("${listProduct.prodName}",),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "₹",
                  ),
                  Expanded(
                      child: Text(
                    " ${listProduct.prodPrice}",

                  )),
                  IconButton(
                    icon: Icon(Icons.arrow_drop_down),
                    onPressed: decrementFunc,
                  ),
                  Text(
                    "${listProduct.quantity}",
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_drop_up),
                    onPressed: incrementFunc,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: Text(
                  "Qty: ${listProduct.quantity}",
                )),
                Expanded(
                    child: Text(
                  "Size: ${listProduct.size}",
                )),
                Expanded(
                  child: Text(
                    "Color: ${listProduct.color}",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
