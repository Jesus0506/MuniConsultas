import 'package:aplication_1/providers/ingresar_provider.dart';
import 'package:aplication_1/providers/predios_provider.dart';
import 'package:aplication_1/providers/seguridad_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SeguridadDetalles extends StatefulWidget {
  const SeguridadDetalles({super.key});

  @override
  State<SeguridadDetalles> createState() => _SeguridadDetallesState();
}

class _SeguridadDetallesState extends State<SeguridadDetalles> {
  @override
  Widget build(BuildContext context) {
    final arbitriosProvider = Provider.of<SeguridadProvider>(context);
    
    final List<dynamic> listadeudas = arbitriosProvider.listaDeudasDetallesSeguridad;

    final List<dynamic> lista_totales = arbitriosProvider.totalesSeguridad;

    //get arguments
    final contrib = Provider.of<IngresarProvider>(context);

    final String codigo= contrib.contribProvider;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Usuario : ' + codigo,
            style: GoogleFonts.aclonica(fontSize: 20),
          ),
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 63, 53, 25),
          leading: IconButton(
            color: Colors.white,
            iconSize: 40,
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
              final deudasProvider =
                  Provider.of<SeguridadProvider>(context, listen: false);
              deudasProvider.getArbitriosSeguridad(codigo);
              Navigator.pushReplacementNamed(context, 'arbitrios_seguridad'); 
            },
          ),
        ),
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromRGBO(227, 227, 222, 1),
              Color.fromARGB(255, 224, 223, 216),
              Color.fromARGB(255, 244, 244, 224),
              Color.fromARGB(255, 224, 223, 216),
              Color.fromARGB(255, 227, 227, 222),
            ])),
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: lista_totales.length, (context, index) {
                    return Container(
                      child: Container(
                          padding: const EdgeInsets.only(
                              left: 20, top: 20, right: 5, bottom: 20),
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Monto total del año ' +
                                          lista_totales[index]['aini'] +
                                          ' :  ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'S/. ' + lista_totales[index]['total'],
                                      style: GoogleFonts.aclonica(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    );
                  }),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: lista_totales.length, (context, index) {
                    return Center(
                      child: Container(
                        child: Text(
                          ' Detalles del año ' + lista_totales[index]['aini'],
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }),
                ),
               
              
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  childCount: listadeudas.length,
                  (context, index) {
                    final detalles = listadeudas[index];
                    
                    return GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 10),
                        margin: const EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black, width: 2)),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                    color: Colors.amberAccent,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10, top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          
                                          const Text(
                                            'Periodo',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          Text(
                                            'Tributario',
                                            style: TextStyle(fontSize: 20),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 20, right: 20),
                                            child: Text(
                                              '=>',
                                              style: GoogleFonts.aclonica(
                                                  fontSize: 20),
                                            ),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(detalles['nuevo_id'], style: TextStyle(fontSize: 20),),
                                          Text('Mes N°:',
                                              style: TextStyle(fontSize: 20)),
                                          Text(
                                            detalles['peini'] +
                                                '-' +
                                                detalles['aini'],
                                            style: GoogleFonts.aclonica(
                                                fontSize: 20),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                color: Colors.black,
                                thickness: 2,
                                height: 4,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 5),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              'Valor Insoluto',
                                              style: GoogleFonts.adamina(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              detalles['vdeuda'],
                                              style: GoogleFonts.aclonica(
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Text(
                                              'D. Emision',
                                              style: GoogleFonts.adamina(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              detalles['vderemi'],
                                              style: GoogleFonts.aclonica(
                                                  fontSize: 20),
                                            )
                                          ],
                                        ),
                                      )
                                    ]),
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.only(top: 5, bottom: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Sobretasas',
                                          style: GoogleFonts.adamina(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        detalles['sobretasas'],
                                        style:
                                            GoogleFonts.aclonica(fontSize: 20),
                                      )
                                    ],
                                  )),
                              const Divider(
                                color: Colors.black,
                                thickness: 2,
                                height: 4,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 64, 255, 255),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Saldo Actual',
                                        style: GoogleFonts.adamina(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        detalles['total'],
                                        style:
                                            GoogleFonts.aclonica(fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: () {},
                    );
                  },
                ))
              ],
            )));
  }
}