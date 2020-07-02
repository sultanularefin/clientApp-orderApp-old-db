import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


//LOCAL RESOURCES
import 'package:linkupclient/src/utilities/screen_size_reducers.dart';

class ClientFoodDetailImage extends StatelessWidget {



  final String imageURLBig;
  final String foodItemName;
  ClientFoodDetailImage(this.imageURLBig,this.foodItemName);

  @override
  Widget build(BuildContext context) {

    return
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
          lightSource: LightSource.top,
          boxShape: NeumorphicBoxShape.circle(),
          color: Colors.white,
          shadowDarkColor: Colors.orange,

//          boxShape:NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(15)),
        ),

        child:
        Container(
//              alignment: Alignment.centerLeft,
          child: Hero(
            tag: foodItemName,
            child:
            ClipOval(
              child:CachedNetworkImage(
                width: displayWidth(context)/2.1,
                height:displayWidth(context)/1.7,
                imageUrl: imageURLBig,
//                    fit: BoxFit.scaleDown,cover,scaleDown,fill
//                    fit: BoxFit.fill,
                fit:BoxFit.cover,
//
                placeholder: (context, url) => new CircularProgressIndicator(),
              ),
            ),
          ),
        ),


      );
  }
}

