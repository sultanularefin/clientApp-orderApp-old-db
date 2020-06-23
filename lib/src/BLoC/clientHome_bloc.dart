
// BLOC
//    import 'package:linkupclient/src/Bloc/
import 'package:linkupclient/src/BLoC/bloc.dart';
import 'package:linkupclient/src/DataLayer/models/NewIngredient.dart';


//MODELS
//import 'package:linkupclient/src/DataLayer/itemData.dart';
//    import 'package:linkupclient/src/DataLayer/FoodItem.dart';
import 'package:linkupclient/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:linkupclient/src/DataLayer/models/Restaurant.dart';
//import 'package:linkupclient/src/DataLayer/CategoryItemsLIst.dart';
import 'package:linkupclient/src/DataLayer/models/newCategory.dart';
//import 'package:zomatoblock/DataLayer/location.dart';




import 'package:linkupclient/src/DataLayer/api/firebase_client.dart';


import 'dart:async';


//Firestore should be in FirebaseClient file but for testing putted here:

// import 'package:cloud_firestore/cloud_firestore.dart';
//class LocationBloc implements Bloc {
class ClientHomeBloc implements Bloc {


  // id ,type ,title <= Location.

  Restaurant _thisRestaurant ;

  Restaurant get getCurrentRestaurant => _thisRestaurant;
  final _restaurantController = StreamController <Restaurant>();
  Stream<Restaurant> get getCurrentRestaurantsStream => _restaurantController.stream;

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


  /*
  Future<void> getRestaurantInformation() async{
    var snapshot = await _client.fetchRestaurantData();
    List docList = snapshot.documents;



    List <NewIngredient> ingItems = new List<NewIngredient>();
    ingItems = snapshot.documents.map((documentSnapshot) =>
        NewIngredient.fromMap
          (documentSnapshot.data, documentSnapshot.documentID)

    ).toList();


    List<String> documents = snapshot.documents.map((documentSnapshot) =>
    documentSnapshot.documentID
    ).toList();

    // print('documents are [Ingredient Documents] at food Gallery Block : ${documents.length}');


    _allIngItemsFGBloc = ingItems;

    _allIngredientListController.sink.add(ingItems);


//    return ingItems;
  }

  */





  Future<void> getRestaurantInformation() async{

    var snapshot = await _client.fetchRestaurantDataClient();

    //    List docList = snapshot.documents;

    /*
    Map     <String,dynamic> address;
    Map     <String,dynamic> attribute;
    List    <dynamic> cousine;
    bool    kidFriendly; // kid_friendly
    bool    reservation;
    bool    romantic;
    List    <String> offday;
    String  open;
    String  avatar;
    String  contact;
    double  deliveryCharge;
    double  discount;// from string;// need to convert string to double.
    String  name;
    double  rating;
    double  totalRating;
    */



    Map     <String,dynamic> restaurantAddress = snapshot['address'];
    Map     <String,dynamic> restaurantAttribute = snapshot['attribute'];
    List    <dynamic> restaurantCousine = snapshot['cousine'];
    bool    restaurantKidFriendly =  snapshot['kid_friendly'];
    bool    restaurantReservation = snapshot['reservation'];
    bool    restaurantRomantic  = snapshot['romantic'];
    List    <String> restaurantOffday = snapshot['offday'];

    String  restaurantOpen = snapshot['open'];



    String  restaurantAvatar =snapshot['avatar']==''?
    'https://thumbs.dreamstime.com/z/smiling-orange-fruit-cartoon-mascot-character-holding-blank-sign-smiling-orange-fruit-cartoon-mascot-character-holding-blank-120325185.jpg'
        :''
        + storageBucketURLPredicate +
        Uri.encodeComponent(snapshot['avatar'])
        +'?alt=media';
    // 'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/'

    print('restaurantAvatar: $restaurantAvatar');
    //   https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/restaurantImages%2Fnoutupizzerai.png?
    // alt=media&token=0a53af83-078f-4392-a1cf-e14cd584c6a1

//    https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/restaurantImagesnoutupizzerai.png?alt=media
//    https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/restaurantImages/noutupizzerai.png?alt=media
//    https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/restaurantImages/noutupizzerai.png?alt=media
//    https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/restaurantImages%2Fnoutupizzerai.png?alt=media
// restaurantImages/noutupizzerai.png

    String  restaurantContact= snapshot['contact'];

    double  restaurantDeliveryCharge = snapshot['deliveryCharge'];
    int restaurantDiscount0 =snapshot['discount'];// from string;// need to convert string to double.
    print('restaurantDiscount0-> $restaurantDiscount0 is : ' is num);
    print('restaurantDiscount0-> $restaurantDiscount0 is : ' is int);
    print('restaurantDiscount0-> $restaurantDiscount0 is : ' is double);
    print('restaurantDiscount0-> $restaurantDiscount0 is : ' is String);

    final double restaurantDiscount = restaurantDiscount0.toDouble();
//    final double foodItemDiscount = doc['discount'];
    String  restaurantName =snapshot['name'];

    print('restaurantName: $restaurantName');
    double  restaurantRating =snapshot['rating'];
    double  restaurantTotalRating =snapshot['totalRating'];

//      print('foodItemName $foodItemName');

    /*
      final String foodImageURL  = doc['image']==''?
      'https://thumbs.dreamstime.com/z/smiling-orange-fruit-cartoon-mascot-character-holding-blank-sign-smiling-orange-fruit-cartoon-mascot-character-holding-blank-120325185.jpg'
          :
      storageBucketURLPredicate + Uri.encodeComponent(doc['image'])
          +'?alt=media';
      */
//      print('doc[\'image\'] ${doc['image']}');



    //final bool foodIsAvailable =  doc['available'];


    //final Map<String,dynamic> oneFoodSizePriceMap = doc['size'];

    // final List<dynamic> foodItemIngredientsList =  doc['ingredient'];
//          logger.i('foodItemIngredientsList at getAllFoodDataFromFireStore: $foodItemIngredientsList');


//          print('foodSizePrice __________________________${oneFoodSizePriceMap['normal']}');

    // final String foodCategoryName = doc['category'];
//      print('category: $foodCategoryName');

    //final String foodItemDocumentID = doc.documentID;
//      print('foodItemDocumentID $foodItemDocumentID');

    //final double foodItemDiscount = doc['discount'];

//      print('foodItemDiscount: for $foodItemDocumentID is: $foodItemDiscount');


    /*
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
      */

    Restaurant onlyRestaurant = new Restaurant(
      address:restaurantAddress,
      attribute: restaurantAttribute,
      cousine: restaurantCousine,
      kidFriendly:restaurantKidFriendly, // kid_friendly
      reservation:restaurantReservation,
      romantic:restaurantRomantic,
      offday:restaurantOffday,
      open: restaurantOpen,
      avatar: restaurantAvatar,
      contact: restaurantContact,
      deliveryCharge: restaurantDeliveryCharge,
      discount: restaurantDiscount,// from string;// need to convert string to double.
      name: restaurantName,
      rating: restaurantRating,
      totalRating :restaurantTotalRating,
    );

    _thisRestaurant= onlyRestaurant;
    _restaurantController.sink.add(_thisRestaurant);

//    _foodItemController.sink.add(_allFoodsList);

  }


  Future<void> getAllIngredients() async {


    var snapshot = await _client.fetchAllIngredients();
    List docList = snapshot.documents;



    List <NewIngredient> ingItems = new List<NewIngredient>();
    ingItems = snapshot.documents.map((documentSnapshot) =>
        NewIngredient.fromMap
          (documentSnapshot.data, documentSnapshot.documentID)

    ).toList();


    List<String> documents = snapshot.documents.map((documentSnapshot) =>
    documentSnapshot.documentID
    ).toList();

    // print('documents are [Ingredient Documents] at food Gallery Block : ${documents.length}');


    _allIngItemsFGBloc = ingItems;

    _allIngredientListController.sink.add(ingItems);


//    return ingItems;

  }


//  Future<List<FoodItemWithDocID>> getAllFoodItems() async {
  void getAllFoodItems() async {

    var snapshot = await _client.fetchFoodItems();
    List docList = snapshot.documents;

    docList.forEach((doc) {

      final String foodItemName = doc['name'];
//      print('foodItemName $foodItemName');



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

      final String foodItemDocumentID = doc.documentID;
//      print('foodItemDocumentID $foodItemDocumentID');

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

      _allFoodsList.add(oneFoodItemWithDocID);
    }
    );

    _foodItemController.sink.add(_allFoodsList);


  }

  //  Future<List<NewCategoryItem>> getAllCategories() async {


  // COPIED TO IDENTITY BLOC
/*

  Future getAllIngredients() async {


    var snapshot = await _client.fetchAllIngredients();
    List docList = snapshot.documents;



    List <NewIngredient> ingItems = new List<NewIngredient>();
    ingItems = snapshot.documents.map((documentSnapshot) =>
        NewIngredient.fromMap
          (documentSnapshot.data, documentSnapshot.documentID)

    ).toList();


    List<String> documents = snapshot.documents.map((documentSnapshot) =>
    documentSnapshot.documentID
    ).toList();

    print('documents are [Ingredient Documents] at food Gallery Block : ${documents.length}');


    _allIngItemsFGBloc = ingItems;

    _allIngredientListController.sink.add(ingItems);


//    return ingItems;

  }

  */


  void getAllCategories() async {


    var snapshot = await _client.fetchCategoryItems();
    List docList = snapshot.documents;


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

      _allCategoryList.add(oneCategoryItem);
    }
    );

    NewCategoryItem all = new NewCategoryItem(
      categoryName: 'All',
      imageURL: 'None',
      rating: 0,
      totalRating: 5,

    );

    _allCategoryList.add(all);

    _categoriesController.sink.add(_allCategoryList);
    //    _foodItemController.sink.add(_allCategoryList);
    //    return _allFoodsList;

  }





  // CONSTRUCTOR BIGINS HERE..
  ClientHomeBloc() {

    // need to use this when moving to food Item Details page.
    getAllIngredients();

    getAllFoodItems();

    getAllCategories();

    getRestaurantInformation();

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
    _restaurantController.close();
//    _allIngredientListController.close();
  }
}