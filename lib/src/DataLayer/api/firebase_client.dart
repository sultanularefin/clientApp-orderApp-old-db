/*
 * Copyright (c) 2019 Razeware LLC
 *
 */

import 'dart:async';
//import 'dart:convert' show json;

import 'package:linkupclient/src/DataLayer/models/NewIngredient.dart';
import 'package:linkupclient/src/DataLayer/models/Order.dart';
//import 'package:http/http.dart' as http;
import 'package:linkupclient/src/DataLayer/models/SelectedFood.dart';
//import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:zomatoblock/UI/restaurant_tile.dart';
//import './../Config/Secret.dart';


//import 'location.dart';
//import 'restaurant.dart';

//import 'package:linkupclient/src/DataLayer/itemData.dart';
//    import 'package:linkupclient/src/DataLayer/FoodItem.dart';
import 'package:linkupclient/src/DataLayer/models/FoodItemWithDocID.dart';
//import 'package:linkupclient/src/DataLayer/CategoryItemsLIst.dart';
//    ''file:
///C:/Users/Taxi/Programs/foodgallery/lib/src/DataLayer/models/newCategory.dart'tegory.dart';




final String storageBucketURLPredicate =
    'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/';

class OrderedFood{
  final String category;      // one of foodItems> collection.
//  final String foodItemImageURL;
  final double discount;
  final String image;
//  int          quantity;
//  final String foodItemSize;
// final String foodItemOrderID;     // random might not be needed.
//  List<NewIngredient> selectedIngredients;
//
//  category
//  default_sauces
//  discount
//  image

  OrderedFood(
      {
        this.category,
        this.discount,
        this.image,
//        this.foodDocumentId,
//        this.quantity,
//        this.foodItemSize,
//        this.selectedIngredients,

        // this.foodItemOrderID,
      }
      );

}

class FirebaseClient {
//  final _apiKey = zomatoKey;
//  final _host = 'developers.zomato.com';
//  final _contextRoot = 'api/v2.1';

  List<FoodItemWithDocID> _allFoodsList = [];


  Future<QuerySnapshot> fetchFoodItems() async {

    // print ('at here fetchFoodItems ==================================== *************** ');

    /*
    var snapshot= Firestore.instance
        .collection("restaurants").document('kebab_bank').collection('foodItems').limit(65)
        .getDocuments();
    */





    var snapshot= FirebaseFirestore.instance
        .collection("restaurants").doc('kebab_bank').collection('foodItems').
    orderBy('sl',descending: false)
        // .getDocuments();
        .get();

    return snapshot;

  }


  Future<QuerySnapshot> fetchBestSellingFoods() async {

    // print ('at here fetchFoodItems ==================================== *************** ');

    /*
    var snapshot= Firestore.instance
        .collection("restaurants").document('kebab_bank').collection('foodItems').limit(65)
        .getDocuments();
    */


//    await firestoreInstance
//        .collection("countries")
//        .where("countryName", whereIn: ["italy","lebanon"])
//        .getDocuments();

    var snapshot=  /*Firestore.instance*/ FirebaseFirestore.instance
        .collection("restaurants").doc('kebab_bank').collection('foodItems').limit(15)
//        .where("name", whereIn: ["kana", "juusto"])
//         .getDocuments();
        .get();

    // .collection("restaurants").docs('USWc8IgrHKdjeDe9Ft4j').collection('foodItems').limit(15)

    return snapshot;

  }




  Future<DocumentSnapshot> fetchRestaurantDataClient() async{

    var snapshot = FirebaseFirestore.instance
        .collection('restaurants')
        // .document('kebab_bank')
        .doc('kebab_bank')
        .get();
    /*
        .then((DocumentSnapshot ds) {
      // use ds as a snapshot
    });*/
    /*
    var snapshot = await Firestore.instance.collection("restaurants")
        .document('kebab_bank');

//    var snapshot= Firestore.instance
//        .collection("restaurants").document('kebab_bank').collection('foodItems')
//        .getDocuments();

    return snapshot;

     */
    return snapshot;
  }
  Future<QuerySnapshot> fetchAllIngredients()async{

    // print ('at here fetchAllIngredients ==================================== *************** ');

    var snapshot = await FirebaseFirestore.instance.collection("restaurants")
        .doc('kebab_bank')
        .collection('ingredients')
        .get();

//    var snapshot= Firestore.instance
//        .collection("restaurants").document('kebab_bank').collection('foodItems')
//        .getDocuments();

    return snapshot;
  }

  List <Map<String, dynamic>> /*<OrderedFood>*/ converterIngredients(List<NewIngredient> si){

//    ingredientName;
//    imageURL;
//    price;
//    documentId;
//    ingredientAmountByUser


    List<Map<String, dynamic>> testIngredients = new List<Map<String, dynamic>>();
    int counter=0;
    si.forEach((oneIngredient) {

      //  print('si[counter].imageURL}: ${si[counter].imageURL}');
      var identifier = {

        'type': 0,
        'name': si[counter].ingredientName,
        'image': Uri.decodeComponent(si[counter].imageURL.replaceAll(
            'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/',
            '').replaceAll('?alt=media', '')),
//        ROzgCEcTA7J9FpIIQJra
        'ingredientAmountByUser': si[counter].ingredientAmountByUser,

      };
      testIngredients.add(identifier);
      counter ++;


    });
    return testIngredients;
//    return sf.length

  }


  List <Map<String, dynamic>> /*<OrderedFood>*/ convertedFoods (List<SelectedFood> sf){

    List<Map<String, dynamic>> testFoodItems = new List<Map<String, dynamic>>();
    int counter=0;
    sf.forEach((oneFood) {

      // print('sf[counter].foodItemImageURL: ${sf[counter].foodItemImageURL}');
      var identifier = {

        'category': sf[counter].categoryName,
        'discount': sf[counter].discount,
        'image': Uri.decodeComponent(sf[counter].foodItemImageURL.replaceAll(
            'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/',
            '').replaceAll('?alt=media', '')),
//        ROzgCEcTA7J9FpIIQJra
        'quantity': sf[counter].quantity,
        'defult_sauces':[],
        'ingredient':converterIngredients(sf[counter].selectedIngredients),
      };
      testFoodItems.add(identifier);
      counter ++;


    });
    return testFoodItems;
//    return sf.length

  }


  Future<String> insertOrder(Order currentOrderToFirebase,
      String orderBy, String paidType)async {
    // print('currentOrderToFirebaseL: $currentOrderToFirebase');
    /*print('currentOrderToFirebase.selectedFoodInOrder: '
        '${currentOrderToFirebase.selectedFoodInOrder}'); */

    List<SelectedFood> tempSelectedFood = currentOrderToFirebase.selectedFoodInOrder;

    var map1 = Map.fromIterable(tempSelectedFood, key: (e)
    => e.foodItemName, value: (e)=>e.foodItemName,

//    key:'category', value:'t',
    ); /*{

      e.foodItemImageURL;
      e.unitPrice;
      e.foodDocumentId;
      e.quantity;
      e.foodItemSize;

    }*/
//    );
    // print('map1 $map1');

    String orderDocId='';
    // print('saving order data using a web service');

    DocumentReference document = await FirebaseFirestore.instance.collection(
        "restaurants").
    doc('kebab_bank').
    collection('orderList').add(<String, dynamic>{

      'address': {
        'apartNo': currentOrderToFirebase.ordersCustomer.flatOrHouseNumber,
        'geo': [0, 0],
        'state': currentOrderToFirebase.ordersCustomer.address,

      },
      'contact': currentOrderToFirebase.ordersCustomer.phoneNumber,
      'driver': 'mhmd',
      'end': FieldValue.serverTimestamp(),
//      'items': [],

      'items': convertedFoods(tempSelectedFood),
      'orderby': orderBy,
      'p_status': paidType != 'Later' ? 'Paid' : 'Unpaid',
      'p_type': paidType,
      'price': currentOrderToFirebase.totalPrice,
      'start': FieldValue.serverTimestamp(),
      'status': "ready",
      'table_no': '33',
      'type': orderBy == 'Phone' ? 'Phone' : orderBy == 'Delivery'
          ? 'Delivery'
          : orderBy == 'TakeAway' ? 'TakeAway' : 'DinningRoom',


    }).whenComplete(() => print("called when future completes"))
        .then((document) {
      //  print('Added document with ID: ${document.documentID}');
      orderDocId= document.id;
//      return document;
//                            _handleSignIn();
    }).catchError((onError) {
      //   print('K   K    K   at onError for Order data push : $onError');
      orderDocId= '';
//      return '';
    });

    return orderDocId;


  }

  Future<QuerySnapshot> fetchCategoryItems() async {



    //print ('at here fetchCategories ==================================== *************** ');

    var snapshot= FirebaseFirestore.instance
        .collection("restaurants").doc('kebab_bank').
    collection('categories').orderBy("rating", descending: true)
        .get();

    return snapshot;

  }



/*
  Future<List<Restaurant>> fetchRestaurants(
      Location location, String query) async {
    final results = await request(path: 'search', parameters: {
      'entity_id': location.id.toString(),
      'entity_type': location.type,
      'q': query,
      'count': '10'
    });

    final restaurants = results['restaurants']
        .map<Restaurant>((json) => Restaurant.fromJson(json['restaurant']))
        .toList(growable: false);

    return restaurants;
  }

  Future<Map> request(
      {@required String path, Map<String, String> parameters}) async {
    final uri = Uri.https(_host, '$_contextRoot/$path', parameters);
    final results = await http.get(uri, headers: _headers);
    final jsonObject = json.decode(results.body);
    return jsonObject;
  }

  Map<String, String> get _headers =>
      {
        'Accept': 'application/json', 'user-key': _apiKey};

  */
}
