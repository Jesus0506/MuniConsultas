import 'package:aplication_1/config.dart';
import 'package:flutter/material.dart';

class AccReg extends StatefulWidget {
  const AccReg({super.key});

  @override
  State<AccReg> createState() => _AccRegState();
}

class _AccRegState extends State<AccReg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Center(
              child: Align(
                alignment: Alignment.center,
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: 350,
                  height: 680,
                  child: Column(
                  
                children: <Widget>[
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: Container(
                        height: 320,
                        width: 320,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: InterfaceColor.colorg,
                            image: const DecorationImage(
                                //fit: BoxFit.cover,
                                scale: 0.8,
                                image: AssetImage('images/logo.jpg'))),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'acceder');
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        'Acceder',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )),
                      height: 60,
                      width: 360,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: InterfaceColor.colorg),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'registro');
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        'Registrese',
                        style: TextStyle(
                            color: InterfaceColor.colorg,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )),
                      height: 60,
                      width: 360,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: InterfaceColor.colorg,width: 3),
                          borderRadius: BorderRadius.circular(9),
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
                ),
              )
              
              
            ),
      ),
      );
  }
}
