import 'package:astrollo_app/screens/create_new/create_chart.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:async';

final routeObserver = RouteObserver<PageRoute>();
final duration = const Duration(milliseconds: 200);

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with RouteAware {
  // parallax variables
  double rateZero = 0;
  double rateOne = 0;
  double rateTwo = 0;
  double rateThree = 0;
  double rateFour = 0;
  double rateFive = 0;
  double rateSix = 0;
  double rateSeven = 0;
  double rateEight = 90;

  String asset;
  double top;

  // fab transition variables
  GlobalKey _fabKey = GlobalKey();
  bool _fabVisible = true;

  // fab overrides
  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  didPopNext() {
    Timer(duration, () {
      setState(() {
        _fabVisible = true;
      });
    });
  }

  /*
            #-#-#-#-#-#-#   B U I L D   #-#-#-#-#-#-#
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: NotificationListener(
        onNotification: (v) {
          if (v is ScrollUpdateNotification) {
            //only if scroll update notification is triggered
            setState(() {
              //rateEight -= v.scrollDelta / 1;
              rateSeven -= v.scrollDelta / 1;
              rateSix -= v.scrollDelta / 1.25;
              rateFive -= v.scrollDelta / 1.5;
              rateFour -= v.scrollDelta / 2;
              rateThree -= v.scrollDelta / 3;
              rateTwo -= v.scrollDelta / 6;
              rateOne -= v.scrollDelta / 7;
              rateZero -= v.scrollDelta / 8;
            });
            return;
          }
          return;
        },
        child: Stack(
          children: <Widget>[
            ParallaxWidget(top: rateZero, asset: "nightSky2-0"),
            ParallaxWidget(top: rateOne, asset: "nightSky2-1"),
            ParallaxWidget(top: rateTwo, asset: "nightSky2-2"),
            ParallaxWidget(top: rateThree, asset: "nightSky2-3"),
            ParallaxWidget(top: rateFour, asset: "nightSky2-4"),
            ParallaxWidget(top: rateFive, asset: "nightSky2-5"),
            ParallaxWidget(top: rateSix, asset: "nightSky2-6"),
            ParallaxWidget(top: rateSeven, asset: "nightSky2-7"),
            //ParallaxWidget(top: rateEight, asset: "parallax8"),
            NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowGlow();
                  return;
                },
                child: ListView(
                  children: <Widget>[
                    Center(
                      heightFactor: 1.15,
                      child: Container(
                        height: 450,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Text("ASTROLLO",
                                style: TextStyle(
                                    letterSpacing: 10,
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontFamily: "Cagile")),
                            Text("Welcome back, Aries",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: "FiraSans")),
                          ],
                        ),
                      ),
                    ), // * ---------- ^Transparent container w Astrollo text ---------
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          makeFriend('Your Chart', "earth",
                              "Example Birthday - 03:16 AM"),
                          Container(
                            height: 30,
                          ),
                          Divider(
                            color: Colors.grey[600],
                            thickness: 0.75,
                            indent: 100,
                            endIndent: 100,
                          ),
                          Container(
                            height: 30,
                          ),
                          makeFriend('Angela Davis', "air",
                              "January 26, 1944 - 12:30 PM"),
                          makeFriend('Beyonce Knowles-Carter', "earth",
                              "September 4, 1981 - Unknown Time"),
                          makeFriend('Chaz Bear', "water",
                              "November 7, 1986 - Unknown Time"),
                          makeFriend('Diana Ross', "fire",
                              "March 26, 1944 - Unknown Time"),

                          //makeFriend('Martin Luther King Jr.', "earth", "January 15, 1929 - Unknown Time"),
                          //makeFriend('Ruth Ginsburg', "water", "March 15, 1933 - Unknown Time"),

                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
      floatingActionButton: Visibility(
          visible: _fabVisible, child: _buildFAB(context, key: _fabKey)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          color: Color(0xff130713),
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(icon: Icon(Icons.add), onPressed: null)
            ],
          )),
    );
  } // build

  // fab widget for create chart
  Widget _buildFAB(context, {key}) => FloatingActionButton.extended(
    elevation: 0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))),
    backgroundColor: Color(0xff3f333f),
    key: key,
    icon: const Icon(Icons.add),
    label: const Text('Create new chart'),
    onPressed: () => _fabTap(context),
  );

  _fabTap(BuildContext context) {
    setState(() => _fabVisible = false);

    final RenderBox fabRenderBox = _fabKey.currentContext.findRenderObject();
    final fabSize = fabRenderBox.size;
    final fabOffset = fabRenderBox.localToGlobal(Offset.zero);

    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: duration,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secAnimation) =>
          CreateChartPage(),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secAnimation, Widget child) =>
          _buildTransition(child, animation, fabSize, fabOffset),
    ));
  } // _fabTap

  Widget _buildTransition(
      Widget page,
      Animation<double> animation,
      Size fabSize,
      Offset fabOffset,
      ) {
    if (animation.value == 1) return page;

    final borderTween = BorderRadiusTween(
      begin: BorderRadius.all(Radius.circular(10.0)),
      end: BorderRadius.all(Radius.circular(10.0)),
    );
    final sizeTween = SizeTween(
      begin: fabSize,
      end: MediaQuery.of(context).size,
    );
    final offsetTween = Tween<Offset>(
      begin: fabOffset,
      end: Offset.zero,
    );
    final easeInAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInSine,
    );
    final easeOutAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutSine,
    );

    final offset = offsetTween.evaluate(animation);
    final radius = borderTween.evaluate(easeInAnimation);
    final size = sizeTween.evaluate(easeInAnimation);

    final transitionFab = Opacity(
      opacity: 1 - easeOutAnimation.value,
      child: _buildFAB(context),
    );

    Widget positionedClippedChild(Widget child) => Positioned(
        width: size.width,
        height: size.height,
        left: offset.dx,
        top: offset.dy,
        child: ClipRRect(
          borderRadius: radius,
          child: child,
        ));

    return Stack(
      children: [
        positionedClippedChild(page),
        positionedClippedChild(transitionFab),
      ],
    );
  } // _buildTransition

  GestureDetector makeFriend(String name, String elementIn, String birth) {
    // for friend container
    String frdBio;
    String frdSMR;
    frdSMR = 'c';
    Color element;

    // element color switch case
    switch (elementIn) {
      case "earth":
        {
          element = Colors.green;
        }
        break;
      case "water":
        {
          element = Colors.blue;
        }
        break;
      case "air":
        {
          element = Colors.amber;
        }
        break;
      case "fire":
        {
          element = Colors.red;
        }
        break;
    } // swtich

    final friendCardContent = new Container(
        margin: new EdgeInsets.fromLTRB(25.0, 20.0, 16.0, 16.0),
        constraints: new BoxConstraints.expand(),
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // top portion
              new Container(height: 4.0),
              new Text(name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Cagile',
                    //fontWeight: FontWeight.w500
                  )),
              new Container(height: 3.0),
              new Text(birth,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'FiraSans',
                      color: Colors.grey)),
              // separator
              new Container(
                margin:
                new EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                height: 3.0,
                width: 75.0,
                color: element,
              ),
              // bottom portion
//              new Row(
//                  children: <Widget>[
//                    new Text(frdSMR, style: TextStyle(fontSize: 15.0, fontFamily: 'Astro')),
//                  ]
//              )
            ]));

    final friendCard = new Container(
      child: friendCardContent,
      height: 124.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(5.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black26,
            blurRadius: 7.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    ); // friendCard

    return GestureDetector(
      onTap: () {

      },
      child: Container(
        height: 130.0,
        margin: const EdgeInsets.only(
          top: 25.0,
          bottom: 15.0,
          right: 45.0,
          left: 15.0,
        ),
        child: new Stack(
          children: <Widget>[
            friendCard,
          ],
        ),
      ),
    );
  } // makeFriend(index)

} // _MyHomePage class

class ParallaxWidget extends StatelessWidget {
  const ParallaxWidget({
    Key key,
    @required this.top,
    @required this.asset,
  }) : super(key: key);

  final double top;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: -30,
      top: top,
      child: Container(
        height: 550,
        width: 450,
        child: Image.asset("lib/assets/parallax/$asset.png"),
      ),
    );
  }
}
