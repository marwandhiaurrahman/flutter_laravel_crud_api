import 'package:flutter/material.dart';
import 'package:flutter_auth/controller/api_controller.dart';
import 'package:flutter_auth/main.dart';
import 'package:flutter_auth/model/product.dart';
import 'package:flutter_auth/view/product/add.dart';
import 'package:flutter_auth/view/product/edit.dart';
import 'package:flutter_auth/view/product/show.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  ApiController apiController = ApiController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          actions: [
            IconButton(
                onPressed: () {
                  logoutUser();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MyApp()),
                      (Route<dynamic> route) => false);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _addProduct();
          },
        ),
        body: new FutureBuilder<List<Product>>(
          future: apiController.listProduct(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                    "Something wrong with message: ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<Product> products = snapshot.data;
              return ItemList(
                list: products,
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _addProduct() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddProduct()));
  }
}

// ignore: must_be_immutable
class ItemList extends StatelessWidget {
  ApiController apiController = ApiController();
  List<Product> list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    void _showProduct(int i, Product product) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ShowProduct(
                    index: i,
                    product: product,
                  )));
    }

    void _editProduct(int i, Product product) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditProduct(
                    index: i,
                    product: product,
                  )));
    }

    void _deteleProduct(int i) {
      apiController.deleteData(i);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
          (Route<dynamic> route) => false);
    }

    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return Container(
            child: Card(
              child: ListTile(
                onTap: () {
                  _showProduct(list[i].id, list[i]);
                },
                title: Text(list[i].name),
                leading: Icon(Icons.apps),
                subtitle: Text(list[i].detail),
                trailing: Wrap(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        _editProduct(list[i].id, list[i]);
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        _deteleProduct(list[i].id);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
