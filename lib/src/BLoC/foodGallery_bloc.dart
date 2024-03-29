
// BLOC
//    import 'package:linkupclient/src/Bloc/
import 'package:linkupclient/src/BLoC/bloc.dart';
import 'package:linkupclient/src/DataLayer/models/NewIngredient.dart';


//MODELS
//import 'package:linkupclient/src/DataLayer/itemData.dart';
//    import 'package:linkupclient/src/DataLayer/FoodItem.dart';
import 'package:linkupclient/src/DataLayer/models/FoodItemWithDocID.dart';
//import 'package:linkupclient/src/DataLayer/CategoryItemsLIst.dart';
import 'package:linkupclient/src/DataLayer/models/newCategory.dart';
//import 'package:zomatoblock/DataLayer/location.dart';

import 'package:logger/logger.dart';


import 'package:linkupclient/src/DataLayer/api/firebase_client.dart';


import 'dart:async';


//Firestore should be in FirebaseClient file but for testing putted here:

// import 'package:cloud_firestore/cloud_firestore.dart';
//class LocationBloc implements Bloc {
class FoodGalleryBloc implements Bloc {

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  // id ,type ,title <= Location.

  List<FoodItemWithDocID> _allFoodsList=[];

  List<NewCategoryItem> _allCategoryList=[];

  List<NewIngredient> _allIngItemsFGBloc =[];

  List<NewIngredient> get getAllIngredientsPublicFGB2 => _allIngItemsFGBloc;
  Stream<List<NewIngredient>> get ingredientItemsStream => _allIngredientListController.stream;
  final _allIngredientListController = StreamController <List<NewIngredient>> /*.broadcast*/();



//    List<NewCategoryItem>_allCategoryList=[];
  final _client = FirebaseClient();

  //  getter for the above may be


  List<FoodItemWithDocID> get allFoodItems => _allFoodsList;
  List<NewCategoryItem> get allCategories => _allCategoryList;



  //  The => expr syntax is a shorthand for { return expr; }.
  //  The => notation is sometimes referred to as arrow syntax.

//    BLoC/restaurant_bloc.dart:12:  final _controller = StreamController<List<Restaurant>>();
  // 1
  final _foodItemController = StreamController <List<FoodItemWithDocID>>();
  final _categoriesController = StreamController <List<NewCategoryItem>>();



//  final _controller = StreamController<List<Restaurant>>.broadcast();

  // 2

  // getter that get's the stream with _locationController.stream;

  // CALLED LIKE THIS: stream: BlocProvider.of<LocationBloc>(context).locationStream,

//    Stream<List<Restaurant>> get stream => _controller.stream;


  Stream<List<FoodItemWithDocID>> get foodItemsStream => _foodItemController.stream;

  Stream<List<NewCategoryItem>> get categoryItemsStream => _categoriesController.stream;





  // 3
  // CALLED LIKE THIS:

  //  lib/UI/location_screen.dart:119:            locationBloc.selectLocation(location);
  //  lib/UI/location_screen.dart:131:            locationBloc.selectLocation(location);

  /*
  void selectLocation(Location location) {
    _location = location;
    _locationController.sink.add(location);
  }
  */


// this code bloc cut paste from foodGallery Bloc:
  Future<void> getAllIngredients() async {


    var snapshot = await _client.fetchAllIngredients();
    List docList = snapshot.docs;



    List <NewIngredient> ingItems = new List<NewIngredient>();
    ingItems = snapshot.docs.map((documentSnapshot) =>
        NewIngredient.fromMap
          (documentSnapshot.data(), documentSnapshot.id)

    ).toList();


    List<String> documents = snapshot.docs.map((documentSnapshot) =>
    documentSnapshot.id
    ).toList();

    // print('documents are [Ingredient Documents] at food Gallery Block : ${documents.length}');


    _allIngItemsFGBloc = ingItems;

    _allIngredientListController.sink.add(ingItems);


//    return ingItems;

  }


//  Future<List<FoodItemWithDocID>> getAllFoodItems() async {
  void getAllFoodItems() async {

    var snapshot = await _client.fetchFoodItems();
    List docList = snapshot.docs;

    List<FoodItemWithDocID> tempAllFoodsList= new List<FoodItemWithDocID>();
    docList.forEach((doc) {

      final String foodItemName = doc['name'];
//      print('foodItemName $foodItemName');

      final String foodItemDocumentID = doc.documentID;
//      print('foodItemDocumentID $foodItemDocumentID');

      if(foodItemName =='Junior Juustohampurilainen'){
        logger.e('Junior Juustohampurilainen found check $foodItemDocumentID');
      }



      final String foodImageURL  = doc['image']==''?
      'https://thumbs.dreamstime.com/z/smiling-orange-fruit-cartoon-mascot-character-holding-blank-sign-smiling-orange-fruit-cartoon-mascot-character-holding-blank-120325185.jpg'
          :
      storageBucketURLPredicate + Uri.encodeComponent(doc['image'])
          +'?alt=media';
//      print('doc[\'image\'] ${doc['image']}');



      final bool foodIsAvailable =  doc['available'];


      final Map<String,dynamic> oneFoodSizePriceMap = doc['size'];

      final List<dynamic> foodItemIngredientsList =  doc['ingredient'];
//          logger.i('foodItemIngredientsList at getAllFoodDataFromFireStore: $foodItemIngredientsList');


//          print('foodSizePrice __________________________${oneFoodSizePriceMap['normal']}');

      final String foodCategoryName = doc['category'];
//      print('category: $foodCategoryName');



      final double foodItemDiscount = doc['discount'];

//      print('foodItemDiscount: for $foodItemDocumentID is: $foodItemDiscount');


      FoodItemWithDocID oneFoodItemWithDocID = new FoodItemWithDocID(
        itemName: foodItemName,
        categoryName: foodCategoryName,
        imageURL: foodImageURL,
        sizedFoodPrices: oneFoodSizePriceMap,
        ingredients: foodItemIngredientsList,
        isAvailable: foodIsAvailable,
        documentId: foodItemDocumentID,
        discount: foodItemDiscount,
      );

      tempAllFoodsList.add(oneFoodItemWithDocID);
    }
    );

    _allFoodsList= tempAllFoodsList;

    _foodItemController.sink.add(_allFoodsList);


  }

  //  Future<List<NewCategoryItem>> getAllCategories() async {


  // COPIED TO IDENTITY BLOC



  void getAllCategories() async {


    var snapshot = await _client.fetchCategoryItems();
    List docList = snapshot.docs;


    List<NewCategoryItem> tempAllCategories = new List<NewCategoryItem>();

    docList.forEach((doc) {

      final String categoryItemName = doc['name'];

      final String categoryImageURL  = doc['image']==''?
      'https://thumbs.dreamstime.com/z/smiling-orange-fruit-cartoon-mascot-character-holding-blank-sign-smiling-orange-fruit-cartoon-mascot-character-holding-blank-120325185.jpg'
          :
      storageBucketURLPredicate + Uri.encodeComponent(doc['image'])
          +'?alt=media';

//      print('categoryImageURL in food Gallery Bloc: $categoryImageURL');

      final num categoryRating = doc['rating'];
      final num totalCategoryRating = doc['total_rating'];


      NewCategoryItem oneCategoryItem = new NewCategoryItem(


        categoryName: categoryItemName,
        imageURL: categoryImageURL,
        rating: categoryRating.toDouble(),
        totalRating: totalCategoryRating.toDouble(),

      );

      tempAllCategories.add(oneCategoryItem);
    }
    );

//    NewCategoryItem all = new NewCategoryItem(
//      categoryName: 'All',
//      imageURL: 'None',
//      rating: 0,
//      totalRating: 5,
//
//    );

    _allCategoryList= tempAllCategories;

    _categoriesController.sink.add(_allCategoryList);
    //    _foodItemController.sink.add(_allCategoryList);
    //    return _allFoodsList;

  }





  // CONSTRUCTOR BIGINS HERE..
  FoodGalleryBloc() {

    // need to use this when moving to food Item Details page.
    getAllIngredients();

    getAllFoodItems();

    getAllCategories();

//    getAllIngredients();
    // invoking this here to make the transition in details page faster.

//    this.getAllFoodItems();
//    this.getAllCategories();

  }

  // CONSTRUCTOR ENDS HERE..




  // 4
  @override
  void dispose() {
    _foodItemController.close();
    _categoriesController.close();
    _allIngredientListController.close();
//    _allIngredientListController.close();
  }
}