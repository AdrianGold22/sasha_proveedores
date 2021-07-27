import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  final String descripcion;
  final String foto;
  final String id_categoria;
  final String id_usuario;
  final String nombre;
  final int peso;
  final String tipo_envio;
  final int valor;
  final String id;

  Products({
    required this.descripcion,
    required this.foto,
    required this.id_categoria,
    required this.id_usuario,
    required this.nombre,
    required this.peso,
    required this.tipo_envio,
    required this.valor,
    required this.id

  });

  Map<String, dynamic> toMap() {
    return {
      'descripcion': descripcion,
      'foto': foto,
      'id_categoria': id_categoria,
      'id_usuario': id_usuario,
      'nombre':nombre,
      'peso':peso,
      'tipo_envio':tipo_envio,
      'valor':valor,

    };
  }

  factory Products.fromDoc(QueryDocumentSnapshot doc) {
    return Products(
      descripcion: doc['descripcion'],
      foto: doc['foto'],
      id_categoria: doc['id_categoria'],
      id_usuario: doc['id_usuario'],
      nombre:doc['nombre'],
      peso:doc['peso'],
      tipo_envio:doc['tipo_envio'],
      valor:doc['valor'],
      id:doc.id,

    );
  }
}
