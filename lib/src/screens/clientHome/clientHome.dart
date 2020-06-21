// Flutter code sample for AppBar

// This sample shows an [AppBar] with two simple actions. The first action
// opens a [SnackBar], while the second action navigates to a new page.

import 'package:flutter/material.dart';
import 'package:linkupclient/src/utilities/screen_size_reducers.dart';

//void main() => runApp(MyApp());

/// This Widget is the main application widget.
class ClientHome extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatelessWidget(),
    );
  }
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
final SnackBar snackBar = const SnackBar(content: Text('Menu button pressed'));

void openPage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Container(
            margin: EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 0),

            width: displayWidth(context) / 5,
            height: displayHeight(context) / 21,
            child: Image.asset('assets/Path2008.png'),

          ),
        ),
        body: const Center(
          child: Text(
            'This is the next page',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    },
  ));
}

//Container(
//margin: EdgeInsets.symmetric(
//horizontal: 9,
//vertical: 0),
//
//width: displayWidth(context) / 5,
//height: displayHeight(context) / 21,
//child: Image.asset('assets/Path2008.png'),
//
//),

/// This is the stateless widget that the main application instantiates.
class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Jediline',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 35,color: Color(0xff727C8E)),
                      ),
                      Text(
                        'ONLINE ORDERS',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14.42,color: Color(0xff727C8E)),
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
            tooltip: 'Menu || Burger',
            onPressed: () {
              scaffoldKey.currentState.showSnackBar(snackBar);
            },
            color: Color(0xff727C8E),
          ),
//          IconButton(
//            icon: const Icon(Icons.navigate_next),
//            tooltip: 'Next page',
//            onPressed: () {
//              openPage(context);
//            },
//          ),
        ],
      ),
      body: const Center(
        child: Text(
          'This is the home page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}