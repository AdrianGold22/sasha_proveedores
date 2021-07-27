

import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sasha_proveedores/Data/Globals/All.dart' as G;
import 'package:sasha_proveedores/Products/products.dart';
import 'package:sasha_proveedores/auth_service.dart';
import 'package:sasha_proveedores/Views/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sasha_proveedores/Products/products.dart';

Future<bool?> getBoolValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return bool
  bool? boolValue = prefs.getBool('auth');
  return boolValue;
}
class Login extends StatelessWidget {
  static const String route = '/login';
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passswordController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    var sizeScreen  = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 70,
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/img/logo.png",
                  width: 60,
                  height: 60,
                ),
                Text("Inicio",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Text("Unete a Sasha"),
                Text("Requisitos"),
                Text("Registrate"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: VerticalDivider(
                    width: 20.0,
                  ),
                ),
                Center(
                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Container(

                      height: 45.0,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                          child: Text("Comprar ahora",


                          ),
                        ),
                      ),

                    ),
                    onPressed: (){

                    },
                  ),
                ),


              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: sizeScreen.width * 1/2 + 100,
                        height: sizeScreen.height * 3/4 + 50,

                        color: Colors.blue,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Flexible(
                              child: Text("Aumenta las ventas de tu negocio",
                                style: TextStyle(
                                    fontSize: 60,
                                    color: Colors.white
                                ),

                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: sizeScreen.width * 1/2 - 100,
                        height: sizeScreen.height * 3/4 + 50,
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 35.0,
                              ),
                              Text("Inicio de sesion",
                                style: TextStyle(
                                  fontSize: 30.0,

                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),

                              Text("Correo",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontFamily: G.Regular

                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                //validator: (value) => EmailValidator.validate(value) ? null : "Correo invalido",

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  hintText: "Correo electrónico",

                                ),
                              ),

                              SizedBox(
                                height: 20.0,
                              ),

                              Text("Contraseña",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontFamily: G.Regular

                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              TextFormField(
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                controller: _passswordController,
                                //validator: (value) => EmailValidator.validate(value) ? null : "Correo invalido",

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  hintText: "Contraseña",

                                ),
                              ),


                              SizedBox(
                                height: 20.0,
                              ),
                              ElevatedButton(

                                style: ElevatedButton.styleFrom(

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                child: Container(
                                  width: sizeScreen.width * 1/2 + 82  ,
                                  height: 40,
                                  child: Center(
                                    child: Text("Ingresa",
                                      style: TextStyle(
                                          fontSize: 23.0
                                      ),


                                    ),
                                  ),
                                ),
                                onPressed:  () async {



                                 var user = signInWithEmailPassword(context,_emailController.text, _passswordController.text);
                                  user.then((value){
                                    if(value==null)
                                    emailIncorrect(context);
                                  });
                                  print("hola");







                                },
                              ),
                            ],
                          ),
                        ),

                      ),
                    ],
                  ),
                  Container(
                    width: sizeScreen.width ,
                    height: sizeScreen.height * 2/4,


                    color: Colors.pink,
                  ),

                  Container(
                    width: sizeScreen.width ,
                    height: sizeScreen.height * 2/4,

                    color: Colors.grey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text("Forma parte de Sasha e \n incrementa tus ventas.",
                            style: TextStyle(
                                fontSize: 50,
                                color: Colors.white
                            ),

                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(

                          style: ElevatedButton.styleFrom(

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 18.0, left: 18.0),
                            child: Text("Afiliate Ya",


                            ),
                          ),
                          onPressed: () async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            print(prefs.getBool('auth'));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
void emailIncorrect(BuildContext context) {

  showDialog(
    builder: (context) => AlertDialog(
      title: Text('Correo o contraseña incorrecta'),
      content: Text('Pruebe de nuevo'),

    ), context: context,
  );
}