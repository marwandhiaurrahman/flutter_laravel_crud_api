import 'package:flutter/material.dart';
import 'package:flutter_auth/model/product.dart';

// ignore: must_be_immutable
class ShowProduct extends StatefulWidget {
  Product product;
  int index;
  ShowProduct({this.index, this.product});

  @override
  _ProductShowState createState() => _ProductShowState();
}

class _ProductShowState extends State<ShowProduct> {
  @override
  void initState() {
    print(widget.product);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
      ),
      body: Column(children: [
        Text('Deatil : ' + widget.product.detail),
        Text('Created at : ' + widget.product.createdAt),
        Text('Updated at : ' + widget.product.updatedAt),
      ]),
    );
  }
}
