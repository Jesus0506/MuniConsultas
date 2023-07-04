import 'package:aplication_1/config.dart';
import 'package:aplication_1/helpers/alert.dart';
import 'package:aplication_1/providers/ingresar_provider.dart';
import 'package:aplication_1/providers/predios_provider.dart';
import 'package:aplication_1/screens/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Principal extends StatefulWidget {
  const Principal({super.key});

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  bool _isExpanded = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final contrib = Provider.of<IngresarProvider>(context);

    final predioProvider = Provider.of<PredioProvider>(context);
    final List<dynamic> datos = predioProvider.datos;

    final String codigo = contrib.contribProvider;
    return Scaffold(
      key: _scaffoldKey,
      drawer: myMenu(),
      body: Container(
        color: const Color.fromARGB(155, 209, 207, 207),
//        color: Colors.red,
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
                //color: Colors.amber,
                width: 400,
                height: 700,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.black,
                          size: 35,
                        ),
                        onPressed: () =>
                            _scaffoldKey.currentState?.openDrawer(),
                      ),
                    ),
                    const Title(),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
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

                        final prediosProvider =
                            Provider.of<PredioProvider>(context, listen: false);

                        await prediosProvider.getPredios(codigo);

                        Navigator.of(context, rootNavigator: true).pop();
                        if (prediosProvider.predioGlobal.isEmpty) {
                          // ignore: use_build_context_synchronously
                          displayCustomAlert(
                              context: context,
                              icon: Icons.check_circle_outline,
                              message: prediosProvider.message,
                              color: Colors.green);
                        } else {
                          Navigator.pushReplacementNamed(context, 'predios');
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 236, 195, 90),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 67,
                              width: 67,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage('images/predios.jpg'),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: const Text(
                                  'PREDIOS',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.pushReplacementNamed(
                            context, 'select_arbitrios');
                      },
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(243, 134, 216, 67),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              height: 67,
                              width: 67,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage('images/arbitrios.jpg'),
                                      fit: BoxFit.fill),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: const Text(
                                  'ARBITRIOS',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /* SizedBox(
                        child: FloatingActionButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    )), */
                    /* GestureDetector(
                        onTap: () {
                          // Acción al hacer clic
                        },
                        child: Material(
                          color: Colors.blue,
                          child: InkWell(
                            onTap: () {},
                            splashColor: Colors.red.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              child: const Text(
                                'Clic aquí',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ), */
                    /* GestureDetector(
                        onTap: () async {
                          Navigator.pushReplacementNamed(
                              context, 'select_arbitrios');
                        },
                        child: Material(
                          color: Colors.blue,
                          child: InkWell(
                            onTap: () {},
                            splashColor: Colors.red.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 100,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(243, 134, 216, 67),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: 67,
                                    width: 67,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image:
                                            AssetImage('images/arbitrios.jpg'),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: const Text(
                                        'ARBITRIOS',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ) */
                  ],
                )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
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
                        Text('...'),
                      ],
                    ),
                  ),
                );
              },
            );

            final predioProvider =
                Provider.of<PredioProvider>(context, listen: false);
            await predioProvider.getDatos(codigo);

            Navigator.of(context, rootNavigator: true).pop();

            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          mini: Paint.enableDithering,
          child: const Icon(
            Icons.person,
            size: 35,
          )),
      bottomSheet: _isExpanded ? buildBottomSheet() : null,
    );
  }

  Widget buildBottomSheet() {
    final predioProvider = Provider.of<PredioProvider>(context);
    final List<dynamic> datos = predioProvider.datos;
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      color: Colors.white,
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(childCount: datos.length,
                (context, index) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromRGBO(227, 227, 222, 1),
                  Color.fromARGB(255, 224, 223, 216),
                  Color.fromARGB(255, 244, 244, 224),
                  Color.fromARGB(255, 224, 223, 216),
                  Color.fromARGB(255, 227, 227, 222),
                ])),
                child: Column(
                  children: [
                    Container(
                      color: Colors.blueAccent,
                      height: 55,
                      width: MediaQuery.of(context).size.width * 1,
                      child: const Center(
                        child: Text(
                          'PERFIL',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Text('Código de Contribuyente',
                              style: GoogleFonts.urbanist(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  color: Color.fromRGBO(0, 41, 107, 1),
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(datos[index]['contrib'],
                              style: GoogleFonts.aclonica(
                                  fontSize: 26, fontWeight: FontWeight.bold)),
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
                            height: 5,
                          ),
                          SizedBox(
                            height: 40,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(datos[index]['ap_paterno'].trim() + ' ',
                                      style: GoogleFonts.urbanist(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                        ),
                                      )),
                                  Text(datos[index]['ap_materno'].trim() + ' ',
                                      style: GoogleFonts.urbanist(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                        ),
                                      )),
                                  Text(datos[index]['nombres'].trim(),
                                      style: GoogleFonts.urbanist(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Domicilio Fiscal',
                              style: GoogleFonts.urbanist(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  color: Color.fromRGBO(0, 41, 107, 1),
                                ),
                              )),
                          const SizedBox(
                            height: 3,
                          ),
                          SizedBox(
                            height: 45,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(children: [
                                  Text(datos[index]['direcc'].trim(),
                                      style: GoogleFonts.urbanist(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                        ),
                                      ))
                                ])),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  //final UserProfileResponse userProfile;
  const Title({
    Key? key, //required this.userProfile
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bienvenido !',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: InterfaceColor.colorb),
              ),
              Container(
                height: 20,
              ),
              Container(
                width: 200,
                child: const Text(
                  '¿Que consulta deseas realizar?',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
