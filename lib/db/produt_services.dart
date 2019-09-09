import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryServices {
  Firestore fireStore = Firestore.instance;
  String category = "category";
  String product="product";

  Stream<QuerySnapshot> getCategory()  {
    Stream<QuerySnapshot> data=
         fireStore.collection(category).snapshots();
    return data;
  }
  Stream<QuerySnapshot> getProductByCategory(String value)  {
    Stream<QuerySnapshot> data =  fireStore.collection(product).where("category",isEqualTo: value).snapshots();
    return data;
  }
  Stream<QuerySnapshot> getProduct()  {
  Stream<QuerySnapshot> data= fireStore.collection(product).orderBy("timeStamp",descending: false).snapshots();
    return data ;
  }

  
}
