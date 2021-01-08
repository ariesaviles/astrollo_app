import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:astrollo_app/configs/size_config.dart';

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 10),
                  //height: SizeConfig.blockSizeVertical * 10,
                  child: Text("Aries Aviles",
                    style: TextStyle(fontFamily: "Cagile", fontSize: 50, decoration: TextDecoration.none, color: Colors.black),),
                  color: Colors.white,
                ),  // ----------------------------- Name and header
                Container(height: SizeConfig.blockSizeVertical * 5,),
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[

                      Opacity(
                        opacity: 0.35,
                        child: Center(
                          child: Image.asset("lib/src/media/images/blankChart.png",
                              height: SizeConfig.blockSizeHorizontal * 80),
                        ),
                      ),
                     Column( // ------- button
                          children: <Widget> [
                            Text("Feature in progress",
                                style: TextStyle(fontFamily: "FireSans", fontSize: 25, decoration: TextDecoration.none, color: Colors.grey[700])
                            ),
                            Container(height: SizeConfig.blockSizeVertical * 2),
                            GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                width: double.infinity,
                                height: SizeConfig.blockSizeVertical * 8,
                                margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 20),
                                decoration: BoxDecoration(
                                  color: Color(0xff3f333f),
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: Center(
                                  child: Text(
                                    "Turn on Notifications",
                                    style: TextStyle(
                                      fontFamily: "FireSans",
                                      decoration: TextDecoration.none,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                            ),
                          )
                        ]
                      ),
                    ],
                  ),
                ), // ---------------------------- Chart image wip
                Container(height: SizeConfig.blockSizeVertical * 5,),
//            Container( //
//              height: SizeConfig.screenHeight - 100,
//              margin: EdgeInsets.all(20),
//              //padding: EdgeInsets.only(top: 10),
//              decoration: BoxDecoration(
//                color: Colors.white,
//                borderRadius: BorderRadius.all(Radius.circular(20)),
//                border: Border.all(color: Colors.black,),
//              ),
//            ), // ---------------------------- planet placements
//            new Container(
//                child: TabBar(
//                  controller: _tabController,
//                  labelColor: Colors.green,
//                  unselectedLabelColor: Colors.black,
//                  tabs: [
//                    Tab(text: 'Planets'),
//                    Tab(text: 'Houses'),
//                  ],
//                ),
//            ),
//            Container(
//              height: 400, //height of TabBarView
//              decoration: BoxDecoration(
//                border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
//              ),
//              child: TabBarView(
//                controller: _tabController,
//                children: <Widget>[
//                Container(
//                      child: Center(
//                        child: Text('Planets', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                      ),
//                    ),
//                Container(
//                      child: Center(
//                        child: Text('Houses', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                      ),
//                ),
//                ]
//              )
//            )
                SizedBox(
                  height: 40,
                  child: TabBar(
                    tabs: [
                      Tab(
                        text: 'Planets',
                      ),
                      Tab(
                        text: 'Houses',
                      )
                    ],
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                ),


                Container(
                  height: SizeConfig.screenHeight - 70,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // first tab bar view widget
                      Container(
                        color: Colors.red,
                        height: SizeConfig.screenHeight - 200,
                        child: Center(
                          child: Text(
                            'Planets',
                          ),
                        ),
                      ),

                      // second tab bar viiew widget
                      Container(
                        color: Colors.pink,
                        height: SizeConfig.screenHeight - 200,
                        child: Center(
                          child: Text(
                            'Houses',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


              ]
            ),
          )
        ),
    );
  }
}
