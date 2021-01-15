import 'package:expiry_date_alarm/Views/home.dart';
import 'package:expiry_date_alarm/models/database.dart';
import 'package:flutter/material.dart';
import 'animations/FadeAnimation.dart';
import 'package:random_string/random_string.dart';
import '../widgets.dart';

class CreateProduct extends StatefulWidget {
  @override
  _CreateProductState createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> {
  final _formKey = GlobalKey<FormState>();
  String productImgUrl, productDesc, productTitle;
  DatabaseService databaseService = new DatabaseService();
  bool isLoading = false;
  String productId;
  DateTime pickedDate;

  @override
  void initState() {
    super.initState();
    pickedDate = DateTime.now();
  }

  createProduct() {
    DateTime getDate() {
      DateTime dates = DateTime.now();
    }

    productId = randomAlphaNumeric(16);
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      Map<String, String> productData = {
        "productId": productId,
        "productImgUrl": productImgUrl,
        "productTitle": productTitle,
        "productDesc": productDesc,
        "date":
            "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"
      };

      databaseService.addProductData(productData, productId).then((value) {
        setState(() {
          isLoading = false;
        });
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: Appbar(context),
        body: isLoading
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      FadeAnimation(
                          1,
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? "Enter Product Image Url" : null,
                            decoration: InputDecoration(
                                hintText: "Product Image Url (Optional)"),
                            onChanged: (val) {
                              productImgUrl = val;
                            },
                          )),
                      SizedBox(
                        height: 7,
                      ),
                      FadeAnimation(
                          2,
                          TextFormField(
                            validator: (val) =>
                                val.isEmpty ? "Enter Product Name" : null,
                            decoration:
                                InputDecoration(hintText: "Product Name"),
                            onChanged: (val) {
                              productTitle = val;
                            },
                          )),
                      SizedBox(
                        height: 7,
                      ),
                      FadeAnimation(
                        3,
                        // TextFormField(
                        //   validator: (val) => val.isEmpty
                        //       ? "Enter Expiry date of the Product"
                        //       : null,
                        //   decoration: InputDecoration(
                        //       hintText:
                        //           "Expiry date of the Product (DD/MM/YYYY)"),
                        //   onChanged: (val) {
                        //     productDesc = val;
                        //   },
                        // )
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                    "Expiry Date: ${pickedDate.day}/ ${pickedDate.month}/ ${pickedDate.year}"),
                                trailing: Icon(Icons.keyboard_arrow_down),
                                onTap: _pickDate,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      FadeAnimation(4, button("Add Product", createProduct)),
                      SizedBox(
                        height: 60,
                      )
                    ],
                  ),
                ),
              ));
  }

  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDate: pickedDate,
    );
    if (date != null)
      setState(() {
        pickedDate = date;
        productDesc =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
        final date2 = DateTime.now();
        final diff = pickedDate.difference(date2).inSeconds;
      });
  }
}
