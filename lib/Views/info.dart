import 'package:expiry_date_alarm/Views/animations/FadeAnimation.dart';
import 'package:expiry_date_alarm/Views/welcome.dart';
import 'package:expiry_date_alarm/functions/constants.dart';
import 'package:expiry_date_alarm/services/auth.dart';
import 'package:flutter/material.dart';
import '../widgets.dart';
import 'home.dart';

class Expiry extends StatefulWidget {
  @override
  _ExpiryState createState() => _ExpiryState();
}

class _ExpiryState extends State<Expiry> {
  int _currentIndex = 2;

  AuthService authService = new AuthService();

  SignOut() async {
    await authService.signOut().then((value) {
      if (value == null) {
        Constants.saveUserLoggedInSharedPreference(false);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: AppLogo(),
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
      body: (Expiryy()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        unselectedItemColor: blues,
        fixedColor: blues,
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
            SignOut();
          }
        },
      ),
    );
  }
}

class Expiryy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            FadeAnimation(
                1,
                Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: blues,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("What is Expiry Date?",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                )),
            FadeAnimation(
                2,
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black54,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: RichText(
                    text: TextSpan(
                      text:
                          "An expiry date, or expiration date, is the date a producer lists on products to inform consumers of the last day the product will be safe to consume. It also shows the shelf life expectancy of a product or the date on which a product can no longer used.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2,
                      ),
                    ),
                  ),
                )),
            SizedBox(
              width: 8,
              height: 15,
            ),
            FadeAnimation(
                3, Container(child: Image.asset('assets/expiry.png'))),
            FadeAnimation(
                4,
                Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: blues,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Why to know Expiry Date before hand?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                )),
            FadeAnimation(
                4,
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black54,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: RichText(
                    text: TextSpan(
                      text:
                          "The expiration date is the date up to which the food maintains its microbiological and physical stability, and the nutrient content declared on the label. That means it's important to use that food before the expiry date to get the most nutritional value from it.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2,
                      ),
                    ),
                  ),
                )),
            SizedBox(
              width: 8,
              height: 15,
            ),
            FadeAnimation(
                5,
                Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: blues,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Best before vs Use by vs Open Date?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                )),
            FadeAnimation(
                6,
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black54,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: RichText(
                    text: TextSpan(
                      text:
                          "Best before or best by dates appear on a wide range of frozen, dried, tinned and other foods. These dates are only advisory and refer to the quality of the product, in contrast with use by dates, which indicate that the product may no longer be safe to consume after the specified date.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2,
                      ),
                    ),
                  ),
                )),
            SizedBox(
              width: 8,
              height: 10,
            ),
            FadeAnimation(
                7,
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black54,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: RichText(
                    text: TextSpan(
                      text:
                          "Generally, foods that have a use by date written on the packaging must not be eaten after the specified date. This is because such foods usually go bad quickly and may be injurious to health if spoiled. It is also important to follow storage instructions carefully for these foods.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2,
                      ),
                    ),
                  ),
                )),
            SizedBox(
              width: 8,
              height: 10,
            ),
            FadeAnimation(
                8,
                Container(
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black54,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: RichText(
                    text: TextSpan(
                      text:
                          "Open dating is the use of a date stamped on the package of a food product to help determine how long to display the product for sale. This benefits the consumer by ensuring that the product is of best quality when sold.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        wordSpacing: 2,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
