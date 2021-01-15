import 'package:expiry_date_alarm/models/database.dart';
import 'package:expiry_date_alarm/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ProductInfo extends StatefulWidget {
  final String productImageUrl,
      productTitle,
      productId,
      productDescription,
      productDate;
  ProductInfo(this.productId, this.productImageUrl, this.productTitle,
      this.productDescription, this.productDate);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  FlutterLocalNotificationsPlugin fltrNotification;
  DatabaseService databaseService = new DatabaseService();
  DateTime date2;
  bool timer_on = true;
  // final hrs = widget.productDescription.toString().split("/")[0];

  @override
  void initState() {
    // TODO: implement initState
    date2 = DateTime.now();
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
    //     UILocalNotificationDateInterpretation.absoluteTime,
    //     androidAllowWhileIdle: true);
  }

  @override
  Widget build(BuildContext context) {
    final day1 = int.parse(widget.productDescription.split("/")[0]);
    final month1 = int.parse(widget.productDescription.split("/")[1]);
    final year1 = int.parse(widget.productDescription.split("/")[2]);
    final birthday = DateTime(year1, month1, day1);
    // final year2 = int.parse(widget.productDate.split("/")[0]);
    // final month2 = int.parse(widget.productDate.split("/")[1]);
    // final day2 = int.parse(widget.productDate.split("/")[2]);
    // final date2 = DateTime(year2, month2, day2);
    // var date2;
    // setState(() {
    //   date2 = DateTime.now();
    // });
    final diff = birthday.difference(date2).inSeconds;
    return Scaffold(
      appBar: Appbar(context),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            margin: EdgeInsets.symmetric(vertical: 7),
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.productImageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.productTitle,
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  CountdownTimer(
                    endTime: DateTime.now().millisecondsSinceEpoch +
                        diff * 1000 -
                        86400000,
                    daysSymbol: Icon(Icons.today),
                    widgetBuilder: (_, CurrentRemainingTime time) {
                      try {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Expires on ${widget.productDescription}",
                                style: TextStyle(
                                    fontSize: 23,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w500),
                              ),
                              // Text(
                              //   "$date2  $diff",
                              //   style: TextStyle(
                              //       fontSize: 23,
                              //       color: Colors.black54,
                              //       fontWeight: FontWeight.w500),
                              // ),
                              SizedBox(
                                height: 60,
                              ),
                              Text(
                                  'days:  ${time.days} , hours:  ${time.hours} , min:  ${time.min} , sec:  ${time.sec} ')
                            ]);
                      } catch (e) {
                        return Text(
                          "Product Expired",
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                        );
                      }
                    },
                    onEnd: () {
                      _showNotification(
                          widget.productTitle, widget.productDescription);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FloatingActionButton(
          backgroundColor: blues,
          child: Icon(Icons.delete),
          onPressed: () {
            databaseService.deleteProduct(widget.productId);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
