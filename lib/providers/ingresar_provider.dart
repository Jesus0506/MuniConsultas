import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class IngresarProvider extends ChangeNotifier{
  List<dynamic> datos =[];
  String contribProvider='';
  String message='';
  late String ruta;


  ringresarProvider() {
    print('Ingresando');
  }

  obtenerContribuyente(String contrib)async{
    contribProvider = contrib;
    print('-----------------------');
    print(contribProvider);
    print('-----------------------');

  }



  Future <void> ingresar(String dni, String password)async{

    final url1 = Uri.parse('https://munisayan.gob.pe/ruta/');
    
    print(url1);
    
    final response1 = await http.get(url1);
    print(response1);
    print("------------------------");

    
    if (response1.statusCode == 200) {
        final jsonResponse = jsonDecode(response1.body) as List<dynamic>;
        final firstItem = jsonResponse[0] as Map<String, dynamic>;
        ruta= firstItem['mensaje'];
        
        print(ruta);
      
    }
    // Encriptar el password en base 64

    final passwordEncriptado = base64Encode(utf8.encode(password));
    final url = Uri.parse('${ruta}Logeo?Documento=$dni&Password=$passwordEncriptado');
    
    print(url);
    
    final response = await http.get(url);
    print(response);
    print("------------------------");

    
    if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as List<dynamic>;
        datos =jsonResponse;
        print(datos);

        final firstItem = jsonResponse[0] as Map<String, dynamic>;
        contribProvider = firstItem['contrib'] ?? '';
        message= firstItem['mensaje'] ?? '' ;
        
        print(contribProvider);
        print(message);
      
    }else{
      message='Lo sentimos, el aplicativo está en mantenimiento, Se pasiente';
    }
  

  }

}