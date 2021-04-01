import 'package:flutter/material.dart';
import 'package:flutter_auth/controller/api_controller.dart';
import 'package:flutter_auth/model/product.dart';
import 'package:flutter_auth/view/dashborad_view.dart';

// ignore: must_be_immutable
class EditProduct extends StatefulWidget {
  Product product;
  int index;
  EditProduct({this.index, this.product});
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<EditProduct> {
  ApiController apiController = ApiController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _detailController = TextEditingController();

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.product.name);
    _detailController = TextEditingController(text: widget.product.detail);
    super.initState();
  }

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
                  apiController.updateProduct(
                      widget.index,
                      _nameController.text.trim(),
                      _detailController.text.trim());
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen()),
                      (Route<dynamic> route) => false);
                },
                child: Text(
                  'Update',
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
