import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sasha_proveedores/Views/login/Login.dart';

import 'package:sasha_proveedores/Data/Globals/All.dart' as G;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:sasha_proveedores/auth_service.dart';

class HomePage extends StatelessWidget {
  static const String route = '/';
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passswordController =TextEditingController();
  final TextEditingController _numberController =TextEditingController();
  final TextEditingController _nameController =TextEditingController();

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
                          child: Text("Iniciar Sesion",


                          ),
                        ),
                      ),

                    ),
                    onPressed: (){
                      Navigator.of(context).pushNamed(Login.route);
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
                              Text("Crea tu cuenta es gratis",
                                style: TextStyle(
                                  fontSize: 30.0,

                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Text("Nombre completo",
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
                                keyboardType: TextInputType.text,
                                controller: _nameController,
                                //validator: (value) => EmailValidator.validate(value) ? null : "Correo invalido",

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  hintText: "Nombre completo",

                                ),
                              ),
                              SizedBox(
                                height: 20.0,
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
                              Text("Telefono",
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
                                keyboardType: TextInputType.number,
                                controller: _numberController,
                                //validator: (value) => EmailValidator.validate(value) ? null : "Correo invalido",

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  hintText: "Telefono",

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
                                height: 7.0,
                              ),
                              Text("Al continuar, acepto que Sasha stores entre en contacto conmigo por teléfono, e-mail o WhatsApp (incluyendo mensajes automáticos con fines comerciales)."),

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
                                    child: Text("Afiliate Ya",
                                      style: TextStyle(
                                        fontSize: 23.0
                                      ),


                                    ),
                                  ),
                                ),
                                onPressed: (){

                                  //registerWithEmailPassword(_emailController.text, _passswordController.text);
                                  ingresar_proveedor(_emailController.text, _nameController.text,int.parse(_numberController.text));
                                  Navigator.of(context).pushNamed(Login.route);
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
                          onPressed: (){

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

void ingresar_proveedor(String correo,String nombre,int tel){
  final firestoreInstance = FirebaseFirestore.instance;
  firestoreInstance.collection("proveedores").add(
      {
        "correo": correo,
        "nombre": nombre,
        "telefono" : tel,

      }).then((value){
    print(value.id);
  });
}