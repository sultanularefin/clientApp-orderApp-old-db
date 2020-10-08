import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:linkupclient/src/BLoC/bloc_provider.dart';
//import 'package:logger/logger.dart';


//import 'package:linkupclient/src/BLoC/app_bloc.dart';
//import 'package:linkupclient/src/BLoC/bloc_provider2.dart';
//import 'package:linkupclient/src/BLoC/clientFoodItemDetails_bloc.dart';

import 'package:linkupclient/src/BLoC/identity_bloc.dart';


import 'package:linkupclient/src/welcomePage.dart';


import 'package:linkupclient/src/screens/clientHome/clientHome.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}



class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return
      BlocProvider<IdentityBloc>(
        bloc: IdentityBloc(),

        child: MaterialApp(


          // commented for Tablet testing on april 25.
          theme: ThemeData(
       
            primarySwatch: Colors.blue,
         
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,

          home:WelcomePage(),

        ),

      );

 

  }
}
