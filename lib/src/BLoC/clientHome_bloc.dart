
// BLOC
//    import 'package:linkupclient/src/Bloc/
import 'package:linkupclient/src/BLoC/bloc.dart';
import 'package:linkupclient/src/DataLayer/models/MenuOfferCartTabTypeSingleSelect.dart';
import 'package:linkupclient/src/DataLayer/models/NewIngredient.dart';
import 'package:logger/logger.dart';

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

  var logger = Logger(
    printer: PrettyPrinter(),
  );

  // id ,type ,title <= Location.

  Restaurant _thisRestaurant ;

  Restaurant get getCurrentRestaurant => _thisRestaurant;
  final _restaurantController = StreamController <Restaurant>();
  Stream<Restaurant> get getCurrentRestaurantsStream => _restaurantController.stream;

  List<FoodItemWithDocID> _allFoodsList=[];
  List<FoodItemWithDocID> _bestSelling =[];

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
  List<FoodItemWithDocID> get getAllBestSellingFoodItems => _bestSelling;



  //  The => expr syntax is a shorthand for { return expr; }.
  //  The => notation is sometimes referred to as arrow syntax.

//    BLoC/restaurant_bloc.dart:12:  final _controller = StreamController<List<Restaurant>>();
  // 1
  final _foodItemController = StreamController <List<FoodItemWithDocID>>();
  final _categoriesController = StreamController <List<NewCategoryItem>>();
  final _bestSellingFoodItemsController = StreamController <List<FoodItemWithDocID>>();




//  final _controller = StreamController<List<Restaurant>>.broadcast();

  // 2

  // getter that get's the stream with _locationController.stream;

  // CALLED LIKE THIS: stream: BlocProvider.of<LocationBloc>(context).locationStream,

//    Stream<List<Restaurant>> get stream => _controller.stream;


  Stream<List<FoodItemWithDocID>> get foodItemsStream => _foodItemController.stream;

  Stream<List<NewCategoryItem>> get categoryItemsStream => _categoriesController.stream;
  Stream<List<FoodItemWithDocID>> get bestSellingFoodItemsStream => _bestSellingFoodItemsController.stream;



  List<MenuOfferCartTabTypeSingleSelect>   _allTabTypes;
  List<MenuOfferCartTabTypeSingleSelect> get getCurrentTabType => _allTabTypes;

  final _clientHomeTabController = StreamController <List<MenuOfferCartTabTypeSingleSelect>>.broadcast();
  Stream  <List<MenuOfferCartTabTypeSingleSelect>> get getCurrentTabTypeSingleSelectStream =>
      _clientHomeTabController.stream;







  Future<void> getRestaurantInformation() async{

    var snapshot = await _client.fetchRestaurantDataClient();


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



    List<FoodItemWithDocID> tempAllFoodsList =new List<FoodItemWithDocID>();
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
      final int foodItemSL = doc['sl'];

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
        sl:foodItemSL,
      );

      tempAllFoodsList.add(oneFoodItemWithDocID);
    }
    );

    _allFoodsList =tempAllFoodsList;

    _foodItemController.sink.add(_allFoodsList);



  }

  void getBestSellingFoodItems() async {

    var snapshot = await _client.fetchBestSellingFoods();

    List docList = snapshot.documents;



    List<FoodItemWithDocID> tempBestSellingFoodsList =new List<FoodItemWithDocID>();
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
      final int foodItemSL = doc['sl'];

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
        sl:foodItemSL,
      );

      tempBestSellingFoodsList.add(oneFoodItemWithDocID);
    }
    );

    _bestSelling = tempBestSellingFoodsList.sublist(8,14);

    logger.e('bestSelling: $_bestSelling');
    print('bestSelling: $_bestSelling');
//    _bestSelling= bestSelling;
    _bestSellingFoodItemsController.sink.add(_bestSelling);

  }



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

    getBestSellingFoodItems();

    initiateMenuOfferCartTypeSingleSelectOptions();

//    getAllIngredients();
    // invoking this here to make the transition in details page faster.

//    this.getAllFoodItems();
//    this.getAllCategories();

  }

  // CONSTRUCTOR ENDS HERE..


  void initiateMenuOfferCartTypeSingleSelectOptions()
  {
//    MenuOfferCartTabTypeSingleSelect
    MenuOfferCartTabTypeSingleSelect _menu = new MenuOfferCartTabTypeSingleSelect(
      borderColor: '0xff739DFA',
      index: 0,
      isSelected: true,
      tabTypeName: 'Menu',
      iconDataString: 'FontAwesomeIcons.facebook',
      tabIconName: 'flight_takeoff',
    );

    MenuOfferCartTabTypeSingleSelect _offer = new MenuOfferCartTabTypeSingleSelect(
      borderColor: '0xff739DFA',
      index: 1,
      isSelected: false,
      tabTypeName: 'Offer',
      iconDataString: 'FontAwesomeIcons.facebook',
      tabIconName: 'flight_takeoff',
    );


//     0xffFEE295 false
    MenuOfferCartTabTypeSingleSelect _cart = new MenuOfferCartTabTypeSingleSelect(
      borderColor: '0xff739DFA',
      index: 2,
      isSelected: false,
      tabTypeName: 'Cart',
      iconDataString: 'FontAwesomeIcons.facebook',
      tabIconName: 'flight_takeoff',
    );


    List <MenuOfferCartTabTypeSingleSelect> menuOfferCartTabTypeSingleSelectArray = new List<MenuOfferCartTabTypeSingleSelect>();
    menuOfferCartTabTypeSingleSelectArray.addAll([_menu,_offer,_cart]);
    _allTabTypes = menuOfferCartTabTypeSingleSelectArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.

//    initiateAllMultiSelectOptions();

    _clientHomeTabController.sink.add(_allTabTypes);

  }

  void setTabTypeSingleSelectOptionForHomePage(MenuOfferCartTabTypeSingleSelect x, int newIndex,int oldIndex){

    print('newIndex is $newIndex');
    print('oldIndex is $oldIndex');


    List <MenuOfferCartTabTypeSingleSelect> tempSingleSelectTabArray = _allTabTypes;
//    _currentOrderTypeIndex


    tempSingleSelectTabArray[oldIndex].isSelected =
    !tempSingleSelectTabArray[oldIndex].isSelected;

    tempSingleSelectTabArray[newIndex].isSelected =
    !tempSingleSelectTabArray[newIndex].isSelected;

//    singleSelectArray[index].isSelected = true;

//    x.isSelected= !x.isSelected;


    // THIS IS NOT REQUIRED FOR THIS PAGE. Order currentOrderTemp AND currentOrderTemp.orderTypeIndex
//    Order currentOrderTemp = _curretnOrder;
//    currentOrderTemp.orderTypeIndex=newIndex;


    _allTabTypes = tempSingleSelectTabArray; // important otherwise => The getter 'sizedFoodPrices' was called on null.

//    _curretnOrder = currentOrderTemp;

//    initiateAllMultiSelectOptions();
    _clientHomeTabController.sink.add(_allTabTypes);
//    _orderController.sink.add(_curretnOrder);
  }

  // 4
  @override
  void dispose() {
    _foodItemController.close();
    _categoriesController.close();
    _allIngredientListController.close();
    _restaurantController.close();
    _bestSellingFoodItemsController.close();
    _clientHomeTabController.close();
//    _allIngredientListController.close();
  }
}