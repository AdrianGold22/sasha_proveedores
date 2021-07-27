import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sasha_proveedores/Products/products_model.dart';
import 'top_bar.dart';
import 'products_card.dart';
class ProductsPage extends StatefulWidget {

  static const String route = '/products';

  final String title;

  ProductsPage({Key? key,required this.title}) : super(key: key);
  @override

  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  @override
  Widget build(BuildContext context) {
    final ProductsEntries =Provider.of<List<Products>>(context);
    return Scaffold(
     appBar: AppBar(
       bottom: PreferredSize(
         preferredSize: Size.fromHeight(94.0),
         child: TopBar('Productos'),
       ),
       elevation: 0,
     ),
     body: Center(
       child: SizedBox(
         width: MediaQuery.of(context).size.width*3/5,
         child: ListView(
           children: <Widget>[
             SizedBox(height: 40),
             if(ProductsEntries != null)
               for (var ProductsData in ProductsEntries)
                ProductsCard(productsEntry: ProductsData),
             if(ProductsEntries == null)
               Center(child: CircularProgressIndicator()),


           ],

         ),

       )


     ) ,
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        elevation: 1.5,
        onPressed: () => Navigator.of(context).pushNamed('/products/nueva_entrada'),
        tooltip: 'Add To Do',
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

