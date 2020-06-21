import 'package:flutter/material.dart';
//import 'package:logger/logger.dart';


//import 'package:linkupclient/src/BLoC/app_bloc.dart';
//import 'package:linkupclient/src/BLoC/bloc_provider2.dart';
//import 'package:linkupclient/src/BLoC/foodItemDetails_bloc.dart';

//import 'package:linkupclient/src/BLoC/identity_bloc.dart';

//import 'package:linkupclient/src/DataLayer/models/FoodItemWithDocID.dart';
//import 'package:linkupclient/src/DataLayer/models/NewIngredient.dart';
//import 'package:linkupclient/src/welcomePage.dart';
//import 'package:linkupclient/src/screens/foodGallery/food_gallery.dart';

import 'package:linkupclient/src/screens/clientHome/clientHome.dart';
//import 'package:google_fonts/google_fonts.dart';

//import 'src/screens/foodGallery/foodgallery2.dart';

//import 'src/welcomePage.dart';


//import 'package:linkupclient/src/
//import 'package:linkupclient/src/BLoC/bloc_provider.dart';

//import 'package:linkupclient/src/BLoC/favorite_bloc.dart';
//import 'package:linkupclient/src/BLoC/foodGallery_bloc.dart';


void main() => runApp(MyApp());




class MyApp extends StatelessWidget {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {


//    final logger = Logger(
//      printer: PrettyPrinter(),
//    );

//    logger.e('reached main\'s build');
//    final textTheme = Theme.of(context).textTheme;

//    FoodItemWithDocID emptyFoodItemWithDocID =new FoodItemWithDocID();
//    List<NewIngredient> _allIngredientState=[];
//    List<NewIngredient> emptyIngs = [];

    /*
      return (
                      BlocProvider2(/*thisAllIngredients2:welcomPageIngredients, */
                          bloc: AppBloc(emptyFoodItemWithDocID, welcomPageIngredients,
                              fromWhichPage:0),
                          /*
                          child: BlocProvider<FoodItemDetailsBloc>(
                              bloc:FoodItemDetailsBloc(emptyFoodItemWithDocID,emptyIngs ,fromWhichPage:0),
                              child: FoodGallery2()

                          )
                          */
                          child: FoodGallery2()
                      )

                  );
    */


    /*
      BlocProvider<IdentityBloc>(
        bloc: IdentityBloc(),

  /*
        bloc: AppBloc(emptyFoodItemWithDocID,/* emptyIngs,*/
            fromWhichPage:-1),

*/

//        child:BlocProvider<FoodGalleryBloc>(
//
//          bloc:FoodGalleryBloc(),
          child:
              */

    return ClientHome();




//      home: FoodGallery(),


  }
}
