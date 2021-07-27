import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'products_model.dart';
import 'products_entry_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
class PopUpMenu extends StatelessWidget {
  const PopUpMenu({
    Key? key,
    required this.productsEntry,
  }) : super(key: key);
  final Products productsEntry;
  @override
  Widget build(BuildContext context) {
    //var firebaseUser =  FirebaseAuth.instance.currentUser;
    //var user = firebaseUser!.uid;
    //var foto = productsEntry.foto;
    return PopupMenuButton<Action>(
      elevation: 2,
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: Action.edit,
            child: Text('Editar'),
          ),
          PopupMenuItem(
            value: Action.delete,
            child: Text('Borrar'),
          ),
        ];
      },
      onSelected: (action) {
        switch (action) {
          case Action.delete:

              //TODO: 5. Create delete method with the doc id
              
              _showDeleteDialog(context, productsEntry);
              //Navigator.of(context).pop();

            break;
          case Action.edit:
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProductsEntryPage.edit(
                    ProductsEntry: productsEntry,
                  );
                },
              ),
            );
            break;

          default:
        }
      },
    );
  }
}

enum Action { delete, edit, none }

void delete(Products p){
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  var user = firebaseUser!.uid;
  var foto = p.foto;
  FirebaseFirestore.instance
      .collection('producto')
      .doc(firebaseUser!.uid)
      .collection('producto_usuario')
      .doc(p.id)
      .delete();
  var delete = FirebaseStorage.instance.ref().child("gs://pestdb-42d5f.appspot.com/users/$user/$foto");
  delete.delete();
}
void _showDeleteDialog(BuildContext context,Products p) async{
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  var user = firebaseUser!.uid;
  var foto = p.foto;
  showDialog(
    builder: (context) => AlertDialog(
      title: Text('¿Estas seguro que quieres borrarlo?'),
      content: Text('El producto sera eliminado para siempre.'),
      actions: <Widget>[
        // ignore: deprecated_member_use
        FlatButton(
          color: Colors.blue,
          onPressed: (){
            FirebaseFirestore.instance
                .collection('producto')
                .doc(firebaseUser!.uid)
                .collection('producto_usuario')
                .doc(p.id)
                .delete();
            var delete = FirebaseStorage.instance.ref().child("gs://pestdb-42d5f.appspot.com/users/$user/$foto");
            delete.delete();
            Navigator.of(context).pop();
          },
          child: Text('Eliminar'),
        )
      ],
    ), context: context,
  );
}
