import 'package:expiry_date_alarm/Views/productInfo.dart';
import 'package:expiry_date_alarm/models/database.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expiry_date_alarm/Views/info.dart';
import 'package:expiry_date_alarm/Views/welcome.dart';
import 'package:expiry_date_alarm/functions/constants.dart';
import 'package:expiry_date_alarm/services/auth.dart';
import 'animations/FadeAnimation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import '../widgets.dart';

import 'create_product.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream productStream;
  DatabaseService databaseService = new DatabaseService();
  AuthService authService = new AuthService();
  final TextEditingController _controller = new TextEditingController();
  bool _isSearching;
  int _currentIndex = 0;
  String _searchText = "";

  Widget productList(String query) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            StreamBuilder(
              stream: productStream,
              builder: (context, snapshot) {
                return snapshot.data == null
                    ? Container()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          if (snapshot
                              .data.documents[index].data['productTitle']
                              .toString()
                              .toLowerCase()
                              .contains(query)) {
                            return Dismissible(
                              key: new Key(snapshot
                                  .data.documents[index].data["productId"]),
                              child: FadeAnimation(
                                  index.toDouble(),
                                  ProductTile(
                                    noOfQuestions:
                                        snapshot.data.documents.length,
                                    imageUrl: snapshot.data.documents[index]
                                        .data['productImgUrl'],
                                    title: snapshot.data.documents[index]
                                        .data['productTitle'],
                                    description: snapshot.data.documents[index]
                                        .data['productDesc'],
                                    id: snapshot.data.documents[index]
                                        .data["productId"],
                                    date: snapshot
                                        .data.documents[index].data["date"],
                                  )),
                              onDismissed: (direction) {
                                databaseService.deleteProduct(snapshot
                                    .data.documents[index].data["productId"]);
                              },
                            );
                          } else {
                            return Container(
                              child: Center(
                                child: Text(
                                  'no match',
                                  style: TextStyle(fontSize: 4.0),
                                ),
                              ),
                            );
                          }
                        });
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    databaseService.getProductData().then((value) {
      productStream = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: _currentIndex == 1
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: _controller,
                  cursorColor: blues,
                  style: TextStyle(color: blues),
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      // enabledBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.grey[400])),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      fillColor: blues,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black38,
                      ),
                      hintText: "Search...",
                      hintStyle: TextStyle(color: blues)),
                  onChanged: (val) {
                    setState(() {
                      _searchText = val;
                    });
                  },
                ),
              )
            : AppLogo(),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: blues,
        fixedColor: blues,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text("Search"),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              title: Text("Info"),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Logout"),
              backgroundColor: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          }
          if (index == 1) {}
          if (index == 2) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Expiry()));
          }
          if (index == 3) {
            SignOut(context);
          }
        },
      ),
      body: productList(_searchText),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blues,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateProduct()));
        },
      ),
    );
  }
}

class ProductTile extends StatefulWidget {
  final String imageUrl, title, id, description, date;
  final int noOfQuestions;

  ProductTile(
      {@required this.title,
      @required this.imageUrl,
      @required this.description,
      @required this.id,
      @required this.noOfQuestions,
      @required this.date});

  @override
  _ProductTileState createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  FlutterLocalNotificationsPlugin fltrNotification;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _showNotification(widget.title, widget.description);
      },
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductInfo(widget.id, widget.imageUrl,
                    widget.title, widget.description, widget.date)));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        margin: EdgeInsets.symmetric(vertical: 7),
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: [
              Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                color: Colors.black26,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.description,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // Add code after super
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('reminder2');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
  }

  Future _showNotification(String name, String date) async {
    tz.initializeTimeZones();
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Desi programmer", "This is my channel",
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    await fltrNotification.show(
        0, name, "Expires on $date", generalNotificationDetails,
        payload: "Task");

    // await fltrNotification.zonedSchedule(
    //     0,
    //     name,
    //     "Expires on $date",
    //     tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
    //     generalNotificationDetails,
    //     uiLocalNotificationDateInterpretation:
    //         UILocalNotificationDateInterpretation.absoluteTime,
    //     androidAllowWhileIdle: true);
  }
}
