import 'package:aplication_1/config.dart';
import 'package:aplication_1/providers/ingresar_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Viviendas extends StatefulWidget {
  const Viviendas({super.key});

  @override
  State<Viviendas> createState() => _ViviendasState();
}

class _ViviendasState extends State<Viviendas> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final ingresarProvider = Provider.of<IngresarProvider>(context);

    final List<dynamic> datos = ingresarProvider.datos;

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: const Color.fromARGB(155, 209, 207, 207),
        child: Align(
          child: Container(
            height: 750,
            width: 400,
            //color: Colors.amber,
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: Align(
                            child: Column(
                              children: [
                                Text(
                                    'Usted tiene más de un predio',
                                    style: GoogleFonts.aclonica(
                                      textStyle: const TextStyle(
                                        fontSize: 25,
                                        color: Color.fromRGBO(0, 41, 107, 1),
                                      ),
                                    ),
                                  ),
                                  
                                Text(
                                      'Seleccione la vivienda a consultar:',
                                      style: GoogleFonts.urbanist(fontSize: 17),
                                    ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return GestureDetector(
                              onTap: () async {
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
                                            Text('Consultando...'),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );

                                final ingresarProvider =
                                    Provider.of<IngresarProvider>(context,
                                        listen: false);
                                await ingresarProvider.obtenerContribuyente(
                                    datos[index]['contrib']);
                                Navigator.of(context, rootNavigator: true)
                                    .pop();

                                Navigator.pushNamed(context, 'principal');
                              },
                              child: Container(
                                margin: const EdgeInsets.only(top: 30),
                                width: 500,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: InterfaceColor.colorg,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 73,
                                      width: 73,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                          image:
                                              AssetImage('images/vivienda.jpg'),
                                          fit: BoxFit.fill,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    Container(
                                      //color: Colors.red,
                                      height: 140,
                                      width: 290,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 290,
                                            height: 55,
                                            //color: Colors.blue,
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Contribuyente : ',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  datos[index]['contrib'],
                                                  style: GoogleFonts.urbanist(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                    color: const Color.fromRGBO(
                                                      0,
                                                      41,
                                                      107,
                                                      1,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 85,
                                            width: 290,
                                            //color: Colors.orange,
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Direccion :',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                SizedBox(
                                                  width: 190,
                                                  child: Text(
                                                    datos[index]['direccion'],
                                                    style: GoogleFonts.urbanist(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: datos.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
