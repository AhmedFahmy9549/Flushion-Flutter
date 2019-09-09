import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/db/produt_services.dart';
import 'package:my_ecommerce_app/screens/categories.dart';

class HorizontalList1 extends StatefulWidget {
  @override
  _HorizontalList1State createState() => _HorizontalList1State();
}

class _HorizontalList1State extends State<HorizontalList1> {
  CategoryServices categoryServices = new CategoryServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.grey[300],
      height: 120,
      child: StreamBuilder<QuerySnapshot>(
        stream: categoryServices.getCategory(),
        builder: (context, snapshot) {
        /*  if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading... "),
            );
          } else {*/
          if (!snapshot.hasData || snapshot.data == null) {
            print("retrieve users do not have data.");
            return Container();
          }
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot userDoc = snapshot.data.documents[index];
                  String catgName=userDoc["catgeory"];
                  /*return InkWell(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoriesPage(catgName) ) ),
                    child: Container(
                      width: 120,
                      height: 120,
                      child: ListTile(
                        title: Image.network(
                          userDoc["image"],
                          fit: BoxFit.fill,
                        ),
                        subtitle: Container(
                            alignment: Alignment.topCenter,
                            child: Text(
                              catgName,
                              style: new TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w900),
                            )),
                      ),
                    ),
                  );*/
                  return InkWell(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoriesPage(catgName) ) ),
                    child: Card(
                      elevation: 5,

                      color:Colors.grey[200]  ,
                      child: Column(children: <Widget>[
                        Image.network(
                          userDoc["image"],
                          width: 110,
                          height: 90,
                        ),
                        Text(catgName,style:  TextStyle(
                          color: Colors.black,fontWeight: FontWeight.w500,
                            fontSize: 13, ),)],),

                    ),
                  );
                });

        },
      ),
    );
  }
}


