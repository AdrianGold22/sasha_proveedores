import 'dart:html' as html;
import 'dart:html';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/painting.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'products_model.dart';
import 'Products_entry_button.dart';
import 'package:firebase_storage/firebase_storage.dart';
class ProductsEntryPage extends StatefulWidget {
  const ProductsEntryPage({
    Key? key,
    required this.productsAction,
    required this.ProductsEntry,
  }) : super(key: key);

  const ProductsEntryPage.edit(
  {Key? key, this.productsAction = ProductsAction.edit,required this.ProductsEntry})
      : super(key: key);

  const ProductsEntryPage.add(
      {Key? key, this.productsAction = ProductsAction.add, required this.ProductsEntry})
      : super(key: key);

  const ProductsEntryPage.read(
      {Key? key, this.productsAction = ProductsAction.read, required this.ProductsEntry})
      : super(key: key);

  final Products ProductsEntry;

  final ProductsAction productsAction;
  @override
  _ProductsEntryPageState createState() => _ProductsEntryPageState();
}

class _ProductsEntryPageState extends State<ProductsEntryPage> {
  int test= 1;

  FilePickerResult? image;
  PlatformFile? selectImages;
  //late BlobImage blobImage;
  //late final imagen;
  late TextEditingController descripcionController;
  late TextEditingController titleController;
  late TextEditingController bodyTextController;
  late String fotoController;
  Uint8List? fotoBytes;
  late TextEditingController id_categoriaController;
  late TextEditingController id_usuarioController;
  late TextEditingController nombreController;
  late TextEditingController valorController;
  late TextEditingController pesoController;
  late TextEditingController envioController;

  late bool isReadOnly;
  @override
  void initState() {
    //_emoji = widget.ProductsEntry?.emoji ?? '';
    descripcionController =
        TextEditingController(text: widget.ProductsEntry.descripcion ?? '');
    fotoController =
        widget.ProductsEntry.foto ?? '';

    id_categoriaController =
        TextEditingController(text: widget.ProductsEntry.id_categoria ?? '');
    id_usuarioController =
        TextEditingController(text: widget.ProductsEntry.id_usuario ?? '');
    nombreController =
        TextEditingController(text: widget.ProductsEntry.nombre ?? '');
    valorController =
        TextEditingController(text: widget.ProductsEntry.valor.toString() ?? '');
    pesoController =
        TextEditingController(text: widget.ProductsEntry.peso.toString() ?? '');
    envioController =
        TextEditingController(text: widget.ProductsEntry.tipo_envio ?? '');

    isReadOnly = widget.productsAction == ProductsAction.read;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var firebaseUser =  FirebaseAuth.instance.currentUser;
    String user = firebaseUser!.uid;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 3 / 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50),
                // Title
                TextField(
                  readOnly: isReadOnly,
                  controller: nombreController,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Colors.black87),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: isReadOnly ? '' : 'Nombre',
                  ),
                ),
                // Body text
                TextField(
                  readOnly: isReadOnly,
                  controller: descripcionController,
                  maxLines: null,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black87, height: 1.7),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Descripcion",
                  ),
                ),
                TextField(
                  readOnly: isReadOnly,
                  controller: valorController,
                  maxLines: null,
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.black87, height: 1.7),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Valor",
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                ),




                  SizedBox(
                    height: 30,
                    child:  Text(fotoController)//Image.file(html.File(fileBits, selectImages!.name) ),
                  ),
                if(isReadOnly==false)
                IconButton(

                    color: Colors.grey ,
                    padding: EdgeInsets.all(10),
                    icon: Icon(Icons.camera_alt),
                  onPressed: () async {
                      image = await FilePicker.platform.pickFiles();
                      //var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
                      setState(() {
                        selectImages = image!.files.first;
                        fotoController = selectImages!.name;
                        fotoBytes = selectImages!.bytes!;
                        //blobImage = new BlobImage(selectImages, name: selectImages!.name);
                        //imagen = NetworkImage(blobImage.url);
                      });
                  },
                ),



                SizedBox(height: 100)
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isReadOnly
          ? SizedBox()
          : Products_entry_button(

        widget: widget,

        id_categoriaController: id_categoriaController,
        envioController: envioController,
        descripcionController: descripcionController,
        nombreController: nombreController,
        fotoController: fotoController,
        fotoBytes: fotoBytes,
        valorController: valorController,
        id_usuarioController: id_usuarioController,
        pesoController: pesoController,
      ),
    );
  }

  @override
  void dispose() {
    //_emoji = null;
    titleController.dispose();
    bodyTextController.dispose();
    super.dispose();
  }
}

enum ProductsAction { edit, add, read }
