import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'products_model.dart';
import 'products_entry_page.dart';
import 'pop_up_menu.dart';
import 'package:firebase_storage/firebase_storage.dart';
class ProductsCard extends StatelessWidget {
  const ProductsCard({Key? key, required this.productsEntry}) : super(key: key);
  final Products productsEntry;

  @override//snapshot.connectionState==ConnectionState.waiting
  Widget build(BuildContext context) {
    //final ref = FirebaseStorage.instance.ref().child(productsEntry.foto);
    //var url = await ref.getDownloadURL();
    return StreamBuilder<String>(
      stream: getImages(productsEntry).asStream(),
      builder: (context,snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 35.0),
          child: SizedBox(
            height: 250,
            child: Card(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightGreen.shade100,
                      ),
                      child: Center(

                        child: Image.network(snapshot.data.toString()),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 30, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    productsEntry.nombre,
                                    style: Theme.of(context).textTheme.headline5,
                                  ),
                                  PopUpMenu(productsEntry: productsEntry)
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Text(
                                  productsEntry.descripcion,
                                  maxLines: 3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(height: 1.75),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Text(
                                  productsEntry.valor.toString(),
                                  maxLines: 3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(height: 1.75),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Text(
                                  productsEntry.tipo_envio,
                                  maxLines: 3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(height: 1.75),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: Text(
                                  productsEntry.id_categoria,
                                  maxLines: 3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2!
                                      .copyWith(height: 1.75),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Divider(thickness: 1),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 40,
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return ProductsEntryPage.read(
                                      ProductsEntry: productsEntry,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Leer mas',
                              style: TextStyle(
                                color: Colors.lightBlue.shade300,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

            ),


          ),

      );
      },
    );

  }
}
Future<String> getImages(Products p) async{
  var firebaseUser =  FirebaseAuth.instance.currentUser;
  var user = firebaseUser!.uid;
  var foto = p.foto;
  final ref = FirebaseStorage.instance.ref().child("/users/$user/$foto");
  var url = ref.getDownloadURL();
  return url;
}
