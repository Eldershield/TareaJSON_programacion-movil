import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Noticias Flutter'),
        ),
        body: FutureBuilder(
          future: cargarNoticias(context),
          builder: (context, AsyncSnapshot<List<Noticia>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(_getIcon(snapshot.data![index].icono)),
                    title: Text(snapshot.data![index].titulo),
                    subtitle: Text(snapshot.data![index].descripcion),
                    trailing: Text(snapshot.data![index].fechaPublicacion),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error al cargar los datos'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  static IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'accessible_forward_sharp':
        return Icons.accessible_forward_sharp;
      case 'ad_units':
        return Icons.ad_units;
      case 'add_a_photo':
        return Icons.add_a_photo;
      case 'add_business':
        return Icons.add_business;
      case 'add_moderator':
        return Icons.add_moderator;
      default:
        return Icons.error; // Otra opción en caso de icono no encontrado
    }
  }

  Future<List<Noticia>> cargarNoticias(BuildContext context) async {
    // Simulando la carga del JSON (puedes sustituir esta parte por tu método de carga real)
    String data =
        await DefaultAssetBundle.of(context).loadString('assets/noticias.json');
    // Decodificar el JSON
    List<dynamic> jsonParsed = jsonDecode(data);

    // Convertir los datos a instancias de la clase Noticia
    List<Noticia> noticias = [];
    for (var item in jsonParsed) {
      noticias.add(Noticia.fromJson(item));
    }

    return noticias;
  }
}

class Noticia {
  final String titulo;
  final String descripcion;
  final String icono;
  final String fechaPublicacion;

  Noticia({
    required this.titulo,
    required this.descripcion,
    required this.icono,
    required this.fechaPublicacion,
  });

  factory Noticia.fromJson(Map<String, dynamic> json) {
    return Noticia(
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      icono: json['icono'],
      fechaPublicacion: json['fecha_publicacion'],
    );
  }
}
