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

class Products_Main extends StatelessWidget {
  static const String route = '/products_main';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var firebaseUser =  FirebaseAuth.instance.currentUser;
    final ProductsCollection = FirebaseFirestore.instance.collection('producto').doc(firebaseUser!.uid).collection('producto_usuario');
    final ProducstStream =ProductsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Products.fromDoc(doc)).toList();
    });
    Products prod = new Products(descripcion: '', foto: '', id_categoria: '', id_usuario: '', nombre: '', peso: 0, tipo_envio: '', valor: 0, id: '');

    return StreamProvider<List<Products>>(
      create: (_) => ProducstStream,
      initialData: [],
      child: MaterialApp(
        title: 'Productos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch:Colors.blue,
          accentColor: Colors.amber,
        ),
        initialRoute: ProductsPage.route,
        routes: {

          ProductsPage.route: (context) =>ProductsPage(title: '',),
          ProductsPage.route+'/nueva_entrada': (context) =>ProductsEntryPage.add(ProductsEntry: prod,)
        },

      ),

    );
  }


}
