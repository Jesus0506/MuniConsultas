import 'package:aplication_1/config.dart';
import 'package:aplication_1/providers/ingresar_provider.dart';
import 'package:aplication_1/providers/predios_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Predios extends StatefulWidget {
  const Predios({super.key});

  @override
  State<Predios> createState() => _PrediosState();
}

class _PrediosState extends State<Predios> {
  @override
  Widget build(BuildContext context) {
    final contrib = Provider.of<IngresarProvider>(context);
    final contenedorProvider = Provider.of<PredioProvider>(context);
    final List<dynamic> lista_deudas_por_anios =
        contenedorProvider.listaDeudasPorAnios;

    final List<dynamic> lista_total = contenedorProvider.total;
    final List<dynamic> datos = contenedorProvider.datos;

    final String global = contenedorProvider.predioGlobal;
    final String codigo = contrib.contribProvider;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 236, 195, 90),
        leading: IconButton(
          iconSize: 40,
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => {Navigator.pushNamed(context, 'principal')},
        ),
        title: Text(
          'Impuestos Prediales',
          style: GoogleFonts.aclonica(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Container(
            width: 500,
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
                  delegate: SliverChildBuilderDelegate(childCount: datos.length,
                      (context, index) {
                    return Container(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 20, top: 20, right: 5, bottom: 20),
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: [
                            Text('Código de Contribuyente',
                                style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Color.fromRGBO(0, 41, 107, 1),
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(datos[index]['contrib'],
                                style: GoogleFonts.aclonica(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 20,
                            ),
                            Text('Apellidos y Nombres/Razón Social',
                                style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Color.fromRGBO(0, 41, 107, 1),
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(datos[index]['ap_paterno'].trim() + ' ',
                                      style: GoogleFonts.urbanist(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      )),
                                  Text(datos[index]['ap_materno'].trim() + ' ',
                                      style: GoogleFonts.urbanist(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      )),
                                  Text(datos[index]['nombres'].trim(),
                                      style: GoogleFonts.urbanist(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text('Domicilio Fiscal',
                                style: GoogleFonts.urbanist(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Color.fromRGBO(0, 41, 107, 1),
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(children: [
                                  Text(datos[index]['direcc'].trim(),
                                      style: GoogleFonts.urbanist(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ))
                                ]))
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: lista_total.length, (context, index) {
                    String estado = lista_total[index]['id'];

                    bool isCurrentYear = (estado == 'F');

                    Color containerColor = isCurrentYear
                        ? Color.fromARGB(255, 182, 181, 181)
                        : Color.fromARGB(255, 142, 196, 240);
                    return Container(
                        color: containerColor,
                        /* padding: const EdgeInsets.only(
                                  left: 20, top: 20, right: 5, bottom: 20), */
                        margin: const EdgeInsets.only(),
                        /* decoration: BoxDecoration(
                                  color: containerColor,
                                  border: Border.all(color: Colors.black, width: 2)), */
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 20, right: 5, bottom: 20),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.white)),
                                width: 205,
                                height: 90,
                                child: Center(
                                  child: Text(
                                    (estado == 'F')
                                        ? 'Monto Fraccionados:  '
                                        : 'Monto Deudas:  ',
                                    style: GoogleFonts.aclonica(fontSize: 20),
                                  ),
                                ),
                              ),
                              Container(
                                width: 295,
                                height: 90,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.white)),
                                padding: const EdgeInsets.only(
                                    left: 20, top: 20, right: 5, bottom: 20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'S/.  ' + lista_total[index]['total'],
                                    style: GoogleFonts.aclonica(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ));
                  }),
                ),
                SliverToBoxAdapter(
                    child: Container(
                        padding: const EdgeInsets.all(3),
                        margin: const EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                            color: Colors.amber, border: Border.all(width: 2)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 200,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.white)),
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 20, right: 5, bottom: 20),
                                  child: Text(
                                    'TOTAL A PAGAR:  ',
                                    style: GoogleFonts.aclonica(fontSize: 20),
                                  )),
                              Container(
                                width: 291,
                                height: 90,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.white)),
                                padding: const EdgeInsets.only(
                                    left: 20, top: 20, right: 5, bottom: 20),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'S/.  ' + global,
                                    style: GoogleFonts.aclonica(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))),
                SliverToBoxAdapter(
                  child: Center(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_downward_sharp,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Resumen por Año',
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.arrow_downward_sharp,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: Container(
                      /* decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey
                        )
                      ), */
                      color: const Color.fromARGB(255, 240, 204, 96),
                      height: 70,
                      margin: const EdgeInsets.only(left: 40, right: 40),
                      child: Column(
                        children: [
                          const Text(
                            'Leyenda',
                            style: TextStyle(
                                color: InterfaceColor.colorb, fontSize: 20),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  width: 79,
                                  child: const Text(
                                    'Deudas',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),
                              Container(
                                  width: 79,
                                  child: const Text('Fraccionado',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 10,
                                width: 160,
                                color: const Color.fromARGB(255, 95, 183, 255),
                              ),
                              Container(
                                height: 10,
                                width: 150,
                                color: Colors.grey,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: lista_deudas_por_anios.length,
                    (context, index) {
                      String estado = lista_deudas_por_anios[index]['id'];

                      bool isCurrentYear = (estado == 'F');

                      Color containerColor = isCurrentYear
                          ? Colors.grey
                          : Color.fromARGB(255, 95, 183, 255);
                      return Container(
                        child: GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 20, top: 20, right: 5, bottom: 20),
                            margin: const EdgeInsets.only(
                                left: 20, top: 10, right: 20, bottom: 10),
                            decoration: BoxDecoration(
                                color: containerColor,
                                //color: Colors.primaries[index % Colors.primaries.length],
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(color: Colors.black, width: 2)),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'Año',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        lista_deudas_por_anios[index]['aini'],
                                        style:
                                            GoogleFonts.aclonica(fontSize: 20),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      const Text('Trimestres',
                                          style: TextStyle(fontSize: 15)),
                                      Text(
                                          lista_deudas_por_anios[index]
                                              ['cantidad'],
                                          style: GoogleFonts.aclonica(
                                              fontSize: 20))
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 24,
                                  ),
                                  Column(
                                    children: [
                                      const Text('Deuda',
                                          style: TextStyle(fontSize: 15)),
                                      Text(
                                          'S/.' +
                                              lista_deudas_por_anios[index]
                                                  ['total'],
                                          style: GoogleFonts.aclonica(
                                              fontSize: 20))
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  const Center(
                                      child: Icon(
                                    Icons.arrow_circle_right_outlined,
                                    size: 40,
                                  ))
                                ],
                              ),
                            ),
                          ),
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
                                        Text('Detalles...'),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );

                            final deudasProvider = Provider.of<PredioProvider>(
                                context,
                                listen: false);
                            await deudasProvider.prediosDetalles(
                                codigo, lista_deudas_por_anios[index]['aini']);
                            Navigator.of(context, rootNavigator: true).pop();

                            Navigator.pushNamed(context, 'predios_detalles');
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class Item {
  String expandedValue;
  String headerValue;
  bool isExpanded;

  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (index) {
    return Item(
        headerValue: 'Panel $index', expandedValue: 'This is item $index');
  });
}
