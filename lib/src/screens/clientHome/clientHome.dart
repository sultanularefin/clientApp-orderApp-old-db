
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:linkupclient/src/DataLayer/models/Offer.dart';
import 'package:logger/logger.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:jiffy/jiffy.dart';
//import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_icons/flutter_icons.dart';

// MODELS ==>
import 'package:linkupclient/src/DataLayer/models/newCategory.dart';
import 'package:linkupclient/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:linkupclient/src/DataLayer/models/MenuOfferCartTabTypeSingleSelect.dart';
import 'package:linkupclient/src/DataLayer/models/Restaurant.dart';
import 'package:linkupclient/src/BLoC/clientShopping_bloc.dart';
import 'package:linkupclient/src/BLoC/foodGallery_bloc.dart';
import 'package:linkupclient/src/DataLayer/models/CustomerInformation.dart';
import 'package:linkupclient/src/DataLayer/models/NewIngredient.dart';
import 'package:linkupclient/src/DataLayer/models/Order.dart';
import 'package:linkupclient/src/DataLayer/models/SelectedFood.dart';
import 'package:linkupclient/src/screens/clientShoppingCart/ClientShoppingCart.dart';
import 'package:linkupclient/src/screens/searchFoods/FoodGallerySearch.dart';

// MODELS ==>


// BLOC'S
import 'package:linkupclient/src/BLoC/bloc_provider.dart';


import 'package:linkupclient/src/BLoC/clientHome_bloc.dart';

// BLOC'S

//helpers.
import 'package:linkupclient/src/utilities/screen_size_reducers.dart';




/// This is the stateless widget that the main application instantiates.
class ClientHome extends StatefulWidget {
  ClientHome({Key key}) : super(key: key);

  @override
  _MyStatelessWidgetState createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<ClientHome> {

//  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> scaffoldKeyClientHome = GlobalKey<ScaffoldState>();
  final SnackBar snackBar = const SnackBar(content: Text('Menu button pressed'));

  // STATE VARIABLES begins here. .
  String _currentCategory = "pizza";
  String _firstTimeCategoryString = "";
//  int _currentTabTypeIndex =0;


  // STATE VARIABLES ends here. .


  @override
  Widget build(BuildContext context) {


    var logger = Logger();





    logger.d("Logger is working!");
    final blocH = BlocProvider.of<ClientHomeBloc>(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },child:Scaffold(
      key: scaffoldKeyClientHome,

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SizedBox(
          height: kToolbarHeight+6,
          width: 230,
          child: Container(

            margin: EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 0),

            width: displayWidth(context) / 5,
            height: displayHeight(context) / 21,
            child: Row(
              children: <Widget>[

                Container(child: Image.asset('assets/Path2008.png')),
                Container(
                  padding:EdgeInsets.symmetric(horizontal: 5,vertical: 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Jediline',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 31,color: Color(0xff727C8E)),
                      ),
                      Text(
                        'ONLINE ORDERS',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 16.42,color: Color(0xff727C8E)),
                      ),
                    ],
                  ),
                ),

              ],
            ),

          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Icons.menu',
            onPressed: () {


              /*
              Order orderFG = new Order(
                selectedFoodInOrder: [],
                selectedFoodListLength:0,
                orderTypeIndex: 0, // phone, takeaway, delivery, dinning.
                paymentTypeIndex: 2, //2; PAYMENT OPTIONS ARE LATER(0), CASH(1) CARD(2||Default)
                ordersCustomer: null,
                totalPrice: 0,
                page:0,
              );

              List<SelectedFood> allSelectedFoodGallery = [];

              CustomerInformation oneCustomerInfo = new CustomerInformation(
                address: '',
                flatOrHouseNumber: '',
                phoneNumber: '',
                etaTimeInMinutes: -1,
              );
              */

//              orderFG.selectedFoodInOrder = allSelectedFoodGallery;
//              orderFG.selectedFoodListLength = allSelectedFoodGallery.length;
//              orderFG.totalPrice= 10.0;
//              orderFG.ordersCustomer = oneCustomerInfo;
//              print('add_shopping_cart button pressed');

              /*
               Navigator.of(context).push(

                PageRouteBuilder(
                  opaque: false,
                  transitionDuration: Duration(
                      milliseconds: 900),
                  pageBuilder: (_, __, ___) =>
                      BlocProvider<FoodGalleryBloc>(
                          bloc: FoodGalleryBloc(),
                          child: FoodGallerySearch()

                      )

                      ),


              );
               */

              //print('isCancelButtonPressed: $isCancelButtonPressed');


//    return BlocProvider<ClientShoppingBloc>(
//        bloc: ClientShoppingBloc(orderFG),
//        child: ClientShoppingCart()
//
//    );
              scaffoldKeyClientHome.currentState.showSnackBar(snackBar);



            },
            color: Color(0xff727C8E),
          ),
        ],
      ),
      body: // FOODLIST LOADED FROM FIRESTORE NOT FROM STATE HERE
      SafeArea(child:
      SingleChildScrollView(
        child:StreamBuilder<Restaurant>(

          stream: blocH.getCurrentRestaurantsStream,
          initialData: blocH.getCurrentRestaurant,

          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container(
                  alignment: Alignment.topCenter,
                  child: new LinearProgressIndicator());
            }
            else {
              //   print('snapshot.hasData FDetails: ${snapshot.hasData}');

              final Restaurant oneRestaurant = snapshot.data;
              int _currentTabTypeIndex = oneRestaurant.selectedTabIndex; // {0: menu, 1:offer, 2: cart}.
//                      color: Color.fromARGB(255, 255,255,255),
              return Container(child:

              Row(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[


//                #### 1ST CONTAINER SEARCH STRING AND TOTAL ADD TO CART PRICE.

                  //Expanded
                  Container(
                      width: displayWidth(context)/1.25,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[

                            // 1ST CONTAINER RESTAURANT INFORMATION BEGINS HERE.
                            Container(

                              height: displayHeight(context) / 14,
//                          width :displayWidth(context) -(MediaQuery
//                              .of(context)
//                              .size
//                              .width / 5.8) -3,
                              color: Color(0xffFFFFFF),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceAround,
                                children: <Widget>[
                                  // CONTAINER FOR TOTAL PRICE CART BELOW.
                                  Container(
                                    width: displayWidth(context) /10,
                                    height: displayWidth(context) /7,
                                    padding:EdgeInsets.symmetric(vertical: 7,horizontal: 5),
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
//          borderRadius: BorderRadius.circular(25),
                                      border: Border.all(

                                        color: Color(0xff000000),
                                        style: BorderStyle.solid,
                                        width: 1,


                                      ),
                                      boxShadow: [
                                        BoxShadow(
//                                          707070
//                                              color:Color(0xffEAB45E),
// good yellow color
//                                            color:Color(0xff000000),
                                            color: Color(
                                                0xffEAB45E),
// adobe xd color
//                                              color: Color.fromRGBO(173, 179, 191, 1.0),
                                            blurRadius: 30.0,
                                            spreadRadius: 0.7,
                                            offset: Offset(0, 10)
                                        )
                                      ],
                                    ),
                                    child:ClipOval(

                                      child: CachedNetworkImage(
                                        imageUrl: oneRestaurant.avatar,
                                        fit: BoxFit.cover,
                                        placeholder: (context,
                                            url) => new LinearProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2Fingredient404.jpg?alt=media'),
//
                                      ),
                                    ),
                                  ),

                                  Container(

                                    child: Text('${oneRestaurant.name}'), // CLASS TO WIDGET SINCE I NEED TO INVOKE THE

                                  ),

                                  IconButton(
                                    icon: const Icon(
//                                          Icons.add_shopping_cart,
                                      Icons.search,
//                                            size: 28,

                                      color: Color(0xffBCBCBD),
                                    ),
                                    iconSize:displayWidth(context)/14,
                                    tooltip: 'Search Page Redirect Button',
                                    onPressed: () {

                                      Navigator.of(context).push(

                                        PageRouteBuilder(
                                            opaque: false,
                                            transitionDuration: Duration(
                                                milliseconds: 900),
                                            pageBuilder: (_, __, ___) =>
                                                BlocProvider<FoodGalleryBloc>(
                                                    bloc: FoodGalleryBloc(),
                                                    child: FoodGallerySearch()

                                                )

                                        ),


                                      );

//                                      scaffoldKeyClientHome.currentState.showSnackBar(snackBar);
                                    },
                                    color: Color(0xff727C8E),
                                  ),

                                  /*
                                  Container(

                                    height:displayWidth(context)/34,
//                                          height: 25,
                                    width: 5,
                                    margin: EdgeInsets.only(left: 0,right:15,bottom: 5),
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      color: Colors.white,
//                    ),
                                    // work 1
                                    child: Icon(
//                                          Icons.add_shopping_cart,
                                      Icons.search,
//                                            size: 28,
                                      size: displayWidth(context)/24,
                                      color: Color(0xffBCBCBD),
                                    ),


                                  ),
                                  */

                                ],
                              ),


                            ),

                            //1ST CONTAINER RESTAURANT INFORMATION ENDS HERE.


                            Container(
                              height: displayHeight(context) / 9 + displayHeight(context) / 10,
                              // HEIGHT OF COLUMN CHILDREN 1 (best selling text)   + CHILDREN 2 (best selling foods),
                              padding: EdgeInsets.fromLTRB(
                                  0, 0, 0, 0),
                              // FOR CATEGORY SERARCH.

                              child: Container(
                                  color: Colors.white,
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: displayHeight(context) / 10,
                                        padding:EdgeInsets.fromLTRB(10,displayHeight(context) / 23,0,2),
                                        child: Text('best selling',style: TextStyle(
                                          fontFamily: 'Itim-Regular',
                                        ),),

                                      ),
                                      Container(
                                          height: displayHeight(context) / 9,
                                          color: Color(0xfff4444aa),
                                          child: buildBestSelling(context)
                                      ),





                                    ],
                                  )



                                // Todo DefaultItemsStreamBuilder


                              ),

                              /*
                                child: foodList( /*_currentCategory,_searchString,
                                    context *//*allIngredients:_allIngredientState */),
                                */

                            ),


                            // TAB BUTTONS , MENU, OFFERS AND CART PAGE BEGINS HERE.
                            Container(
                              height: displayHeight(context) /11,
//                          color: Colors.blueGrey,
                              child: StreamBuilder(
                                  stream: blocH.getCurrentTabTypeSingleSelectStream,
                                  initialData: blocH.getCurrentTabType,

                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
                                      return Container(child: Text('Null'));
                                    }
                                    else {
                                      List<MenuOfferCartTabTypeSingleSelect> allTabTypeSingleSelect = snapshot.data;

//            List<OrderTypeSingleSelect> orderTypes = shoppingCartBloc.getCurrentOrderType;

                                      logger.e('allTabTypeSingleSelect: $allTabTypeSingleSelect');

                                      MenuOfferCartTabTypeSingleSelect selectedOne =
                                      allTabTypeSingleSelect.firstWhere((oneOrderType) =>
                                      oneOrderType.isSelected==true);

                                      _currentTabTypeIndex = selectedOne.index;


                                      return ListView.builder(
                                        shrinkWrap: false,
//              reverse:true,
//                                    padding: EdgeInsets.all(0),
                                        padding:EdgeInsets.all(0.0),
//              margin: EdgeInsets.all(0),

                                        scrollDirection: Axis.horizontal,

                                        itemCount: allTabTypeSingleSelect.length,

                                        itemBuilder: (_, int index) {
                                          return oneSingleTabType(
                                              allTabTypeSingleSelect[index],
                                              index,_currentTabTypeIndex);
                                        },
                                      );
                                    }
                                  }

                                // M VSM ORG VS TODO. ENDS HERE.
                              ),
                            ),



                            // TAB BUTTONS , MENU, OFFERS AND CART PAGE ENDS HERE.



                            Container(
//                              color: Colors.yellowAccent,
                              height: displayHeight(context)-
                                  MediaQuery.of(context).padding.top /* TOP SAFE AREA*/
                                  - MediaQuery.of(context).padding.bottom /* BOTTOM SAFEAREA*/-

                                  (displayHeight(context) / 14)-(kToolbarHeight+6)

                                  -displayHeight(context) / 9 - displayHeight(context) / 10-

// HEIGHT OF COLUMN CHILDREN 1 (best selling text)   + CHILDREN 2 (best selling foods),

                                  displayHeight(context) /11,

// TAB BUTTONS , MENU, OFFERS AND CART PAGE BEGINS HERE
//                                              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
//                                        width: displayWidth(context) /1.8,
                              width: displayWidth(context) / 1.1,
//                                            height: displayHeight(context)/2.5,
                              // THIS HEIGHT SHOULDN'T BE GIVEN OTHERWISE
                              // A CERTAIN PORTION OF OF THE CONTAINER
                              // WITH YELLOW ACCENT BG COLOR IS
                              // THERE WHEN THE CHILD WIDGETS ARE NOT
                              // BIG ENOGH LIKE , AS BIG AS displayHeight(context)/2.5,


                              //Text('AnimatedSwitcher('),
                              child:  AnimatedSwitcher(
                                duration: Duration(milliseconds: 300),

                                child: _currentTabTypeIndex == 1 ?
                                offersAnimatedWidget(
                                    oneRestaurant):
                                menuAnimatedWidget(
                                    oneRestaurant)
                                ,
//                                        animatedObscuredTextInputContainer (oneOrder.ordersCustomer),

                              ),


                            ),






                          ]
                      )
                  ),
                  //EXPANDED WIDGET ENDS HERE

                  Container(
//                    color:Colors.redAccent,
                    width: displayWidth(context)/5,
//                    alignment: Alignment.topCenter,
                    height: displayHeight(context) -
                        MediaQuery
                            .of(context)
                            .padding
                            .top + displayHeight(context) / 20,

//                          color: Color.fromARGB(255, 84, 70, 62),
//              child:Text('ss'),

                    child:
                    Container(
                      height: displayHeight(context) -
                          MediaQuery
                              .of(context)
                              .padding
                              .top - displayHeight(context) / 13,
//                          height:800,
//                          padding:EdgeInsets.symmetric(horizontal: 0,vertical: displayHeight(context)/13),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 5.8,
//              color: Colors.yellowAccent,
//                    color: Color(0xff54463E),
                      color: Color(0xffFFE18E),

                      child: StreamBuilder<List<NewCategoryItem>>(

                          stream: blocH.categoryItemsStream,
                          initialData: blocH.allCategories,
//        initialData: bloc.getAllFoodItems(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                  child: new LinearProgressIndicator());
                            }
                            else {
                              final List allCategories = snapshot.data;
//                                  logger.i('allCategories.length:', allCategories.length);


//                                  _allCategoryList.add(All);


//                                  allCategories.add(all);
//                                  logger.i('allCategories.length after :', allCategories.length);

                              final int categoryCount = allCategories
                                  .length;


//                              print('categoryCount in condition 04: ');


//                                logger.i("categoryCount in condition 04: $categoryCount");

                              return (
                                  new ListView.builder
                                    (
                                      itemCount: categoryCount,


                                      //    itemBuilder: (BuildContext ctxt, int index) {
                                      itemBuilder: (_, int index) {
//                                            return (Text('ss'));


                                        return _buildCategoryRow(
                                            allCategories[index]
                                            /*categoryItems[index]*/,
                                            index);
                                      }
                                  )
                              )
                              ;

                            }
                          }
                      ),
                    ),
                  ),
                ]
                ,)

              );

            }
          },
        ),


      ),
      ),
    ),
    );


  }


  Widget menuAnimatedWidget(Restaurant oneRestaurant){

    final blocH = BlocProvider.of<ClientHomeBloc>(context);

    return StreamBuilder<List<FoodItemWithDocID>>(
        stream: blocH.foodItemsStream,
        initialData: blocH.allFoodItems,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {

            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return
              Container(
                height: displayHeight(context) / 9,
                child: Text("No FoodItems found, check api, internet etc.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),


                ),
              );
          }

          else {




            final List<FoodItemWithDocID> allFoods = snapshot.data;
            if((allFoods==null) ||(allFoods.length ==0)){

              return Container(
                  height: displayHeight(context) / 9,
//          height:190,

//              color: Colors.yellowAccent,
//                    color: Color(0xff54463E),
                  color: Color(0xFFffffff),
                  alignment: Alignment.center,

                  // PPPPP

                  child:(
                      Text("No best selling foods found",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      )
                  )
              );
            }

            else{



//               filteredItemsByCategory;
              List<FoodItemWithDocID> filteredItemsByCategory = allFoods.where((oneItem) =>
              oneItem.categoryName.
              toLowerCase() ==
                  _currentCategory.toLowerCase()).toList();


              // to do test.
              // if(searchString2!=null)

              /*
              final List filteredItems = filteredItemsByCategory.where((
                  oneItem) =>
                  oneItem.itemName.toLowerCase().
                  contains(
                      searchString2.toLowerCase())).toList();

              */

              final int categoryItemsCount = filteredItemsByCategory.length;
              print('categoryItemsCount: $categoryItemsCount');

              return Container(
                height: displayHeight(context) - displayHeight(context) / 3,
                color: Color(0xFFffffff),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,

//                                          itemCount: sizeConstantsList.length,
                  itemCount: filteredItemsByCategory.length,

                  itemBuilder: (_, int index) {

//                  print(
//                      'valuePrice at line # 583: $valuePrice and key is $key');
                    return oneMenuItemFromFoodItem(filteredItemsByCategory[index],index
                    );
                  },

//      controller: new ScrollController(
//          keepScrollOffset: false),
                  shrinkWrap: false,
                ),

              );
            }
          }
        }
    );



//
//    bolognese pizza




    /*
    */
  }

  num tryCast<num>(dynamic x, {num fallback }) => x is num ? x : 0.0;

  Widget oneMenuItemFromFoodItem(FoodItemWithDocID oneSelectedFood,int index){

    Map<String, dynamic> listpart1 = new Map<String, dynamic>();


    List<String> actionkeys =['share', 'love', 'favorite'];
    List<String> iconNames =['share', 'love', 'favorite'];

    final String foodItemName = oneSelectedFood.itemName;
    final String foodImageURL = oneSelectedFood.imageURL;

    final Map<String,
        dynamic> foodSizePrice =  oneSelectedFood.sizedFoodPrices;

    final dynamic euroPriceUnSanitized = foodSizePrice['normal'];

//                num euroPrice2 = tryCast(euroPrice);
    double euroPriceDoubled = tryCast<double>(
        euroPriceUnSanitized, fallback: 0.00);
//                String euroPrice3= num.toString();
//                print('euroPrice2 :$euroPrice2');

    String euroPriceFixedTwo = euroPriceDoubled.toStringAsFixed(2);

    List<NewIngredient> sanitizedIngredients = oneSelectedFood.ingredients;



//    final String fooditemNormalPrice = oneSelectedFood.sizedFoodPrices;



    return  Container(
          margin: EdgeInsets.symmetric(vertical:10,horizontal: 0),
      padding: EdgeInsets.symmetric(vertical:5,horizontal: 10),

        decoration:
        new BoxDecoration(
          borderRadius: new BorderRadius
              .circular(
              10.0),
//                                    color: Colors.purple,
          color: Colors.white,
        ),


        child:
        Neumorphic(
          // State of Neumorphic (may be convex, flat & emboss)

          /*
                                      boxShape: NeumorphicBoxShape
                                          .roundRect(
                                        BorderRadius.all(
                                            Radius.circular(15)),

                                      ),
                                      */
          curve: Neumorphic.DEFAULT_CURVE,
          style: NeumorphicStyle(
            shape: NeumorphicShape
                .concave,
            depth: 8,
            lightSource: LightSource
                .topLeft,
            color: Colors.white,
            boxShape:NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(15)),
            ),
          ),

//                    MAX_DEPTH,DEFAULT_CURVE

//
//                      BorderRadius.circular(25),
//                  border: Border.all(


          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(foodItemName,style: TextStyle(
                      fontFamily: 'Itim-Regular',
                      color: Color(0xff3F5362),
                    ),),
                    Text(euroPriceFixedTwo + '\u20AC',style: TextStyle(
                      fontFamily: 'Itim-Regular',
                      color: Color(0xff3F5362),
                    ),),
                  ],
                ),
              ),


              Container(
                height: displayHeight(context)/22,
                padding:EdgeInsets.symmetric(vertical: 0,horizontal: 5),

                child:Text('This is so delicious pizza which we'
                    'offer for our customers from our unique menu',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Itim-Regular',
                    color: Color(0xff3F5362),
                  ),

                ),


              ),

              Container(
                padding: EdgeInsets.symmetric(vertical:10,horizontal: 0),
                child: Row(
                  children: <Widget>[
                    Container(
//                    color: Colors.blueGrey,
//                                  color:Color(0xffDAD7C3),

//                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                      padding: EdgeInsets.fromLTRB(0, 6, 0, 0),

                      width: displayWidth(context)/6,
                      child:
                      Column(
//                      shrinkWrap: false,
//                      padding: const EdgeInsets.all(8),
                        children: <Widget>[
                          Container(
//                          height: 50,
//                          color: Colors.amber[600],
                            height: displayHeight(context)/14,
                            child: RaisedButton(
                              color: Colors.white,
//                            focusColor:Colors.lightBlue,
//                            hoverColor:Colors.lightBlue,
                              highlightColor:Color(0xff3F5362),
//                            splashColor:Colors.deepPurple,
                              padding: EdgeInsets.all(0),
//                            margin: EdgeInsets.all(0),
//                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              child: Column(
                                children: <Widget>[

                                  Icon(
                                    getIconForName(iconNames[0]),
                                    color: Color(0xffFC0000),
                                    size: displayWidth(context) / 13,

                                  ),
                                  Text('${actionkeys[0]}',style: TextStyle(fontSize: 11),),
                                ],
                              ),
                              onPressed: () {
//
                                print('onPressed pressed ${actionkeys[0]}');


                              },
                            ),
                          ),
                          Container(
                            height: displayHeight(context)/14,
                            child: RaisedButton(
                              color: Colors.white,
//                            focusColor:Colors.lightBlue,
//                            hoverColor:Colors.lightBlue,
                              highlightColor:Color(0xff3F5362),
//                            splashColor:Colors.deepPurple,
                              padding: EdgeInsets.all(0),
//                            margin: EdgeInsets.all(0),
//                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              child: Column(
                                children: <Widget>[

                                  Icon(
                                    getIconForName(iconNames[1]),
                                    color: Color(0xffFC0000),
                                    size: displayWidth(context) / 13,

                                  ),
                                  Text('${actionkeys[1]}',style: TextStyle(fontSize: 11),),
                                ],
                              ),
                              onPressed: () {
//
                                print('onPressed pressed ${actionkeys[1]}');


                              },
                            ),

                          ),

                          Container(
                            height: displayHeight(context)/14,
                            child: RaisedButton(
                              color: Colors.white,
//                            focusColor:Colors.lightBlue,
//                            hoverColor:Colors.lightBlue,
                              highlightColor:Color(0xff3F5362),
//                            splashColor:Colors.deepPurple,
                              padding: EdgeInsets.all(0),
//                            margin: EdgeInsets.all(0),
//                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              child: Column(
                                children: <Widget>[

                                  Icon(
                                    getIconForName(iconNames[2]),
                                    color: Color(0xffFC0000),
                                    size: displayWidth(context) / 13,

                                  ),
                                  Text('${actionkeys[2]}',style: TextStyle(fontSize: 11),),
                                ],
                              ),
                              onPressed: () {
//
                                print('onPressed pressed ${actionkeys[2]}');


                              },
                            ),

                          ),

                        ],
                      ),


                    ),
                    Container(
//                    color: Colors.deepOrange,
//                                  color:Color(0xffDAD7C3),

//                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
//                      padding: EdgeInsets.fromLTRB(0, 6, 0, 0),

//                      width: displayWidth(context) * 0.57,
                      padding: EdgeInsets.symmetric(vertical:0,horizontal:5),
                      child:

                      Container(

                        height: (displayHeight(context)/14) *3,
//                        height: 150,
                        width: displayWidth(context)/1.25 -displayWidth(context)/6- 20 /*(padding on both sides 10*2 )*/  -10 /* padding on within
                        the parent container. */,
                        // WIDTH: WIDTH OF PARENT CONTAINER - ACTION BUTTONS WIDTH

//                      width: 220,//300-80,

                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
//          borderRadius: BorderRadius.circular(25),
                          border: Border.all(

                            color: Color(0xff000000),
                            style: BorderStyle.solid,
                            width: 2,


                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),

                        ),


                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(26.0)),

                          child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                            imageUrl: foodImageURL,
                            fit: BoxFit.cover,
                            placeholder: (context,
                                url) => new CircularProgressIndicator(),
                          ),
                        ),
//                        foodImageURL
                      ),


                    )

                  ],
                ),
              ),






              Container(
                  height: displayHeight(context) / 10,
                  width: displayWidth(context)/1.25,
//                width: displayWidth(context) /1.5,
//                  color: Color(0xfff4444aa),
//                                                        alignment: Alignment.center,
                  child: buildDefaultIngredients(
                      context,sanitizedIngredients
                  )
                //Text('buildDefaultIngredients('
                //    'context'
                //')'),
              ),
              /*
              Container(
                child: Row(
                  children: <Widget>[
                    Text('oneRestaurant.selectedTabIndex: ${oneRestaurant.selectedTabIndex}'),
                  ],
                ),
              ),
              */



            ],
          )
      ),
    );
  }

  //now now
  /* DEAFULT INGREDIENT ITEMS BUILD STARTS HERE.*/
  Widget buildDefaultIngredients(BuildContext context ,List<NewIngredient> sanitizedIngs){


//    defaultIngredients
//    final blocH = BlocProvider.of<FoodItemDetailsBloc>(context);
//    final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//    final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);

    return StreamBuilder<List<NewIngredient>>(
//        stream: sanitizedIngs,
        initialData: sanitizedIngs,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {

            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return
              Text("No Ingredients, Please Select 1 or more",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),


              );
          }

          else {

            print('snapshot.hasData and else statement at FDetailS2');
            List<NewIngredient> selectedIngredients = snapshot.data;

            if( (selectedIngredients ==null) && (selectedIngredients.length ==0)
            ){

              return Container(
                  height: displayHeight(context) / 8,
//          height:190,
                  width: displayWidth(context) * 0.57,
//              color: Colors.yellowAccent,
//                    color: Color(0xff54463E),
                  color: Color(0xFFffffff),
                  alignment: Alignment.center,

                  // PPPPP

                  child:(
                      Text("No Ingredients, Please Select 1 or more",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      )
                  )
              );
            }

            else{

              return Container(
                color: Color(0xFFffffff),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,


                  /*
                  gridDelegate:
                  new SliverGridDelegateWithMaxCrossAxisExtent(






                    maxCrossAxisExtent: 180,
                    mainAxisSpacing: 0, // Vertical  direction
                    crossAxisSpacing: 5,
                    childAspectRatio: 200 / 280,


                  ),

                  */
                  shrinkWrap: true,
//        final String foodItemName =          filteredItems[index].itemName;
//        final String foodImageURL =          filteredItems[index].imageURL;
                  itemCount: selectedIngredients
                      .length,
                  itemBuilder: (_, int index) {
                    return oneDefaultIngredient(selectedIngredients[index],
                        index);
                  },
                ),
              );
            }
          }
        }
    );
  }


  Widget oneDefaultIngredient(NewIngredient oneSelected,int index){
    final String ingredientName = oneSelected.ingredientName;
//                  final dynamic ingredientImageURL = document['image'];
//    final num ingredientPrice = document['price'];

    final dynamic ingredientImageURL = oneSelected.imageURL == '' ?
    'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2FfoodItem404.jpg?alt=media'
        :
    storageBucketURLPredicate +
        Uri.encodeComponent(oneSelected.imageURL)

        + '?alt=media';


//    print('ingredientImageUR L   L    L   L: $ingredientImageURL');

    return Container(

//            color: Color.fromRGBO(239, 239, 239, 0),
      color: Colors.white,
      padding: EdgeInsets.symmetric(
//                          horizontal: 10.0, vertical: 22.0),
          horizontal: 8.0, vertical: 0),
      child: GestureDetector(
          onLongPress: () {
            print(
                'at Long Press: ');
          },


          child: Column(
            children: <Widget>[

              new Container(

//                                width: displayWidth(context) * 0.09,
//                                height: displayWidth(context) * 0.11,
                width: displayWidth(context) /8,
                height: displayWidth(context) /8,
                padding:EdgeInsets.symmetric(vertical: 2,horizontal: 3),

                child: ClipOval(

                  child: CachedNetworkImage(
                    imageUrl: ingredientImageURL,
                    fit: BoxFit.cover,
                    placeholder: (context,
                        url) => new LinearProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2Fingredient404.jpg?alt=media'),
//
                  ),
                ),
              ),
//                              SizedBox(height: 10),
              Text(

                ingredientName,

                style: TextStyle(
                  color: Color.fromRGBO(112, 112, 112, 1),
//                                    color: Colors.blueGrey[800],

                  fontWeight: FontWeight.normal,
                  fontSize: 10,
                ),
              )
              ,


            ],
          ),
          onTap: () {
            print('for future use');
//                            return Navigator.push(context,
//
//                                MaterialPageRoute(builder: (context)
//                                => FoodItemDetails())
//                            );
          }



      ),
    );
  }




  offersAnimatedWidget(Restaurant oneRestaurant){



    final blocH = BlocProvider.of<ClientHomeBloc>(context);

    return StreamBuilder<List<Offer>>(
        stream: blocH.getOffersStream,
        initialData: blocH.getAllOffers,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {

            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return
              Container(
                height: displayHeight(context) / 9,
                child: Text("No Offers found, check api, internet etc.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),


                ),
              );
          }

          else {




            final List<Offer> allOffers = snapshot.data;
            if((allOffers==null) ||(allOffers.length ==0)){

              return Container(
                  height: displayHeight(context) / 9,
//          height:190,

//              color: Colors.yellowAccent,
//                    color: Color(0xff54463E),
                  color: Color(0xFFffffff),
                  alignment: Alignment.center,

                  // PPPPP

                  child:(
                      Text("0 Offers found, please check again.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      )
                  )
              );
            }

            else{



              final int allOffersCount = allOffers.length;
              print('allOffersCount: $allOffersCount');

              return Container(
                height: displayHeight(context) - displayHeight(context) / 3,
                color: Color(0xFFffffff),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,

//                                          itemCount: sizeConstantsList.length,
                  itemCount: allOffersCount,

                  itemBuilder: (_, int index) {

//                  print(
//                      'valuePrice at line # 583: $valuePrice and key is $key');
                    return oneOfferItemFromOffersAnimatedWidget(allOffers[index],index);
//                    oneOfferItemFromOffersAnimatedWidget
                  },

//      controller: new ScrollController(
//          keepScrollOffset: false),
                  shrinkWrap: false,
                ),

              );
            }
          }
        }
    );




  }


  Widget oneOfferItemFromOffersAnimatedWidget(Offer oneOffer,int index){
      Jiffy.locale("sv");
    var logger = Logger();
    Map<String, dynamic> listpart1 = new Map<String, dynamic>();


    List<String> actionkeys =['share', 'love', 'favorite'];
    List<String> iconNames =['share', 'love', 'favorite'];

    final String oneOfferTitle = oneOffer.offerTitle;
    final String oneOfferfoodImageURL =  oneOffer.imageURL;

    DateTime oneOfferExpiresBefore = oneOffer.offerExpiredTime;
    DateTime oneOfferSetTime = oneOffer.offerSetTime;

    logger.e('check');


    print(' :${Jiffy(oneOfferExpiresBefore).format("MMMM do yyyy, h:mm:ss a")}');



//    Intl.defaultLocale = 'bn';
//    final df = oneOfferExpiresBefore ;
//    final df = new DateFormat('dd-MM-yyyy hh:mm a');
//    int myvalue = 1558432747;
//    print(df.format(new DateTime.fromMillisecondsSinceEpoch(myvalue*1000)));
//    print("${DateFormat.jm().format(DateTime.now())}");
//    print(myMessage(dateString, locale: 'ar');

//    print(${oneOfferExpiresBefore.)


    /*
    final Map<String,
        dynamic> foodSizePrice =  oneSelectedFood.sizedFoodPrices;

    final dynamic euroPriceUnSanitized = foodSizePrice['normal'];

//                num euroPrice2 = tryCast(euroPrice);
    double euroPriceDoubled = tryCast<double>(
        euroPriceUnSanitized, fallback: 0.00);
    */
//                String euroPrice3= num.toString();
//                print('euroPrice2 :$euroPrice2');

    String euroPriceFixedTwo = oneOffer.offerPrice.toStringAsFixed(2);

    /*
    List<NewIngredient> sanitizedIngredients = oneSelectedFood.ingredients;
    */



//    final String fooditemNormalPrice = oneSelectedFood.sizedFoodPrices;



    return  Container(
      margin: EdgeInsets.symmetric(vertical:10,horizontal: 0),
      padding: EdgeInsets.symmetric(vertical:5,horizontal: 10),

      decoration:
      new BoxDecoration(
        borderRadius: new BorderRadius
            .circular(
            10.0),
//                                    color: Colors.purple,
        color: Colors.white,
      ),


      child:
      Neumorphic(
        // State of Neumorphic (may be convex, flat & emboss)

        /*
                                      boxShape: NeumorphicBoxShape
                                          .roundRect(
                                        BorderRadius.all(
                                            Radius.circular(15)),

                                      ),
                                      */
          curve: Neumorphic.DEFAULT_CURVE,
          style: NeumorphicStyle(
            shape: NeumorphicShape
                .concave,
            depth: 8,
            lightSource: LightSource
                .topLeft,
            color: Colors.white,
            boxShape:NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(15)),
            ),
          ),

//                    MAX_DEPTH,DEFAULT_CURVE

//
//                      BorderRadius.circular(25),
//                  border: Border.all(


          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(oneOfferTitle,style: TextStyle(
                      fontFamily: 'Itim-Regular',
                      color: Color(0xff3F5362),
                    ),),
                    Text(euroPriceFixedTwo + '\u20AC',style: TextStyle(
                      fontFamily: 'Itim-Regular',
                      color: Color(0xff3F5362),
                    ),),
                  ],
                ),
              ),


              Container(
                height: displayHeight(context)/22,
                padding:EdgeInsets.symmetric(vertical: 0,horizontal: 5),

                child:Text('This is so delicious pizza which we'
                    'offer for our customers from our unique menu',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Itim-Regular',
                    color: Color(0xff3F5362),
                  ),

                ),


              ),

              Container(
                padding: EdgeInsets.symmetric(vertical:10,horizontal: 0),
                child: Row(
                  children: <Widget>[
                    Container(
//                    color: Colors.blueGrey,
//                                  color:Color(0xffDAD7C3),

//                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                      padding: EdgeInsets.fromLTRB(0, 6, 0, 0),

                      width: displayWidth(context)/6,
                      child:
                      Column(
//                      shrinkWrap: false,
//                      padding: const EdgeInsets.all(8),
                        children: <Widget>[
                          Container(
//                          height: 50,
//                          color: Colors.amber[600],
                            height: displayHeight(context)/14,
                            child: RaisedButton(
                              color: Colors.white,
//                            focusColor:Colors.lightBlue,
//                            hoverColor:Colors.lightBlue,
                              highlightColor:Color(0xff3F5362),
//                            splashColor:Colors.deepPurple,
                              padding: EdgeInsets.all(0),
//                            margin: EdgeInsets.all(0),
//                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              child: Column(
                                children: <Widget>[

                                  Icon(
                                    getIconForName(iconNames[0]),
                                    color: Color(0xffFC0000),
                                    size: displayWidth(context) / 13,

                                  ),
                                  Text('${actionkeys[0]}',style: TextStyle(fontSize: 11),),
                                ],
                              ),
                              onPressed: () {
//
                                print('onPressed pressed ${actionkeys[0]}');


                              },
                            ),
                          ),
                          Container(
                            height: displayHeight(context)/14,
                            child: RaisedButton(
                              color: Colors.white,
//                            focusColor:Colors.lightBlue,
//                            hoverColor:Colors.lightBlue,
                              highlightColor:Color(0xff3F5362),
//                            splashColor:Colors.deepPurple,
                              padding: EdgeInsets.all(0),
//                            margin: EdgeInsets.all(0),
//                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              child: Column(
                                children: <Widget>[

                                  Icon(
                                    getIconForName(iconNames[1]),
                                    color: Color(0xffFC0000),
                                    size: displayWidth(context) / 13,

                                  ),
                                  Text('${actionkeys[1]}',style: TextStyle(fontSize: 11),),
                                ],
                              ),
                              onPressed: () {
//
                                print('onPressed pressed ${actionkeys[1]}');


                              },
                            ),

                          ),

                          Container(
                            height: displayHeight(context)/14,
                            child: RaisedButton(
                              color: Colors.white,
//                            focusColor:Colors.lightBlue,
//                            hoverColor:Colors.lightBlue,
                              highlightColor:Color(0xff3F5362),
//                            splashColor:Colors.deepPurple,
                              padding: EdgeInsets.all(0),
//                            margin: EdgeInsets.all(0),
//                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              child: Column(
                                children: <Widget>[

                                  Icon(
                                    getIconForName(iconNames[2]),
                                    color: Color(0xffFC0000),
                                    size: displayWidth(context) / 13,

                                  ),
                                  Text('${actionkeys[2]}',style: TextStyle(fontSize: 11),),
                                ],
                              ),
                              onPressed: () {
//
                                print('onPressed pressed ${actionkeys[2]}');


                              },
                            ),

                          ),

                        ],
                      ),


                    ),
                    Container(
//                    color: Colors.deepOrange,
//                                  color:Color(0xffDAD7C3),

//                      margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
//                      padding: EdgeInsets.fromLTRB(0, 6, 0, 0),

//                      width: displayWidth(context) * 0.57,
                      padding: EdgeInsets.symmetric(vertical:0,horizontal:5),
                      child:

                      Container(

                        height: (displayHeight(context)/14) *3,
//                        height: 150,
                        width: displayWidth(context)/1.25 -displayWidth(context)/6- 20 /*(padding on both sides 10*2 )*/  -10 /* padding on within
                        the parent container. */,
                        // WIDTH: WIDTH OF PARENT CONTAINER - ACTION BUTTONS WIDTH

//                      width: 220,//300-80,

                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
//          borderRadius: BorderRadius.circular(25),
                          border: Border.all(

                            color: Color(0xff000000),
                            style: BorderStyle.solid,
                            width: 2,


                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),

                        ),


                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(26.0)),

                          child: Container(),
                          /* CachedNetworkImage(
//                  imageUrl: dummy.url,
                            imageUrl: oneOfferfoodImageURL,
                            fit: BoxFit.cover,
                            placeholder: (context,
                                url) => new CircularProgressIndicator(),
                          ),
                          */


                        ),
//                        foodImageURL
                      ),


                    )

                  ],
                ),
              ),

              Container(
                  height: displayHeight(context)/10,
                child: Row(
                  children: <Widget>[



                    // CIRCULAR PROGRESS INDICATOR........
                    Container(

                      width: displayWidth(context)/6 +20,
                      padding:EdgeInsets.symmetric(
                          vertical: 0,horizontal: 9),

                      /*
                      child:new CircularProgressIndicator(
                        value:0.9,

                        valueColor:
                        AlwaysStoppedAnimation<Color>
                          (Colors.redAccent),

                        strokeWidth: 4,
                        semanticsLabel: 'sss',
                        semanticsValue: 'ss',
                        backgroundColor: Colors.grey,

                      ),

                      */

                      child: new CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 5.0,
                        percent: 1.0,
                        center: new Text(oneOfferExpiresBefore.difference(DateTime.now()).inHours.toString()),
                        progressColor: Colors.green,
                      )

//                  date2.difference(birthday).inDays;

                    ),


                    Container(
                      width: displayWidth(context)/1.25 -displayWidth(context)/6-
                          20 /*(padding on both sides 10*2 )*/  -10 /* padding on within
                     the parent container.  */-20 /*20 added for circular percentage */,
                      height: displayHeight(context)/22,
                      padding:EdgeInsets.symmetric(vertical: 0,horizontal: 5),

                      child:Text('This is so delicious pizza which we'
                          'offer for our customers from our unique menu',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Itim-Regular',
                          color: Color(0xff3F5362),
                        ),

                      ),


                    ),
                  ],
                ),
              ),






              /*
              Container(
                  height: displayHeight(context) / 10,
                  width: displayWidth(context)/1.25,
//                width: displayWidth(context) /1.5,
//                  color: Color(0xfff4444aa),
//                                                        alignment: Alignment.center,
                  child: buildDefaultIngredients(
                      context,sanitizedIngredients
                  )
                //Text('buildDefaultIngredients('
                //    'context'
                //')'),
              ),
              */
              /*
              Container(
                child: Row(
                  children: <Widget>[
                    Text('oneRestaurant.selectedTabIndex: ${oneRestaurant.selectedTabIndex}'),
                  ],
                ),
              ),
              */



            ],
          )
      ),
    );
  }


  //now now
  /* DEAFULT INGREDIENT ITEMS BUILD STARTS HERE.*/
  Widget buildBestSelling(BuildContext context /*,List<NewIngredient> defaltIngs*/){


//    defaultIngredients
    final blocH = BlocProvider.of<ClientHomeBloc>(context);
//    final blocD = BlocProvider.of<ClientHome>(context);
//    final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;
//    final foodItemDetailsbloc = BlocProvider.of<FoodItemDetailsBloc>(context);

    return StreamBuilder(
        stream: blocH.bestSellingFoodItemsStream,
        initialData: blocH.getAllBestSellingFoodItems,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {

            print('!snapshot.hasData');
//        return Center(child: new LinearProgressIndicator());
            return
              Container(
                height: displayHeight(context) / 9,
                child: Text("No Ingredients, Please Select 1 or more",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),


                ),
              );
          }

          else {

            print('snapshot.hasData and else statement at FDetailS2');
            List<FoodItemWithDocID> bestSellingFoods = snapshot.data;

            if( (bestSellingFoods==null) ||(bestSellingFoods.length ==0)){

              return Container(
                  height: displayHeight(context) / 9,
//          height:190,

//              color: Colors.yellowAccent,
//                    color: Color(0xff54463E),
                  color: Color(0xFFffffff),
                  alignment: Alignment.center,

                  // PPPPP

                  child:(
                      Text("No best selling foods found",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      )
                  )
              );
            }

            else{
              return Container(
                height: displayHeight(context) / 9,
                color: Color(0xFFffffff),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,

//                                          itemCount: sizeConstantsList.length,
                  itemCount: bestSellingFoods.length,

                  itemBuilder: (_, int index) {

//                  print(
//                      'valuePrice at line # 583: $valuePrice and key is $key');
                    return oneBestSellingFoodItem(bestSellingFoods[index],index
                    );
                  },

//      controller: new ScrollController(
//          keepScrollOffset: false),
                  shrinkWrap: false,
                ),

              );
            }
          }
        }
    );
  }


  Widget oneBestSellingFoodItem(FoodItemWithDocID oneSelectedFood,int index){
    final String ingredientName = oneSelectedFood.itemName;
//                  final dynamic ingredientImageURL = document['image'];
//    final num ingredientPrice = document['price'];

    print('------- --- - oneSelectedFood.imageURL ----------- --  : ${oneSelectedFood.imageURL}');

    final dynamic ingredientImageURL = oneSelectedFood.imageURL == '' ?
    'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2FfoodItem404.jpg?alt=media'
        :
    oneSelectedFood.imageURL;


//    print('ingredientImageUR L   L    L   L: $ingredientImageURL');

    return Container(
//            color: Color.fromRGBO(239, 239, 239, 0),
      width: displayWidth(context) /5,
      height: displayHeight(context) / 9,
      color: Color(0xFF34acdf),
      padding: EdgeInsets.fromLTRB(
//                          horizontal: 10.0, vertical: 22.0),
          4, 3,4,1),
      child: InkWell(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            new Container(

//                                width: displayWidth(context) * 0.09,
//                                height: displayWidth(context) * 0.11,
              width: displayWidth(context) /7,
              height: displayHeight(context) /13,
              padding:EdgeInsets.symmetric(vertical: 3),
//        horizontal: 3

              decoration: new BoxDecoration(
                shape: BoxShape.circle,
//          borderRadius: BorderRadius.circular(25),
                border: Border.all(

                  color: Color(0xff000000),
                  style: BorderStyle.solid,
                  width: 3,


                ),
                boxShadow: [
                  BoxShadow(
//                                          707070
//                                              color:Color(0xffEAB45E),
// good yellow color
//                                            color:Color(0xff000000),
                      color: Color(
                          0xffEAB45E),
// adobe xd color
//                                              color: Color.fromRGBO(173, 179, 191, 1.0),
                      blurRadius: 30.0,
                      spreadRadius: 0.7,
                      offset: Offset(0, 10)
                  )
                ],
              ),

              child: ClipOval(

                child: CachedNetworkImage(
                  imageUrl: ingredientImageURL,
                  fit: BoxFit.cover,
                  placeholder: (context,
                      url) => new LinearProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2Fingredient404.jpg?alt=media'),
//
                ),
              ),

            ),
//                              SizedBox(height: 10),
            Text(

              ingredientName,

              style: TextStyle(
                color: Color.fromRGBO(112, 112, 112, 1),
//                                    color: Colors.blueGrey[800],

                fontWeight: FontWeight.normal,
                fontSize: 10,
              ),
            )
            ,


          ],
        ),

        onTap: () {
          _navigateAndDisplaySelection(
              context, oneSelectedFood);
        },
      ),

    );
  }







//  oneSingleDeliveryType to be replaced with oneSinglePaymentType
  Widget oneSingleTabType (MenuOfferCartTabTypeSingleSelect oneTabOption,int index,int currentTabIndex){


    var logger = Logger();
    logger.e('oneTabOption: ${oneTabOption.tabTypeName}');

    String oneTabTypeName = oneTabOption.tabTypeName;
    String oneTabIconName = oneTabOption.tabIconName;
    String borderColor    = oneTabOption.borderColor;
    if(index <2) {
      return InkWell(
        highlightColor: Colors.lightGreenAccent,


//      height:displayHeight(context)/30,
//      width:displayWidth(context)/10,

        child: index == currentTabIndex ?
        Container(
//        color:Colors.lightGreenAccent,
          width: displayWidth(context) / 3.5,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          height: displayHeight(context) / 11,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[

              new Container(

                width: displayWidth(context) / 9.5,
                height: displayWidth(context) / 9.5,
                decoration: BoxDecoration(
                  border: Border.all(
//                    color: Colors.black,
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 1.0,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  getIconForName(oneTabTypeName),
                  color: Color(0xffFC0000),
                  size: displayWidth(context) / 13,

                ),

              ),

              Container(

                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
//                  alignment: Alignment.center,
                child: Text(
                  oneTabTypeName, style:
                TextStyle(
                    fontFamily: 'Itim-Regular',
                    color: Color(0xffFC0000),

                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                ),
              ),
            ],
          ),
        )


        // : Container for 2nd argument of ternary condition ends here.
            :
        Container(
//        color:Colors.lightBlue,
          width: displayWidth(context) / 3.5,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          height: displayHeight(context) / 11,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[

              new Container(

                width: displayWidth(context) / 9.5,
                height: displayWidth(context) / 9.5,
                decoration: BoxDecoration(
                  border: Border.all(
//                    color: Colors.black,
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 1.0,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  getIconForName(oneTabTypeName),
                  color: Colors.grey,
                  size: displayWidth(context) / 13,
                ),

              ),

              Container(

                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
//                  alignment: Alignment.center,
                child: Text(
                  oneTabTypeName, style:
                TextStyle(
                    fontFamily: 'Itim-Regular',
                    color: Colors.grey,

                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                ),
              ),
            ],
          ),
        ),


        onTap: () {
          logger.w('sss');

          final blocH = BlocProvider.of<ClientHomeBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
          blocH.setTabTypeSingleSelectOptionForHomePage(
              oneTabOption, index, currentTabIndex);


//            showEditingCompleteCustomerAddressInformation   = false;
//            showEditingCompleteCustomerHouseFlatIformation = false;
//            showEditingCompleteCustomerPhoneIformation     = false;
//            showEditingCompleteCustomerReachoutIformation  = false;

          // WORK -2


        },

        // : Container for 2nd argument of ternary condition ends here.
      );
    }else{

      return InkWell(
        highlightColor: Colors.lightGreenAccent,


//      height:displayHeight(context)/30,
//      width:displayWidth(context)/10,


        child:Container(
//        color:Colors.lightGreenAccent,
          width: displayWidth(context) / 3.5,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          height: displayHeight(context) / 11,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[

              new Container(

                width: displayWidth(context) / 9.5,
                height: displayWidth(context) / 9.5,
                decoration: BoxDecoration(
                  border: Border.all(
//                    color: Colors.black,
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 1.0,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  getIconForName(oneTabTypeName),
                  color: Colors.grey,
                  size: displayWidth(context) / 13,

                ),

              ),

              Container(

                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
//                  alignment: Alignment.center,
                child: Text(
                  oneTabTypeName, style:
                TextStyle(
                    fontFamily: 'Itim-Regular',
                    color: Colors.grey,

                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                ),
              ),
            ],
          ),
        ),onTap: () async {


        Order orderFG = new Order(
          selectedFoodInOrder: [],
          selectedFoodListLength:0,
          orderTypeIndex: 0, // phone, takeaway, delivery, dinning.
          paymentTypeIndex: 2, //2; PAYMENT OPTIONS ARE LATER(0), CASH(1) CARD(2||Default)
          ordersCustomer: null,
          totalPrice: 0,
          page:0,
        );

        List<SelectedFood> allSelectedFoodGallery = [];

        CustomerInformation oneCustomerInfo = new CustomerInformation(
          address: '',
          flatOrHouseNumber: '',
          phoneNumber: '',
          etaTimeInMinutes: -1,
        );

        orderFG.selectedFoodInOrder = allSelectedFoodGallery;
        orderFG.selectedFoodListLength = allSelectedFoodGallery.length;
        orderFG.totalPrice= 10.0;
        orderFG.ordersCustomer = oneCustomerInfo;
        print('add_shopping_cart button pressed');

        final bool isCancelButtonPressed = await Navigator.of(context).push(

          PageRouteBuilder(
            opaque: false,
            transitionDuration: Duration(
                milliseconds: 900),
            pageBuilder: (_, __, ___) =>
                BlocProvider<ClientShoppingBloc>(
                    bloc: ClientShoppingBloc(orderFG),
                    child: ClientShoppingCart()

                ),

          ),
        );

        print('isCancelButtonPressed: $isCancelButtonPressed');


//    return BlocProvider<ClientShoppingBloc>(
//        bloc: ClientShoppingBloc(orderFG),
//        child: ClientShoppingCart()
//
//    );

      },
      );

    }
  }


  IconData getIconForName(String iconName) {

    print ('iconName at getIconForName: $iconName');
    switch(iconName) {
      case 'facebook': {
//        return FontAwesomeIcons.facebook;
        return FontAwesomeIcons.facebook;
      }
      break;

      case 'twitter': {
        return FontAwesomeIcons.twitter;
      }
      break;
      case 'TakeAway': {
        return Icons.work;
      }
      break;
      case 'Delivery': {
        return Icons.local_shipping;
      }
      break;
      case 'Phone': {
        return Icons.phone_in_talk;
      }
      break;
      case 'DinningRoom': {
        return Icons.fastfood;
      }
//      ;;
      break;
      case 'share': {
        return Icons.share;
      }
      break;
      case 'favorite': {
        return Icons.star_border;
      }
      break;
      case 'love': {
        return Icons.favorite_border;
      }
//      ;;

      case 'Card': {
        return FontAwesomeIcons.solidCreditCard;

      }
      break;
      case 'offers': {
        return Icons.local_offer;
      }
      break;
      case 'cart': {
        return Icons.add_shopping_cart;
      }
      break;
      case 'menu': {
        return Icons.restaurant;
      }
      break;





      default: {
        return FontAwesomeIcons.home;
      }
    }
  }




  navigateToshoppingCartPage() async{

    Order orderFG = new Order(
      selectedFoodInOrder: [],
      selectedFoodListLength:0,
      orderTypeIndex: 0, // phone, takeaway, delivery, dinning.
      paymentTypeIndex: 2, //2; PAYMENT OPTIONS ARE LATER(0), CASH(1) CARD(2||Default)
      ordersCustomer: null,
      totalPrice: 0,
      page:0,
    );

    List<SelectedFood> allSelectedFoodGallery = [];

    CustomerInformation oneCustomerInfo = new CustomerInformation(
      address: '',
      flatOrHouseNumber: '',
      phoneNumber: '',
      etaTimeInMinutes: -1,
    );

    orderFG.selectedFoodInOrder = allSelectedFoodGallery;
    orderFG.selectedFoodListLength = allSelectedFoodGallery.length;
    orderFG.totalPrice= 10.0;
    orderFG.ordersCustomer = oneCustomerInfo;
    print('add_shopping_cart button pressed');

    final bool isCancelButtonPressed = await Navigator.of(context).push(

      PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration(
            milliseconds: 900),
        pageBuilder: (_, __, ___) =>
            BlocProvider<ClientShoppingBloc>(
                bloc: ClientShoppingBloc(orderFG),
                child: ClientShoppingCart()

            ),

      ),
    );

    print('isCancelButtonPressed: $isCancelButtonPressed');


//    return BlocProvider<ClientShoppingBloc>(
//        bloc: ClientShoppingBloc(orderFG),
//        child: ClientShoppingCart()
//
//    );
  }

  _navigateAndDisplaySelection(BuildContext context,FoodItemWithDocID oneFoodItem) async {

    print('at _navigateAndDisplaySelection');

  }



  List<Widget> _getWords2(String text, String imageURL) {

    List<Widget> res = [];
    var words = text.split(" ");
    res.add(
      Container(
        width: displayWidth(context) /10,
        height: displayWidth(context) /7,
        padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),
        child:ClipOval(

          child: CachedNetworkImage(
            imageUrl: imageURL,
            fit: BoxFit.cover,
            placeholder: (context,
                url) => new LinearProgressIndicator(),
            errorWidget: (context, url, error) =>
                Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2Fingredient404.jpg?alt=media'),
//
          ),
        ),
      ),

    );

    res.add(RotatedBox(quarterTurns: 1, child: Text(text,style:
    TextStyle(

      fontFamily: 'Itim-Regular',
      fontSize: 30,
      fontWeight: FontWeight.normal,
//                    fontStyle: FontStyle.italic,
      color: Color(0xff727C8E),
    ),
    ),
    ),

    );



    return res;
  }
  List<Widget> _getWords1(String text, String imageURL) {

    List<Widget> res = [];
    res.add(
      Container(

        width: displayWidth(context) /10,
        height: displayWidth(context) /7,
        padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),
        child:ClipOval(

          child: CachedNetworkImage(
            imageUrl: imageURL,
            fit: BoxFit.cover,
            placeholder: (context,
                url) => new LinearProgressIndicator(),
            errorWidget: (context, url, error) =>
                Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2Fingredient404.jpg?alt=media'),
//
          ),
        ),
      ),

    );


    res.add(RotatedBox(quarterTurns: 1, child: Text(text + ' ',style:
    TextStyle(

      fontFamily: 'Itim-Regular',
      fontSize: 30,
      fontWeight: FontWeight.normal,
//                    fontStyle: FontStyle.italic,
      color: Color(0xffFFFFFF),
    ),
    ),
    ),

    );

    return res;
  }

  Widget _buildCategoryRow(/*DocumentSnapshot document*/
      NewCategoryItem oneCategory, int index) {
//    final DocumentSnapshot document = snapshot.data.documents[index];
    final String categoryName = oneCategory.categoryName;


//    print('imageURL: ${oneCategory.imageURL}');
//    final String categoryName = document['name'];

//    final DocumentSnapshot document = snapshot.data.documents[index];
//    final String categoryName = document['name'];




    if (_currentCategory.toLowerCase() == categoryName.toLowerCase()) {


      return
        RaisedButton(
//                        color: Color(0xffFEE295),
          color:Color(0xff727C8E),

          highlightColor: Colors.redAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
          clipBehavior: Clip.hardEdge,
          splashColor: Color(0xffB47C00),
          highlightElevation: 12,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color(0xff707070),
              style: BorderStyle.solid,
//            width: 1,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),

          child:Container(
//            width:40,
//            height:130,
            height:displayHeight(context)/2.4,
//    FittedBox(fit:BoxFit.fitWidth, stringifiedFoodItemIngredients
            child: Wrap(
              direction: Axis.vertical,
              children: _getWords1(categoryName.toLowerCase(),oneCategory.imageURL),
            ),

          ),
          onPressed: () {
//
            print('onTap pressed');
            print('index: $index');
            setState(() {
              _currentCategory = categoryName;
              _firstTimeCategoryString = categoryName;
            });

            print(
                'finish button pressed');

          },
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

        );


    }
    else {

      return
        RaisedButton(
//                        color: Color(0xffFEE295),
          color:Color(0xffE3E5E8),
          highlightColor: Colors.lightGreenAccent,
//                                                                          highlightedBorderColor: Colors.blueAccent,
          clipBehavior: Clip.hardEdge,
          splashColor: Color(0xffB47C00),
          highlightElevation: 12,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Color(0xff707070),
              style: BorderStyle.solid,
//            width: 1,
            ),
            borderRadius: BorderRadius.circular(30.0),

          ),

          child:Container(
            height:displayHeight(context)/2.4,
//            width:displayWidth(context)/4,
//            width:40,

            child:

            Container(
//    FittedBox(fit:BoxFit.fitWidth, stringifiedFoodItemIngredients

              child: Wrap(
                direction: Axis.vertical,
                children: _getWords2(categoryName.toLowerCase(),oneCategory.imageURL),
              ),

            ),



          ),
          onPressed: () {
            print('onTap pressed');
            print('index: $index');
            setState(() {
              _currentCategory = categoryName;
              _firstTimeCategoryString = categoryName;
            });

          },
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

        );


    }
  }





  /*
  Widget foodList(/*String categoryString,String searchString2,BuildContext context*/)  {
    final foodGalleryBloc = BlocProvider.of<FoodGalleryBloc>(context);

    return StreamBuilder<List<FoodItemWithDocID>>(
//        stream:bloc.getAllFoodItems(),

      stream: foodGalleryBloc.foodItemsStream,


      initialData: foodGalleryBloc.allFoodItems,
//        initialData: bloc.getAllFoodItems(),
      builder: (context, snapshot) {


        print('snapshot.hasData FG2 : ${snapshot.hasData}');


        if (snapshot.hasData) {
//          return Center(child:
//          Text('${messageCount.toString()}')
//          );
          print(
              'searchString  ##################################: $searchString2');
          print(
              'categoryString  ##################################: $categoryString');
          // ..p


//          int messageCount = filteredItems.length;

          //..p
          final List<FoodItemWithDocID> allFoods = snapshot.data;

          List<FoodItemWithDocID> filteredItemsByCategory;

//          logger.i('categoryString.toLowerCase().trim(): ',categoryString.toLowerCase().trim());

          if (categoryString.toLowerCase().trim() != 'all') {
            filteredItemsByCategory = allFoods.where((oneItem) =>
            oneItem.categoryName.
            toLowerCase() ==
                categoryString.toLowerCase()).toList();


            // to do test.
            // if(searchString2!=null)
            final List filteredItems = filteredItemsByCategory.where((
                oneItem) =>
                oneItem.itemName.toLowerCase().
                contains(
                    searchString2.toLowerCase())).toList();

            final int categoryItemsCount = filteredItems.length;
            print('categoryItemsCount: $categoryItemsCount');
            return
              (
                  Container(
                    color: Color(0xffFFFFFF),
                    child:
                    GridView.builder(
                      itemCount: categoryItemsCount,
                      gridDelegate:
                      new SliverGridDelegateWithMaxCrossAxisExtent(

                        //Above to below for 3 not 2 Food Items:
                        maxCrossAxisExtent: 240,
                        mainAxisSpacing: 0, // H  direction
                        crossAxisSpacing: 5,
                        childAspectRatio: 140 / 180,


                      ),
                      shrinkWrap: false,

                      itemBuilder: (_, int index) {
//            logger.i("allFoods Category STring testing line # 1862: ${filteredItems[index]}");

//
                        final String foodItemName = filteredItems[index]
                            .itemName;
                        final String foodImageURL = filteredItems[index]
                            .imageURL;

//            logger.i("foodImageURL in CAtegory tap: $foodImageURL");


//            final String euroPrice = double.parse(filteredItems[index].priceinEuro).toStringAsFixed(2);
                        final Map<String,
                            dynamic> foodSizePrice = filteredItems[index]
                            .sizedFoodPrices;

//            final List<String> foodItemIngredientsList =  filteredItems[index].ingredient;
                        final List<
                            dynamic> foodItemIngredientsList = filteredItems[index]
                            .ingredients;

//            final String foodItemIngredients =    filteredItems[index].ingredients;
//            final String foodItemId =             filteredItems[index].itemId;
//            final bool foodIsHot =                filteredItems[index].isHot;
                        final bool foodIsAvailable = filteredItems[index]
                            .isAvailable;
                        final String foodCategoryName = filteredItems[index]
                            .categoryName;
                        final double discount = filteredItems[index].discount;

//            final Map<String,dynamic> foodSizePrice = document['size'];

//            final List<dynamic> foodItemIngredientsList =  document['ingredient'];
//                print('foodSizePrice __________________________${foodSizePrice['normal']}');
                        final dynamic euroPrice = foodSizePrice['normal'];

//                num euroPrice2 = tryCast(euroPrice);
                        double euroPrice2 = tryCast<double>(
                            euroPrice, fallback: 0.00);
//                String euroPrice3= num.toString();
//                print('euroPrice2 :$euroPrice2');

                        String euroPrice3 = euroPrice2.toStringAsFixed(2);

                        FoodItemWithDocID oneFoodItem = new FoodItemWithDocID(


                            itemName: foodItemName,
                            categoryName: foodCategoryName,
                            imageURL: foodImageURL,
                            sizedFoodPrices: foodSizePrice,

//              priceinEuro: euroPrice,
                            ingredients: foodItemIngredientsList,

//              itemId:foodItemId,
//              isHot: foodIsHot,
                            isAvailable: foodIsAvailable,
                            discount: discount

                        );


//            logger.i('ingredients:',foodItemIngredientsList);

                        String stringifiedFoodItemIngredients = listTitleCase(
                            foodItemIngredientsList);


//            print('document__________________________: ${document.data}');
//            Map<String, dynamic> oneFoodItemData = Map<String, dynamic>.from (document.data);
//            print('FoodItem:__________________________________________ $oneFoodItemData');


                        return
                          Container(
                            // `opacity` is alpha channel of this color as a double, with 0.0 being
                            //  ///   transparent and 1.0 being fully opaque.
                              color: Color(0xffFFFFFF),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 16.0),
                              child: InkWell(
                                child: Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    new Container(child:
                                    new Container(
                                      width: displayWidth(context) / 7,
                                      height: displayWidth(context) / 7,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
//                                          707070
//                                              color:Color(0xffEAB45E),
// good yellow color
//                                            color:Color(0xff000000),
                                              color: Color(0xff707070),
// adobe xd color
//                                              color: Color.fromRGBO(173, 179, 191, 1.0),
                                              blurRadius: 30.0,
                                              spreadRadius: 0.7,
                                              offset: Offset(0, 10)
                                          )
                                        ],
                                      ),
                                      child: Hero(
                                        tag: foodItemName,
                                        child:
                                        ClipOval(
                                          child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                                            imageUrl: foodImageURL,
                                            fit: BoxFit.cover,
                                            placeholder: (context,
                                                url) => new CircularProgressIndicator(),
                                          ),
                                        ),
                                        placeholderBuilder: (context,
                                            heroSize, child) {
                                          return Opacity(
                                            opacity: 0.5, child: Container(
                                            width: displayWidth(context) /
                                                7,
                                            height: displayWidth(context) /
                                                7,
                                            decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              boxShadow: [
                                                BoxShadow(
//                                          707070
//                                              color:Color(0xffEAB45E),
// good yellow color
//                                            color:Color(0xff000000),
                                                    color: Color(
                                                        0xffEAB45E),
// adobe xd color
//                                              color: Color.fromRGBO(173, 179, 191, 1.0),
                                                    blurRadius: 30.0,
                                                    spreadRadius: 0.7,
                                                    offset: Offset(0, 10)
                                                )
                                              ],
                                            ),
                                            child:
                                            ClipOval(
                                              child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                                                imageUrl: foodImageURL,
                                                fit: BoxFit.cover,
                                                placeholder: (context,
                                                    url) => new CircularProgressIndicator(),
                                              ),
                                            ),
                                          ),
                                          );
                                        },
//                                  placeholderBuilder: (context,
//                                      Size.fromWidth(displayWidth(context) / 7),
//                          Image.network(foodImageURL)
//
//                                );
                                        //Placeholder Image.network(foodImageURL),
                                      ),

                                    ),

                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 6),
                                    ),
//                              SizedBox(height: 10),


                                    Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: <Widget>[
                                          Text(
//                                  double.parse(euroPrice).toStringAsFixed(2),
                                            euroPrice3 + '\u20AC',
                                            style: TextStyle(
                                                fontWeight: FontWeight
                                                    .normal,
//                                          color: Colors.blue,
                                                color: Color.fromRGBO(
                                                    112, 112, 112, 1),
                                                fontSize: 20),
                                          ),
//                                    SizedBox(width: 10),
                                          SizedBox(
                                              width: displayWidth(context) /
                                                  100),

                                          Icon(
                                            Icons.whatshot,
                                            size: 24,
                                            color: Colors.red,
                                          ),
                                        ]),


                                    FittedBox(fit: BoxFit.fitWidth, child:
                                    Text(
//                '${dummy.counter}',
                                      foodItemName,

                                      style: TextStyle(
                                        color: Color(0xff707070),
//                                color:Color.fromRGBO(112,112,112,1),

                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),)
                                    ,
                                    Container(
//                                        height: displayHeight(context) / 61,

                                        child: Text(
//                                'stringifiedFoodItemIngredients',


                                          stringifiedFoodItemIngredients
                                              .length == 0
                                              ?
                                          'EMPTY'
                                              : stringifiedFoodItemIngredients
                                              .length > 12 ?
                                          stringifiedFoodItemIngredients
                                              .substring(0, 12) + '...' :
                                          stringifiedFoodItemIngredients,

//                                    foodItemIngredients.substring(0,10)+'..',
                                          style: TextStyle(
                                            color: Color(0xff707070),
                                            fontWeight: FontWeight.normal,
                                            letterSpacing:0.5,
                                            fontSize: 15,
                                          ),
                                        )
                                    ),
//
//
                                  ],
                                ),
                                onTap: () {
                                  _navigateAndDisplaySelection(
                                      context, oneFoodItem);
                                },


                              )
                          );
//            return SpoiledItem(/*dummy: snapshot.data[index]*/);
                      },

                    ),
                  )
              );
          }
          else {
//            logger.i('allFoods at all else is: ', allFoods.length);

            final List filteredItems = allFoods.where((oneItem) =>
                oneItem.itemName.toLowerCase().
                contains(
                    searchString2.toLowerCase())).toList();
            return
              (
                  Container(
                    color: Color(0xffFFFFFF),
                    child:
                    GridView.builder(
                      itemCount: filteredItems.length,
                      gridDelegate:
                      new SliverGridDelegateWithMaxCrossAxisExtent(

//          maxCrossAxisExtent: 270,
                        //          crossAxisSpacing: 0,
                        /*
          maxCrossAxisExtent: 310,
          mainAxisSpacing: 20, // H  direction
          childAspectRatio: 160/220,
          crossAxisSpacing: 10,
          */

                        ///childAspectRatio:
                        /// The ratio of the cross-axis to the main-axis extent of each child.
                        /// H/V

                        /*
                maxCrossAxisExtent: 290,
                mainAxisSpacing: 0, // H  direction
                crossAxisSpacing: 5,
                childAspectRatio: 160/160,

                 */
                        //Above to below for 3 not 2 Food Items:
                        maxCrossAxisExtent: 240,
                        mainAxisSpacing: 0, // H  direction
                        crossAxisSpacing: 5,
//                        childAspectRatio: 140 / 180,
                        childAspectRatio: 140 / 180,


                      ),
                      shrinkWrap: false,

                      itemBuilder: (_, int index) {
//            logger.i("allFoods Category STring testing line # 1862: ${filteredItems[index]}");

//
                        final String foodItemName = filteredItems[index]
                            .itemName;
                        final String foodImageURL = filteredItems[index]
                            .imageURL;

//            logger.i("foodImageURL in CAtegory tap: $foodImageURL");


//            final String euroPrice = double.parse(filteredItems[index].priceinEuro).toStringAsFixed(2);
                        final Map<String,
                            dynamic> foodSizePrice = filteredItems[index]
                            .sizedFoodPrices;

//            final List<String> foodItemIngredientsList =  filteredItems[index].ingredient;
                        final List<
                            dynamic> foodItemIngredientsList = filteredItems[index]
                            .ingredients;

//            final String foodItemIngredients =    filteredItems[index].ingredients;
//            final String foodItemId =             filteredItems[index].itemId;
//            final bool foodIsHot =                filteredItems[index].isHot;
                        final bool foodIsAvailable = filteredItems[index]
                            .isAvailable;
                        final String foodCategoryName = filteredItems[index]
                            .categoryName;

//            final Map<String,dynamic> foodSizePrice = document['size'];

//            final List<dynamic> foodItemIngredientsList =  document['ingredient'];
//                print('foodSizePrice __________________________${foodSizePrice['normal']}');
                        final dynamic euroPrice = foodSizePrice['normal'];

                        final double discount = filteredItems[index].discount;

//                num euroPrice2 = tryCast(euroPrice);
                        double euroPrice2 = tryCast<double>(
                            euroPrice, fallback: 0.00);
//                String euroPrice3= num.toString();
//                print('euroPrice2 :$euroPrice2');

                        String euroPrice3 = euroPrice2.toStringAsFixed(2);

                        FoodItemWithDocID oneFoodItem = new FoodItemWithDocID(


                          itemName: foodItemName,
                          categoryName: foodCategoryName,
                          imageURL: foodImageURL,
                          sizedFoodPrices: foodSizePrice,

//              priceinEuro: euroPrice,
                          ingredients: foodItemIngredientsList,

//              itemId:foodItemId,
//              isHot: foodIsHot,
                          isAvailable: foodIsAvailable,
                          discount: discount,

                        );


//            logger.i('ingredients:',foodItemIngredientsList);

                        String stringifiedFoodItemIngredients = listTitleCase(
                            foodItemIngredientsList);


//            print('document__________________________: ${document.data}');
//            Map<String, dynamic> oneFoodItemData = Map<String, dynamic>.from (document.data);
//            print('FoodItem:__________________________________________ $oneFoodItemData');


                        return
                          Container(
                            // `opacity` is alpha channel of this color as a double, with 0.0 being
                            //  ///   transparent and 1.0 being fully opaque.
                              color: Color(0xffFFFFFF),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.0, vertical: 16.0),
                              child: InkWell(
                                  child: Column(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      new Container(child:
                                      new Container(
                                        width: displayWidth(context) / 7,
                                        height: displayWidth(context) / 7,
                                        decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
//                                          707070
//                                              color:Color(0xffEAB45E),
// good yellow color
//                                            color:Color(0xff000000),
                                                color: Color(0xff707070),
// adobe xd color
//                                              color: Color.fromRGBO(173, 179, 191, 1.0),
                                                blurRadius: 30.0,
                                                spreadRadius: 1,
                                                offset: Offset(0, 10)
                                            )
                                          ],
                                        ),
                                        child: Hero(
                                          tag: foodItemName,
                                          child:
                                          ClipOval(
                                            child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                                              imageUrl: foodImageURL,
                                              fit: BoxFit.cover,
                                              placeholder: (context,
                                                  url) => new CircularProgressIndicator(),
                                            ),
                                          ),
                                          placeholderBuilder: (context,
                                              heroSize, child) {
                                            return Opacity(
                                              opacity: 0.5, child: Container(
                                              width: displayWidth(context) /
                                                  7,
                                              height: displayWidth(context) /
                                                  7,
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
//                                          707070
//                                              color:Color(0xffEAB45E),
// good yellow color
//                                            color:Color(0xff000000),
                                                      color: Color(
                                                          0xffEAB45E),
// adobe xd color
//                                              color: Color.fromRGBO(173, 179, 191, 1.0),
                                                      blurRadius: 30.0,
                                                      spreadRadius: 0.7,
                                                      offset: Offset(0, 10)
                                                  )
                                                ],
                                              ),
                                              child:
                                              ClipOval(
                                                child: CachedNetworkImage(
//                  imageUrl: dummy.url,
                                                  imageUrl: foodImageURL,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context,
                                                      url) => new CircularProgressIndicator(),
                                                ),
                                              ),
                                            ),
                                            );
                                          },
//                                  placeholderBuilder: (context,
//                                      Size.fromWidth(displayWidth(context) / 7),
//                          Image.network(foodImageURL)
//
//                                );
                                          //Placeholder Image.network(foodImageURL),
                                        ),

                                      ),

                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 6),
                                      ),
//                              SizedBox(height: 10),


                                      Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            Text(
//                                  double.parse(euroPrice).toStringAsFixed(2),
                                              euroPrice3 + '\u20AC',
                                              style: TextStyle(
                                                  fontWeight: FontWeight
                                                      .normal,
//                                          color: Colors.blue,
                                                  color: Color.fromRGBO(
                                                      112, 112, 112, 1),
                                                  fontSize: 20),
                                            ),
//                                    SizedBox(width: 10),
                                            SizedBox(
                                                width: displayWidth(context) /
                                                    100),

                                            Icon(
                                              Icons.whatshot,
                                              size: 24,
                                              color: Colors.red,
                                            ),
                                          ]),


                                      FittedBox(fit: BoxFit.fitWidth, child:
                                      Text(
//                '${dummy.counter}',
                                        foodItemName,

                                        style: TextStyle(
                                          color: Color(0xff707070),
//                                color:Color.fromRGBO(112,112,112,1),

                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),)
                                      ,
                                      Container(
                                          height: displayHeight(context) / 61,

                                          child: Text(
//                                'stringifiedFoodItemIngredients',


                                            stringifiedFoodItemIngredients
                                                .length == 0
                                                ?
                                            'EMPTY'
                                                : stringifiedFoodItemIngredients
                                                .length > 12 ?
                                            stringifiedFoodItemIngredients
                                                .substring(0, 12) + '...' :
                                            stringifiedFoodItemIngredients,

//                                    foodItemIngredients.substring(0,10)+'..',
                                            style: TextStyle(
                                              color: Color(0xff707070),
                                              fontWeight: FontWeight.normal,
//                                              fontSize: 15,
                                              letterSpacing:0.5,
                                              fontSize: 15,
                                            ),
                                          )
                                      ),
//
//
                                    ],
                                  ),
                                  onTap: () {


                                    _navigateAndDisplaySelection(
                                        context, oneFoodItem);


                                    /*
                                    final blocG = BlocProvider.of<FoodGalleryBloc>(context);
//                                    final blocG =
//                                        BlocProvider2.of(context).getFoodGalleryBlockObject;

                                    List<NewIngredient> tempIngs = blocG.getAllIngredientsPublicFGB2;


//                                    final blocD = BlocProvider2.of(context).getFoodItemDetailsBlockObject;

//                                    blocD.getAllIngredients();
//                                    List<NewIngredient> test = blocD.allIngredients;


//                                    logger.e('tempIngs_push 2: $tempIngs');


//                                    blocD.setallIngredients(tempIngs);

                                    return Navigator.of(context).push(


                                      PageRouteBuilder(
                                        opaque: false,
                                        transitionDuration: Duration(
                                            milliseconds: 900),
                                        pageBuilder: (_, __, ___) =>

                                        /*
                                            BlocProvider2 /*<FoodItemDetailsBloc>*/(
                                              /*thisAllIngredients2:allIngredients,*/
                                              /*bloc: FoodItemDetailsBloc(
                                                  oneFoodItem,
                                                  allIngredients), */

                                              bloc2: AppBloc(
                                                  oneFoodItem, tempIngs),


                                              child: FoodItemDetails2()

                                              ,),
                                        */

                                            BlocProvider<FoodItemDetailsBloc>(
                                              bloc: FoodItemDetailsBloc(
                                                  oneFoodItem,
                                                  tempIngs),

                                              child: FoodItemDetails2()

                                              ,),

                                        // fUTURE USE -- ANIMATION TRANSITION CODE.
                                        /*
                                  transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: RotationTransition(
                                        turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                                        child: child,
                                      ),
                                    );
                                  }
                                  */
                                      ),
                                    );

                                    */
                                  }

                              )
                          );
//            return SpoiledItem(/*dummy: snapshot.data[index]*/);
                      },

                    ),
                  )
              );
          }
        }
        else {
          return Center(child:
          Text('No Data')
          );
        }
      },
    );
  }



}

   */


  Widget futureWidget(){

    return Container(
//                                                                        width:60,
      width: displayWidth(
          context) / 13,
      height: displayHeight(context) / 25,
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),

      child: OutlineButton(
        onPressed: () async {
          print(
              ' method for old Outline button that deals with navigation to Shopping Cart Page');

          print(

              'add_shopping_cart button pressed');

          //          Navigator.of(context).push(

//          return










        },
//                        color: Color(0xffFEE295),
        clipBehavior: Clip.hardEdge,
        splashColor: Color(0xffFEE295),
//          splashColor: Color(0xff739DFA),
        highlightElevation: 12,
//          clipBehavior: Clip.hardEdge,
//          highlightElevation: 12,
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(35.0),
        ),
//          disabledBorderColor: false,
        borderSide: BorderSide(
          color: Color(0xffFEE295),
          style: BorderStyle.solid,
          width: 3.6,
        ),


        child:

        ///SSWW


        Center(
          child: Stack(
              children: <Widget>[ Center(
                child: Icon(

                  Icons.add_shopping_cart,
                  size: displayWidth(context)/19,
                  color: Color(0xff707070),
                ),
              ),

                Container(
//                                              color:Colors.red,
                  width: displayWidth(context)/25,


                  decoration: new BoxDecoration(
                    color: Colors.redAccent,

                    border: new Border.all(
                        color: Colors.green,
                        width: 1.0,
                        style: BorderStyle.solid
                    ),
                    shape: BoxShape.circle,

                  ),

                  alignment: Alignment.center,
                  child: Text(
                    '_totalCount.toString()',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight
                          .normal,
                      fontSize: 20,
                    ),
                  ),

                ),

              ]
          ),
        ),

      ),
    );

  }


}


class LongHeaderPainterBefore extends CustomPainter {


  final BuildContext context;
  LongHeaderPainterBefore(this.context);


  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(-displayWidth(context)/4, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(-10, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}


class LongHeaderPainterAfter extends CustomPainter {

  final BuildContext context;
  LongHeaderPainterAfter(this.context);
  @override
  void paint(Canvas canvas, Size size){

//    canvas.drawLine(...);
    final p1 = Offset(displayWidth(context)/4, 15); //(X,Y) TO (X,Y)
    final p2 = Offset(10, 15);
    final paint = Paint()
      ..color = Color(0xff000000)
//          Colors.white
      ..strokeWidth = 3;
    canvas.drawLine(p1, p2, paint);

  }
  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }

}

