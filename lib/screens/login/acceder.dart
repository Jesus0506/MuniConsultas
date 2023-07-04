import 'package:aplication_1/providers/ingresar_provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:aplication_1/config.dart';
import 'package:aplication_1/helpers/alert.dart';
import 'package:aplication_1/providers/predios_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Acceder extends StatefulWidget {
  const Acceder({super.key});

  @override
  State<Acceder> createState() => _AccederState();
}

class _AccederState extends State<Acceder> {
  var dniMask = MaskTextInputFormatter(
      mask: '###########', filter: {"#": RegExp(r'[0-9]')});
  final txtClabeWeb = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isVisible = true;
  final txtDni = TextEditingController();

  String dni = '';
  String claveWeb = '';
  String mensaje = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => {Navigator.pushNamed(context, 'inicio')},
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            height: 670,
            width: 400,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text('"SAYAN CONSULTAS"',
                      style: GoogleFonts.aclonica(
                          textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Color.fromRGBO(0, 41, 107, 1),
                      ))),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: InterfaceColor.colorg,
                            image: const DecorationImage(
                                scale: 1.3,
                                image: AssetImage('images/logo.jpg'))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      child: TextFormField(
                        inputFormatters: [dniMask],
                        autocorrect: false,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 20),
                            hintText: '',
                            labelText: 'Numero de DNI/RUC'),
                        controller: txtDni,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Porfavor ingrese su documento';
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    obscureText: _isVisible,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.884),
                          ),
                          borderRadius: BorderRadius.circular(5.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.884),
                          ),
                          borderRadius: BorderRadius.circular(5.5),
                        ), // Outline Input Border
                        labelText: "Clave Web",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          icon: _isVisible
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Color.fromARGB(255, 117, 117, 117),
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                ),
                        ),
                        labelStyle: GoogleFonts.urbanist(
                          textStyle: const TextStyle(
                            color: Color.fromRGBO(131, 145, 161, 1),
                          ),
                        ),
                        filled: true,
                        fillColor: Color.fromRGBO(247, 248, 249, 1)),
                    controller: txtClabeWeb,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor Ingrese su Clave Web';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {

                        dni = txtDni.text;
                        claveWeb = txtClabeWeb.text;

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 16),
                                    Text('Cargando...'),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                        final ingresarProvider = Provider.of<IngresarProvider>(
                            context,
                            listen: false);

                        await ingresarProvider.ingresar(dni, claveWeb);

                        Navigator.of(context, rootNavigator: true).pop();

                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Validando...')));
                        if (ingresarProvider.contribProvider.isNotEmpty) {
                          // ignore: use_build_context_synchronously
                          if (ingresarProvider.datos.length > 1) {
                            Navigator.pushReplacementNamed(
                                context, 'viviendas');
                          } else {
                            Navigator.pushReplacementNamed(
                                context, 'principal');
                          }
                        } else {
                          displayCustomAlert(
                              title: 'ALERTA',
                              context: context,
                              icon: Icons.crisis_alert,
                              message: ingresarProvider.message,
                              color: Colors.red);
                        }
                      }
                    },
                    child: Container(
                      child: Align(
                          child: Text(
                        'ACCEDER',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )),
                      height: 60,
                      width: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: InterfaceColor.colorg,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿No tienes tu Clave Web? ',
                        style: GoogleFonts.urbanist(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(106, 112, 124, 1),
                              fontSize: 20),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          height: 35,
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              'Registrarse',
                              style: GoogleFonts.urbanist(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(0, 41, 107, 1),
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, 'registro');
                        },
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                        child: Container(
                          height: 35,
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              'Olvide mi contraseña',
                              style: GoogleFonts.urbanist(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(0, 41, 107, 1),
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, 'validar_dni');
                        },
                      )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
