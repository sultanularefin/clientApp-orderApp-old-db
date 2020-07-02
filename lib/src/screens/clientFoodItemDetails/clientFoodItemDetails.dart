//food_gallery.dart



// dependency files
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:linkupclient/src/DataLayer/models/FoodItemWithDocIDViewModel.dart';

import 'package:linkupclient/src/DataLayer/models/NewIngredient.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:linkupclient/src/screens/clientFoodItemDetails/Widgets/ClientFoodDetailImage.dart';

//sizeConstantsList


// SCREEN FILES AND MODLE FILES AND UTILITY FILES.

import 'package:linkupclient/src/utilities/screen_size_reducers.dart';
//import 'package:linkupclient/src/screens/foodItemDetailsPage/Widgets/ClientFoodDetailImage.dart';
//import 'package:linkupclient/src/DataLayer/models/FoodItemWithDocID.dart';
import 'package:linkupclient/src/DataLayer/models/Order.dart';
import 'package:linkupclient/src/DataLayer/models/FoodPropertyMultiSelect.dart';
import 'package:linkupclient/src/DataLayer/models/SelectedFood.dart';

// Blocks

import 'package:linkupclient/src/BLoC/bloc_provider.dart';
import 'package:linkupclient/src/BLoC/clientFoodItemDetails_bloc.dart';

final Firestore firestore = Firestore();



class ClientFoodItemDetails extends StatefulWidget {
//  AdminFirebase({this.firestore});

  final Widget child;
//  final FoodItem oneFoodItemData;


//  FoodItemWithDocID oneFoodItem =new FoodItemWithDocID(


  ClientFoodItemDetails({Key key, this.child}) : super(key: key);

  @override
  _FoodItemDetailsState createState() => new _FoodItemDetailsState();


//  _FoodItemDetailsState createState() => _FoodItemDetailsState();



}


class _FoodItemDetailsState extends State<ClientFoodItemDetails> {

//  var logger = Logger(
//    printer: PrettyPrinter(),
//  );

  String _currentSize;
//  int _itemCount= 0;
  double initialPriceByQuantityANDSize = 0.0;






//  color: Color(0xff34720D),
//  VS 0xffFEE295 3 0xffFEE295 false
//  ORG 0xff739DFA 4 0xff739DFA false



  /*

  @override
  void initState() {

//    setDetailForFood();
//    retrieveIngredientsDefault();
    super.initState();
  }
  */



  double tryCast<num>(dynamic x, {num fallback }) {

//    print(" at tryCast");
//    print('x: $x');

    bool status = x is num;

//    print('status : x is num $status');
//    print('status : x is dynamic ${x is dynamic}');
//    print('status : x is int ${x is int}');
    if(status) {
      return x.toDouble() ;
    }

    if(x is int) {return x.toDouble();}
    else if(x is double) {return x.toDouble();}


    else return 0.0;
  }

  bool showUnSelectedIngredients = false;
  bool showPressWhenFinishButton = false;
  double addedHeight =0.0;


  @override
  Widget build(BuildContext context) {

//    final blocD = BlocProvider2.of(context).getClientFoodItemDetailsBlockObject;
//    logger.e('blocD: $blocD');
    final blocD = BlocProvider.of<ClientFoodItemDetailsBloc>(context);

//    print('totalCartPrice -----------> : $totalCartPrice');
//    print('initialPriceByQuantityANDSize ----------> $initialPriceByQuantityANDSize');

//    logger.w('defaultIngredients: ',bloc.defaultIngredients);

//    List<NewIngredient> defaultIngredients = ClientFoodItemDetailsBloc.getDefaultIngredients;
    List<NewIngredient> unSelectedIngredients = blocD.unSelectedIngredients;

    // print('unSelectedIngredients: $unSelectedIngredients');



    /*
    logger.w('unSelectedIngredients in foodItemDetails2 line #116 : ',
        unSelectedIngredients);

    */

    if (unSelectedIngredients == null) {
      return Container
        (
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      );
    }
    else {


      return Container(

          child: StreamBuilder<FoodItemWithDocIDViewModel>(


              stream: blocD.currentFoodItemsStream,
              initialData: blocD.currentFoodItem,

              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: new LinearProgressIndicator());
                }
                else {
                  //   print('snapshot.hasData FDetails: ${snapshot.hasData}');

                  final FoodItemWithDocIDViewModel oneFood = snapshot
                      .data;

                  /*
                  logger.i('oneFood.itemName after '
                      ''
                      'snapshot.hasData FDetails: ${oneFood.itemName}');

                  */

                  final Map<String, dynamic> foodSizePrice = oneFood
                      .sizedFoodPrices;


                  double priceByQuantityANDSize = 0.0;
                  //            initialPriceByQuantityANDSize = oneFood.itemSize;

                  initialPriceByQuantityANDSize = oneFood.itemPrice;
                  priceByQuantityANDSize = oneFood.itemPrice;
                  _currentSize = oneFood.itemSize;



//                  print('oneFood.itemSize: ${oneFood.itemSize}');


//        return(Container(
//            color: Color(0xffFFFFFF),
//            child:
//            GridView.builder(


//            final Map<String, dynamic> foodSizePrice = oneFood.sizedFoodPrices;
                  return GestureDetector(
                    onTap: () {
                      print('s');
                      print('navigating to FoodGallery 2 again with block');

                      FocusScopeNode currentFocus = FocusScope.of(
                          context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
//                  Navigator.pop(context);

                      }

//                      return Navigator.of(context).pop(
//                           BlocProvider<FoodGalleryBloc>(
//                              bloc: FoodGalleryBloc(),
//                                  child: FoodGallery2()
//
//                              )
//
//                      );


//                      Navigator.pop(context);

//                      FoodItemWithDocID emptyFoodItemWithDocID =new FoodItemWithDocID();
//                      List<NewIngredient> emptyIngs = [];


                      final blocD = BlocProvider.of<ClientFoodItemDetailsBloc>(context);
//                      final blocD =
//                          BlocProvider2.of(context).getClientFoodItemDetailsBlockObject;

                      SelectedFood temp = blocD.getCurrentSelectedFoodDetails;

                      print('temp is $temp');



                      SelectedFood tempSelectedFood = temp == null? new SelectedFood():
                      temp /*.selectedFoodInOrder.first*/;





                      return Navigator.pop(context,tempSelectedFood);

//



                    },
                    child:
                    Scaffold(

//                      backgroundColor: Colors.white.withOpacity(0.05),
                      // this is the main reason of transparency at next screen.
                      // I am ignoring rest implementation but what i have achieved is you can see.

                      body: SafeArea(


                        // smaller container containing all modal FoodItem Details things.
                          child: Container(
                            height: displayHeight(context) -
                                MediaQuery.of(context).padding.top,
                            width: displayWidth(context),
//                                kToolbarHeight,

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .start,
                              crossAxisAlignment: CrossAxisAlignment
                                  .center,
                              children: <Widget>[

                                Container(
                                  padding: EdgeInsets
                                      .fromLTRB(
                                      0, 10, 0,
                                      0),
                                  child:

                                  Text(
                                      '${oneFood
                                          .itemName}',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.normal,
//                                                      color: Colors.white
                                        color: Colors
                                            .black,
                                        fontFamily: 'Itim-Regular',

                                      )
                                  ),
                                ),

                                Container(
                                  /*
                                color:Colors.blue,
                              width:displayWidth(context)/4.6,
                              */
                                  padding: EdgeInsets
                                      .fromLTRB(
                                      0, 0,0, 0),


                                  child: ClientFoodDetailImage(
                                      oneFood
                                          .imageURL,
                                      oneFood
                                          .itemName),
                                ),


                                Container(
                                  padding: EdgeInsets
                                      .fromLTRB(
                                      0, 0, 0,
                                      0),
                                  child:

                                  Text(
                                      '${initialPriceByQuantityANDSize.toStringAsFixed(2)}' +
                                          '\u20AC',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight
                                            .normal,
//                                                      color: Colors.white
                                        color: Colors
                                            .black,
                                        fontFamily: 'Itim-Regular',

                                      )
                                  ),
                                ),

                                StreamBuilder<SelectedFood>(

                                    stream: blocD.getCurrentSelectedFoodStream,
                                    initialData: blocD.getCurrentSelectedFoodDetails,
                                    builder: (context, snapshot) {
                                      if ((snapshot.hasError) || (!snapshot.hasData)) {
                                        return Center(
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text('WRNG'),
                                          ),
                                        );
                                      }
                                      else {
//                    logger.e('snapshot.hasData: ${snapshot.hasData} getCurrentSelectedFoodStream');
//                    Order incrementCurrentFoodProcessing = snapshot.data;

                                        SelectedFood incrementCurrentFoodProcessing = snapshot.data;


//                    int lengthOfSelectedItemsLength = incrementOrderProcessing.selectedFoodListLength;
//                    logger.e('lengthOfSelectedItemsLength: $lengthOfSelectedItemsLength');

                                        int itemCountNew;


//                    print('incrementOrderProcessing.selectedFoodInOrder.isEmpty:'
//                        ' ${incrementOrderProcessing.selectedFoodInOrder.isEmpty}');
                                        print('incrementCurrentFoodProcessing==null ${incrementCurrentFoodProcessing==null}');


//                    if( incrementOrderProcessing.selectedFoodInOrder.isEmpty) {
//                      itemCountNew=0;
//
//                    }
                                        if(incrementCurrentFoodProcessing==null){
                                          itemCountNew=0;
                                        }
                                        else {
//                      itemCountNew = incrementOrderProcessing
////                          .selectedFoodInOrder[lengthOfSelectedItemsLength-1]
////                          .quantity;
                                          itemCountNew = incrementCurrentFoodProcessing.quantity;
                                        }



//                    logger.e('itemCountNew: $itemCountNew');
                                        return Container(
//                        color: Colors.indigoAccent,
                                          color: Colors.white,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 0,
                                              vertical: 0),

                                          width: displayWidth(context) /
                                              2.7,
//                height: 45,
                                          height: displayHeight(context) / 21,

//                                            color:Color(0xffC27FFF),
                                          child:
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[


                                              // todo shopping.

//                                                                          SizedBox(
//                                                                            width: 3,
//                                                                          ),
                                              // WORK 1
                                              IconButton(

                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0, vertical: 0),
                                                icon: Icon(Icons.add_circle_outline),
                                                iconSize: 32,

                                                tooltip: 'Increase product count by 1 ',
                                                onPressed: () {
//                            final BlocD = BlocProvider.of<ClientFoodItemDetailsBloc>(context);

//                              incrementOrderProcessing.selectedFoodInOrder.isEmpty

                                                  SelectedFood incrementCurrentFoodProcessing = snapshot.data;
//                              Order incrementOrderProcessing = snapshot.data;
//                              int lengthOfSelectedItemsLength = incrementOrderProcessing.selectedFoodListLength;

                                                  if(incrementCurrentFoodProcessing.quantity == 0){
                                                    print(' JJJJ at lengthOfSelectedItemsLength  == 0 ');

                                                    print('itemCountNew JJJJ $itemCountNew');

                                                    int initialItemCount = 0;

                                                    int quantity =1;
                                                    // INITIAL CASE FIRST ITEM FROM ENTERING THIS PAGE FROM FOOD GALLERY PAGE.
                                                    SelectedFood oneSelectedFoodFD = new SelectedFood(
                                                      foodItemName: blocD
                                                          .currentFoodItem.itemName,
                                                      foodItemImageURL: blocD
                                                          .currentFoodItem.imageURL,
                                                      unitPrice: initialPriceByQuantityANDSize,
                                                      foodDocumentId: blocD
                                                          .currentFoodItem.documentId,
                                                      quantity: quantity,
                                                      foodItemSize: _currentSize,
                                                      categoryName:blocD
                                                          .currentFoodItem.categoryName,
                                                      discount:blocD
                                                          .currentFoodItem.discount,
                                                      // index or int value not good enought since size may vary best on Food Types .
                                                    );

                                                    blocD
                                                        .incrementOneSelectedFoodForOrder(
                                                        oneSelectedFoodFD, initialItemCount);
                                                  }
                                                  else{
                                                    print(' at else RRRRR');

//                                itemCountNew = incrementOrderProcessing
//                                    .selectedFoodInOrder[lengthOfSelectedItemsLength-1]
//                                    .quantity;

                                                    int oldQuantity = incrementCurrentFoodProcessing.quantity;
//                                int oldQuantity = incrementOrderProcessing.
//                                selectedFoodInOrder[lengthOfSelectedItemsLength-1].quantity;

                                                    int newQuantity = oldQuantity + 1;

                                                    SelectedFood oneSelectedFoodFD = new SelectedFood(
                                                      foodItemName: blocD
                                                          .currentFoodItem.itemName,
                                                      foodItemImageURL: blocD
                                                          .currentFoodItem.imageURL,
                                                      unitPrice: initialPriceByQuantityANDSize,
                                                      foodDocumentId: blocD
                                                          .currentFoodItem.documentId,
                                                      quantity: newQuantity,
                                                      foodItemSize: _currentSize,
                                                      categoryName:blocD
                                                          .currentFoodItem.categoryName,
                                                      discount:blocD
                                                          .currentFoodItem.discount,
                                                      // index or int value not good enought since size may vary best on Food Types .
                                                    );


                                                    //incrementCurrentFoodProcessing.quantity= newQuantity;

                                                    // TODO TODO TODO.
                                                    // TO DO SOME CODES CAN BE OMITTED HERE, LIKE WE DON'T NEED TO PASS THIS PARAMETER OR
                                                    // NEITHER NEED TO RECREATE IT ABOVE, WE NEED TO PASS BUT NOT CREATE IT ABOVE.
                                                    blocD
                                                        .incrementOneSelectedFoodForOrder(oneSelectedFoodFD /*
                                    THIS oneSelectedFoodFD WILL NOT BE USED WHEN SAME ITEM IS INCREMENTED AND

                                    QUANTITY IS MORE THAN ONE.
                                    */,oldQuantity);
                                                  }



                                                },
                                                color: Color(0xff707070),
                                              ),

                                              Container(
//
//                                              color:Colors.red,
                                                width: 30,


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

                                                  itemCountNew.toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight
                                                        .normal,
                                                    fontSize: 20,
                                                  ),
                                                ),

                                              ),





                                              IconButton(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 0, vertical: 0),
                                                icon: Icon(Icons.remove_circle_outline),
//                                                                            icon: Icon(Icons.remove),
                                                iconSize: 32,
                                                tooltip: 'Decrease product count by 1',
                                                onPressed: () {
                                                  final BlocD = BlocProvider.of<
                                                      ClientFoodItemDetailsBloc>(context);
                                                  print(
                                                      'Decrease button pressed related to _itemCount');
                                                  if (itemCountNew >= 1) {
//                                if (itemCountNew == 1) {
                                                    print(
                                                        'itemCountNew== $itemCountNew');

                                                    /*
                                  SelectedFood oneSelectedFoodFD = new SelectedFood(
                                    foodItemName: ClientFoodItemDetailsBloc
                                        .currentFoodItem
                                        .itemName,
                                    foodItemImageURL: ClientFoodItemDetailsBloc
                                        .currentFoodItem.imageURL,
                                    unitPrice: initialPriceByQuantityANDSize,
                                    foodDocumentId: ClientFoodItemDetailsBloc
                                        .currentFoodItem.documentId,
                                    quantity: _itemCount - 1,
                                    foodItemSize: _currentSize,
                                    // index or int value not good enought since size may vary best on Food Types .
                                  );
                                  */
                                                    BlocD
                                                        .decrementOneSelectedFoodForOrder(itemCountNew);

                                                    /*
                                else {
                                  /*
                                  // WHEN _itemCount not 1-1 = zero. but getter than 0(zero).
                                  SelectedFood oneSelectedFoodFD = new SelectedFood(
                                    foodItemName: ClientFoodItemDetailsBloc
                                        .currentFoodItem
                                        .itemName,
                                    foodItemImageURL: ClientFoodItemDetailsBloc
                                        .currentFoodItem.imageURL,
                                    unitPrice: initialPriceByQuantityANDSize,
                                    foodDocumentId: ClientFoodItemDetailsBloc
                                        .currentFoodItem.documentId,
                                    quantity: _itemCount - 1,
                                    foodItemSize: _currentSize,
                                    // index or int value not good enough since size may vary based on Food Types .
                                  );
                                  */
                                  ClientFoodItemDetailsBloc
                                      .decrementOneSelectedFoodForOrder(
                                      oneSelectedFoodFD, _itemCount - 1);
                                      */

//                                }

                                                  }
                                                },
//                              size: 24,
                                                color: Color(0xff707070),
                                              ),




                                            ],

                                          ),

                                        );
                                      }
                                    }
                                ),

                                Container(
                                    height: displayHeight(context) / 25,
//          height:190,
                                    width: displayWidth(context) * 6,
                                    padding: EdgeInsets.fromLTRB(15, 0, 0, 5),

                                    color: Color(0xFFffffff),
                                    alignment: Alignment.centerLeft,

                                    // PPPPP

                                    child:(
                                        Text('Choose Size'.toLowerCase(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Itim-Regular',
                                            color: Colors.black,
                                          ),
                                        )
                                    )
                                ),

                                Container(

                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    height: displayHeight(context) / 7,
//                                                        width: displayWidth(context) /1.80,
                                    child: _buildProductSizes(
                                        context,
                                        foodSizePrice)

                                ),

//                                  Text('ss'),
                                Container(
                                    height: displayHeight(context) / 7,
                                    width: displayWidth(context) * 0.57,
                                    color: Color(0xfff4444aa),
//                                                        alignment: Alignment.center,
                                    child: buildDefaultIngredients(
                                        context
                                    )
                                  //Text('buildDefaultIngredients('
                                  //    'context'
                                  //')'),
                                ),
                              ],




                            ),


                            /*  TOP CONTAINER IN THE STACK WHICH IS VISIBLE ENDS HERE. */



                          )


                      ),


                    ),


                  );
                }
              }
          )
      );
    }
  }


  Widget animatedWidgetPressToFinish(){
    return Container(

//      ==>alignment: THIS CAUSES THE RAISED BUTTON'S HEIGHT SHRINK.
      // Use the properties stored in the State class.
      // Define how long the animation should take.

      // Provide an optional curve to make the animation feel smoother.

      color:Colors.white,

      /*
      width: displayWidth(context)
          - displayWidth(context) /
              3.8 /* this is about the width of yellow side menu */
          - displayWidth(context) /
              26  /* 10% of widht of the device for padding margin.*/
          - displayWidth(
              context) /5, /* this is the image Container left most column width probably
                      */                                            */




//        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),

      child:Center(
//          widthFactor: displayWidth(context)/4,

        heightFactor: 1.5,

        child:

        RaisedButton(
//                        color: Color(0xffFEE295),
          color:Colors.redAccent,
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

            width:displayWidth(context)/4,

            child: Row(
              mainAxisAlignment: MainAxisAlignment
                  .center,
              crossAxisAlignment: CrossAxisAlignment
                  .center,
              children: <
                  Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                  child:
                  Icon(
                    Icons
                        .check,
                    size: 22.0,
                    color: Color(0xffFFFFFF),
                    //        color: Color(0xffFFFFFF),
                  ),),
                Container(child:Text(
                  'PRESS TO FINISH'.toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight
                          .bold,
                      color: Color(0xffFFFFFF),
                      fontSize: 16),
                ),
                )
              ],
            ),
          ),
          onPressed: () {
//

//            logger.i('addedHeight: ',addedHeight);

            final blocD = BlocProvider.of<ClientFoodItemDetailsBloc>(context);
//            final blocD = BlocProvider2.of(context).getClientFoodItemDetailsBlockObject;
//            final BlocD = BlocProvider.of<ClientFoodItemDetailsBloc>(context);
            blocD.updateDefaultIngredientItems(/*oneSelected,index*/);
            if( addedHeight == 0.0 ){
              setState(() {
                addedHeight = /* displayHeight(context)/10*/
                30.0;
                showUnSelectedIngredients = !showUnSelectedIngredients ;
                showPressWhenFinishButton = !showPressWhenFinishButton;





//                ::::A
//                          myAnimatedWidget1 = myAnimatedWidget2;

              });
            }else{

              final blocD = BlocProvider.of<ClientFoodItemDetailsBloc>(context);
//              final blocD = BlocProvider2.of(context).getClientFoodItemDetailsBlockObject;

//              final BlocD = BlocProvider.of<ClientFoodItemDetailsBloc>(context);
              blocD.updateDefaultIngredientItems(/*oneSelected,index*/);


              setState(() {
                addedHeight= 0.0;
                showUnSelectedIngredients = !showUnSelectedIngredients;
                showPressWhenFinishButton = !showPressWhenFinishButton;
//                        myAnimatedWidget2 = myAnimatedWidget1();
              });
            }
            print(
                'finish button pressed');

          },
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

        ),
      ),



    );
  }




  Widget _buildProductSizes(BuildContext context, Map<String,dynamic> allPrices) {
    final Map<String, dynamic> foodSizePrice = allPrices;

    Map<String, dynamic> listpart1 = new Map<String, dynamic>();
//    Map<String, dynamic> listpart2 = new Map<String, dynamic>();
//    Map<String, dynamic> listpart3 = new Map<String, dynamic>();
    // odd

    int len = foodSizePrice.length;
    print('len: $len');





    for (int i = 0; i < len; i++) {
      print('i: $i');
      String keyTest = foodSizePrice.keys
          .elementAt(i);
      dynamic value = foodSizePrice
          .values.elementAt(i);
//
      double valuePrice = tryCast<
          double>(
          value, fallback: 0.0);


      if((valuePrice!=0.0)&&(valuePrice!=0.00)) {
        listpart1[keyTest] = valuePrice;
      }
    }




    if(allPrices==null){
      return Container
        (
//        height: displayHeight(context) / 6.3,
        alignment: Alignment.center,
        child: Text('no sizes found',textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'Itim-Regular',
            color: Colors.white,

          ),),

      );
    }
    else {

      return GridView.builder(
        itemCount: len,
        gridDelegate:
        new SliverGridDelegateWithMaxCrossAxisExtent(

          //Above to below for 3 not 2 Food Items:
          maxCrossAxisExtent: 145,
          mainAxisSpacing: 5, // H  direction
          crossAxisSpacing: 0,
          childAspectRatio: 130 / 45, /* (h/vertical)*/


        ),
        shrinkWrap: false,
        itemBuilder: (_, int index) {


          String key = listpart1.keys
              .elementAt(index);
          double valuePrice = listpart1
              .values.elementAt(index);
//

//                  print(
//                      'valuePrice at line # 583: $valuePrice and key is $key');
          return _buildOneSize(
              key, valuePrice, index);
        },
      );


      // Todo DefaultItemsStreamBuilder


    }
  }


  Widget _buildOneSize(String oneSize,double onePriceForSize, int index) {

    return Container(
//        color:Colors.yellow,

//        margin: EdgeInsets.fromLTRB(0, 0,5,5),
//        height:displayHeight(context)/50,


        child:  oneSize.toLowerCase() == _currentSize  ?

        Container(
//          margin: EdgeInsets.fromLTRB(0, 0,5,5),
          margin: EdgeInsets.fromLTRB(12, 5,12,5),
          width: displayWidth(context)/3.6,
          child:
          RaisedButton(
            color: Color(0xffFFE18E),
//          color: Colors.lightGreenAccent,
            elevation: 2.5,
            shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(
                color: Color(0xffF7F0EC),
                style: BorderStyle.solid,

              ),
              borderRadius: BorderRadius.circular(35.0),
            ),

            child:Container(

//              alignment: Alignment.center,
              child: Text(
                oneSize.toUpperCase(), style:
              TextStyle(
                  color:Color(0xff54463E),

                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins-ExtraBold',
                  fontSize: 12),
              ),
            ),
            onPressed: () {

//              logger.i('onePriceForSize: ',onePriceForSize);

              final blocD = BlocProvider.of<ClientFoodItemDetailsBloc>(context);

              blocD.setNewSizePlusPrice(oneSize);



            },



          ),
        )


            :

        Container(
//          margin: EdgeInsets.fromLTRB(0, 0,5,5),
          margin: EdgeInsets.fromLTRB(12, 5,12,5),
          width: displayWidth(context)/3.6,
          child:
          OutlineButton(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            color: Color(0xffFEE295),
            // clipBehavior:Clip.hardEdge,

            borderSide: BorderSide(
              color: Color(0xff53453D), // 0xff54463E
              style: BorderStyle.solid,
              width: 1.6,
            ),
            shape:RoundedRectangleBorder(


              borderRadius: BorderRadius.circular(35.0),
            ),
            child:Container(

//              alignment: Alignment.center,
              child: Text(
                oneSize.toUpperCase(), style:
              TextStyle(
                  color:Color(0xff54463E),

                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins-ExtraBold',
                  fontSize: 12),
              ),
            ),
            onPressed: () {



              final blocD = BlocProvider.of<ClientFoodItemDetailsBloc>(context);

              blocD.setNewSizePlusPrice(oneSize);

            },
          ),
        )
    );
  }



  Widget oneMultiSelectInDetailsPage (FoodPropertyMultiSelect x,int index){


    String color1 = x.itemTextColor.replaceAll('#', '0xff');

    Color c1 = Color(int.parse(color1));

    String itemName = x.itemName;


    return Container(

//      height:displayHeight(context)/30,
//      width:displayWidth(context)/10,

      child:  x.isSelected == true  ?
      Container(
        width:displayWidth(context)/11,
        height:displayHeight(context)/48,
//        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child:
        RaisedButton(
          color: c1,

          elevation: 2.5,
          shape: RoundedRectangleBorder(
//          borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(
              color:c1,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(35.0),
          ),

          child:Container(

//            alignment: Alignment.center,
            child: Text(
              itemName.toUpperCase(), style:
            TextStyle(
                color:Colors.white,

                fontWeight: FontWeight.bold,
                fontSize: 18),
            ),
          ),
          onPressed: () {

            //    BlocProvider.of<ClientFoodItemDetailsBloc>
            final blocD = BlocProvider.of<ClientFoodItemDetailsBloc>(context);
//            final blocD = BlocProvider2.of(context).getClientFoodItemDetailsBlockObject;
//            final BlocD = BlocProvider.of<ClientFoodItemDetailsBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
            blocD.setMultiSelectOptionForFood(x,index);

          },



        ),
      )


          :

      Container(
        width:displayWidth(context)/11,
        height:displayHeight(context)/48,
//        alignment: Alignment.center,
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: OutlineButton(
//                        color: Color(0xffFEE295),
          clipBehavior: Clip.hardEdge,
          splashColor: c1,
//          splashColor: Color(0xff739DFA),
          highlightElevation: 12,
//          clipBehavior: Clip.hardEdge,
//          highlightElevation: 12,
          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(35.0),
          ),
//          disabledBorderColor: false,
          borderSide: BorderSide(
            color: c1,
            style: BorderStyle.solid,
            width: 3.6,
          ),

          child: Container(
//            alignment: Alignment.center,
            child: Text(

              itemName.toUpperCase(), style:
            TextStyle(
                color: c1,

                fontWeight: FontWeight.bold,
                fontSize: 20),
            ),
          ),
          onPressed: () {

            print('$itemName pressed');
            final blocD = BlocProvider.of<ClientFoodItemDetailsBloc>(context);
//            final blocD = BlocProvider2.of(context).getClientFoodItemDetailsBlockObject;
//            final BlocD = BlocProvider.of<ClientFoodItemDetailsBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
//            blocD.setMultiSelectOptionForFood(x,index);
//            final BlocD = BlocProvider.of<ClientFoodItemDetailsBloc>(context);
//              final locationBloc = BlocProvider.of<>(context);
            blocD.setMultiSelectOptionForFood(x,index);
          },
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

        ),
      ),


      // : Container for 2nd argument of ternary condition ends here.

    );
  }


  //now now
  /* DEAFULT INGREDIENT ITEMS BUILD STARTS HERE.*/
  Widget buildDefaultIngredients(BuildContext context /*,List<NewIngredient> defaltIngs*/){


//    defaultIngredients
    final blocD = BlocProvider.of<ClientFoodItemDetailsBloc>(context);


    return StreamBuilder(
        stream: blocD.getDefaultIngredientItemsStream,
        initialData: blocD.getDefaultIngredients,

        builder: (context, snapshot) {
          if (!snapshot.hasData) {

            print('!snapshot.hasData');


            return Container(
              height: displayHeight(context) / 8,
//          height:190,
              width: displayWidth(context) /1.2,

              color: Color(0xFFffffff),
              alignment: Alignment.center,
              child: Text('No Ingredients, Please Select 1 or more'.toLowerCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Itim-Regular',
                  color: Colors.white,

                ),


              ),
            );
          }

          else {

            print('snapshot.hasData and else statement at FDetailS2');
            List<NewIngredient> selectedIngredients = snapshot.data;

            if( (selectedIngredients.length ==1)&&
                (selectedIngredients[0].ingredientName.toLowerCase()=='none')){

              return Container(
                  height: displayHeight(context) / 8,
//          height:190,
                  width: displayWidth(context) /1.2,

                  color: Color(0xFFffffff),
                  alignment: Alignment.center,

                  // PPPPP

                  child:(
                      Text('No Ingredients, Please Select 1 or more'.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Itim-Regular',
                          color: Colors.white,
                        ),
                      )
                  )
              );
            }
            else if(selectedIngredients.length==0){
              return Container(
                  height: displayHeight(context) / 8,
//          height:190,
                  width: displayWidth(context) /1.2,

                  color: Color(0xffFFFFFF),
                  alignment: Alignment.center,

                  // PPPPP

                  child:(
                      Text('No Ingredients, Please Select 1 or more'.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Itim-Regular',
                          color: Colors.grey,
                        ),
                      )
                  )
              );
            }
            else{

              return Container(
                color: Color(0xFFffffff),
                child: GridView.builder(


                  gridDelegate:
                  new SliverGridDelegateWithMaxCrossAxisExtent(






                    maxCrossAxisExtent: 180,
                    mainAxisSpacing: 0, // Vertical  direction
                    crossAxisSpacing: 5,
                    childAspectRatio: 200 / 280,


                  ),

                  shrinkWrap: true,

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


    final dynamic ingredientImageURL = oneSelected.imageURL == '' ?
    'https://firebasestorage.googleapis.com/v0/b/link-up-b0a24.appspot.com/o/404%2FfoodItem404.jpg?alt=media'
        :
    storageBucketURLPredicate +
        Uri.encodeComponent(oneSelected.imageURL)

        + '?alt=media';




    return Container(
//          height: 190,
      height: displayHeight(context) / 8,
      width: displayWidth(context) * 0.57,
//              color: Colors.yellowAccent,
//                    color: Color(0xff54463E),
      color: Color(0xFFffffff),


      // PPPPP

      child: (
          Container(
//            color: Color.fromRGBO(239, 239, 239, 0),
            color: Colors.white,
            padding: EdgeInsets.symmetric(
//                          horizontal: 10.0, vertical: 22.0),
                horizontal: 4.0, vertical: 15.0),
            child: GestureDetector(
                onLongPress: () {
                  print(
                      'at Long Press: ');
                },
                onLongPressUp: (){

                  print(
                      'at Long Press UP: ');

                  final blocD = BlocProvider.of<ClientFoodItemDetailsBloc>(context);


                  blocD.removeThisDefaultIngredientItem(oneSelected,index);

                },

                child: Column(
                  children: <Widget>[

                    new Container(


                      width: displayWidth(context) /10,
                      height: displayWidth(context) /9,
                      padding:EdgeInsets.symmetric(vertical: 7,horizontal: 0),

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
                        fontSize: 18,
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
          )
      ),
    );
  }






}


//  FoodDetailImage








