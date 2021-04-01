import 'package:flutter/material.dart';
import 'package:flutter_auth/controller/api_controller.dart';
import 'package:flutter_auth/view/dashborad_view.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  ApiController apiController = ApiController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.only(
              top: 62, left: 12.0, right: 12.0, bottom: 12.0),
          children: <Widget>[
            Container(
              child: TextField(
                controller: _nameController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Product Name',
                  icon: Icon(Icons.badge),
                ),
              ),
            ),
            Container(
              child: TextField(
                controller: _detailController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Detail',
                  hintText: 'Product Detail',
                  icon: Icon(Icons.info),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 44.0),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  apiController.addProduct(_nameController.text.trim(),
                      _detailController.text.trim());
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen()),
                      (Route<dynamic> route) => false);
                },
                child: Text(
                  'Add',
                  style: TextStyle(
                      color: Colors.white, backgroundColor: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
