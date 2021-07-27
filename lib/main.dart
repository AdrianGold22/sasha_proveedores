import 'package:flutter/material.dart';
import 'package:sasha_proveedores/Products/products.dart';
import 'package:sasha_proveedores/Products/products_entry_page.dart';
import 'package:sasha_proveedores/Products/products_model.dart';
import 'package:sasha_proveedores/Views/home/home_page.dart';
import 'package:sasha_proveedores/Views/login/Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sasha_proveedores/Products/products_main.dart';
void main() {
  runApp(MyApp());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context,snapshot){
          if(snapshot.hasError){
           return Text(snapshot.error.toString());
          }
          if(snapshot.connectionState==ConnectionState.done){
           return MyApp();
          }
          return CircularProgressIndicator();
        }

    );
  }
}


class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.route,
      routes: {
        HomePage.route: (context) => HomePage(),
        Login.route: (context) => Login(),
        Products_Main.route: (context) =>Products_Main(),
      },

    );
  }


}
