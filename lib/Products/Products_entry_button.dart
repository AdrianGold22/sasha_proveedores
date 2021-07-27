import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'products_model.dart';
import 'products_entry_page.dart';
import 'products.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Products_entry_button extends StatelessWidget {
  const Products_entry_button({Key? key,
    required this.descripcionController,
    required this.fotoBytes,
    required this.fotoController,
    required this.id_categoriaController,
    required this.id_usuarioController,
    required this.nombreController,
    required this.valorController,
    required this.pesoController,
    required this.envioController,

    required this.widget}) : super(key: key);
  final TextEditingController descripcionController;

  final String fotoController;
  final Uint8List? fotoBytes;
  final TextEditingController id_categoriaController;
  final TextEditingController id_usuarioController;
  final TextEditingController nombreController;
  final TextEditingController valorController;
  final TextEditingController pesoController;
  final TextEditingController envioController;

  final ProductsEntryPage widget;
  @override
  Widget build(BuildContext context) {
    final isAddAction = widget.productsAction == ProductsAction.add;
    var firebaseUser =  FirebaseAuth.instance.currentUser;
    var user = firebaseUser!.uid;
    return FloatingActionButton.extended(
        elevation: 2,
        onPressed: () async {
          final products_Entry_Map = Products(
              descripcion: descripcionController.text,
              foto: fotoController,
              id_categoria: id_categoriaController.text,
              id_usuario: id_usuarioController.text,
              nombre: nombreController.text,
              peso: int.parse(pesoController.text),
              tipo_envio: envioController.text,
              valor: int.parse(valorController.text),
              id: '').toMap();
          final id =widget.ProductsEntry.id;

          if(isAddAction && fotoBytes != null){
            FirebaseFirestore.instance.collection('producto').doc(firebaseUser!.uid).collection('producto_usuario').add(products_Entry_Map);
            await FirebaseStorage.instance.ref("/users/$user/$fotoController").putData(fotoBytes!);
          }  else if(fotoBytes == null){
            FirebaseFirestore.instance.collection('producto').doc(firebaseUser!.uid).collection('producto_usuario').doc(id).update(products_Entry_Map);

          } else {
            FirebaseFirestore.instance.collection('producto').doc(firebaseUser!.uid).collection('producto_usuario').doc(id).update(products_Entry_Map);
            await FirebaseStorage.instance.ref("/users/$user/$fotoController").putData(fotoBytes!);
          }

          //Navigator.of(context).popUntil(ModalRoute.withName(ProductsPage.route));
          Navigator.of(context).pushNamed(ProductsPage.route);
        },
        label: Text(isAddAction ? 'Submit' : 'Update'),
        icon: Icon(isAddAction? Icons.book:Icons.bookmark_border),

    );
  }
}
