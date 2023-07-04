import 'package:aplication_1/providers/ingresar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class myMenu extends StatefulWidget {
  @override
  State<myMenu> createState() => _myMenuState();
}

class _myMenuState extends State<myMenu> {
  @override
  Widget build(BuildContext context) {
    final ingresarProvider = Provider.of<IngresarProvider>(context);
    final datosLength = ingresarProvider.datos.length;

    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 2,
      color: const Color.fromARGB(255, 165, 162, 162),
      child: ListView(
        padding: const EdgeInsets.only(top: 50.0),
        children: <Widget>[
          Container(
            height: 150,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                  image: AssetImage('images/logo.jpg'), fit: BoxFit.fill),
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          if (datosLength > 1)
            ListTile(
              title: const Text(
                'Viviendas',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              trailing: const Icon(
                Icons.home,
                size: 30.0,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'viviendas');
              },
            ),
          Container(
            height: 5,
            color: Color.fromARGB(255, 165, 162, 162),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, 'validar_dni');
            },
            title: const Text(
              'Cambiar Contraseña',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            trailing: const Icon(
              Icons.edit_square,
              size: 30.0,
              color: Colors.black,
            ),

            
          ),
          Container(
            height: 300,
            color: Color.fromARGB(255, 165, 162, 162),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, 'inicio');
            },
            title: Text(
              'Cerrar Sesión',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            trailing: Icon(
              Icons.exit_to_app,
              size: 30.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
