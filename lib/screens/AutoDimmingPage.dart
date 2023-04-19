import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../Utils/FileManager.dart';

class ADimming extends StatefulWidget{
  ADimming({Key? key}): super(key: key);

  final String title = "BConnect";

  @override
  _ADimmingState createState() => _ADimmingState();
}

class _ADimmingState extends State<ADimming>{

  //colori schermata
  Color coloreBG = Colors.black;
  Color coloreAppBar = Colors.black;
  Color coloreTestoAppBar = Colors.white;
  Color coloreTesto = Colors.blueAccent;
  Color coloreSlider = Colors.white;

  //disposizione slider
  MainAxisAlignment centro = MainAxisAlignment.center;
  MainAxisAlignment spaziato = MainAxisAlignment.spaceEvenly;

  List valoriAutoDimm = [50.00,50.00,50.00,50.00,50.00,50.00,50.00,50.00,50.00,50.00,50.00,50.00,50.00,50.00];

  @override
  Widget build(BuildContext context) {

    FileManager.load().then((data)  {
      if((data == "chiaro")){
          setState(() {
              coloreBG = Colors.white;
              coloreAppBar = Colors.white;
              coloreTestoAppBar = Colors.black;
              coloreTesto = Colors.black;
              coloreSlider = Colors.black;
          });
      }
      if((data == "scuro")){
          setState(() {
              coloreBG = Colors.black;
              coloreAppBar = Colors.black;
              coloreTestoAppBar = Colors.white;
              coloreTesto = Colors.blueAccent;
              coloreSlider = Colors.white;
          });
      }
    });

    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;

    double fattoreAltezzaSlider = 1;
    double fattoreLarghezzaSlider = 1;
    double fattoreTestoTitolo = 1;
    double fattoreTestoOrari = 1;
    //double fattoreTestoAutoDim = 1;
    double fattoreImpostazioni = 1;

    if(width > 500){
      fattoreAltezzaSlider = 2;
      fattoreLarghezzaSlider = 2;
      fattoreTestoTitolo = 1.75;
      fattoreTestoOrari = 1.75;
      //fattoreTestoAutoDim = 0.75;
      fattoreImpostazioni = 2;
    }

    double altezzaSlider = 85 * fattoreAltezzaSlider;
    double larghezzalider = 85 * fattoreLarghezzaSlider;
    double dimensioneTestoTitolo = 20 * fattoreTestoTitolo;
    double dimensioneTestoOrari = 15 * fattoreTestoOrari;

    return SafeArea(
      child:
      Scaffold(
        backgroundColor: coloreBG,
        appBar: AppBar(
          backgroundColor: coloreAppBar,
          title: Text("AutoDIM", style: TextStyle(color: coloreTestoAppBar, fontSize: 15 * fattoreTestoTitolo),),
          leading: IconButton(
            iconSize: 25 * fattoreImpostazioni,
            onPressed: () => {
              Navigator.pop(context),
            },
            icon: Icon(Icons.home, color: coloreTesto,),
          ),
        ),
        body:
        ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(bottom: 15), child: Text("- AUTODIMM -", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoTitolo),),),
                  Row(
                    //spaziamento centrale - ottimo per piccole risoluzioni, scomodo tablet
                    //mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisAlignment: spaziato,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(right: 8),child: Container(
                            width: larghezzalider,
                            height: altezzaSlider,
                            child: SleekCircularSlider(
                              innerWidget: (double value) {
                                valoriAutoDimm[0] = value;
                                //This the widget that will show current value
                                return Center(child: Text("${value.toInt().toString()} %", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));                              },
                              appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                  255, 255, 255, 0),Color.fromARGB(245, 208, 208, 153),], trackColor: coloreSlider)),
                              onChange: (double value) => {print(valoriAutoDimm[0] = value)},
                            ),
                          ),),
                          Padding(padding: EdgeInsets.only(bottom: 35), child: Text(" < 18:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari),),),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(right: 8),child: Container(
                            width: larghezzalider,
                            height: altezzaSlider,
                            child: SleekCircularSlider(
                              innerWidget: (double value) {
                                valoriAutoDimm[1] = value;
                                //This the widget that will show current value
                                return Center(child: Text("${value.toInt().toString()} %", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));                              },
                              appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                  255, 255, 255, 0),Color.fromARGB(245, 208, 208, 153),], trackColor: coloreSlider)),
                              onChange: (double value) => {valoriAutoDimm[1] = value},
                            ),
                          ),),
                          Padding(padding: EdgeInsets.only(bottom: 35), child: Text("18:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari),),),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: larghezzalider,
                            height: altezzaSlider,
                            child: SleekCircularSlider(
                              innerWidget: (double value) {
                                valoriAutoDimm[2] = value;
                                //This the widget that will show current value
                                return Center(child: Text("${value.toInt().toString()} %", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));                              },
                              appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                  255, 255, 255, 0),Color.fromARGB(245, 208, 208, 153),], trackColor: coloreSlider)),
                              onChange: (double value) => {valoriAutoDimm[2] = value},
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 35), child: Text("19:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari),),),
                        ],
                      ),
                    ],
                  ),
                ],
              ),),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: spaziato,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(right: 8),child:Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            innerWidget: (double value) {
                              valoriAutoDimm[3] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt().toString()} %", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 255, 255, 0),Color.fromARGB(245, 208, 208, 153),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriAutoDimm[3] = value},
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("20:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari),),),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(right: 8), child: Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            innerWidget: (double value) {
                              valoriAutoDimm[4] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt().toString()} %", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 255, 255, 0),Color.fromARGB(245, 208, 208, 153),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriAutoDimm[4] = value},
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("21:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari),),),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            innerWidget: (double value) {
                              valoriAutoDimm[5] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt().toString()} %", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 255, 255, 0),Color.fromARGB(245, 208, 208, 153),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriAutoDimm[5] = value},
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("22:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari),),),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: spaziato,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(right: 8), child: Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            innerWidget: (double value) {
                              valoriAutoDimm[6] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt().toString()} %", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 255, 255, 0),Color.fromARGB(245, 208, 208, 153),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriAutoDimm[6] = value},
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("23:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari),),),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(right: 8), child: Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            innerWidget: (double value) {
                              valoriAutoDimm[7] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt().toString()} %", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 255, 255, 0),Color.fromARGB(245, 208, 208, 153),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriAutoDimm[7] = value},
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("24:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari),),),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(right: 8), child:Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            innerWidget: (double value) {
                              valoriAutoDimm[8] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt().toString()} %", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 255, 255, 0),Color.fromARGB(245, 208, 208, 153),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriAutoDimm[8] = value},
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("01:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari),),),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: spaziato,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(right: 8),child: Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            innerWidget: (double value) {
                              valoriAutoDimm[9] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt().toString()} %", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 255, 255, 0),Color.fromARGB(245, 208, 208, 153),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriAutoDimm[9] = value},
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("02:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari),),),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(right: 8),child: Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            innerWidget: (double value) {
                              valoriAutoDimm[10] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt().toString()} %", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 255, 255, 0),Color.fromARGB(245, 208, 208, 153),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriAutoDimm[10] = value},
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("03:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari),),),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            innerWidget: (double value) {
                              valoriAutoDimm[11] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt().toString()} %", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 255, 255, 0),Color.fromARGB(245, 208, 208, 153),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriAutoDimm[11] = value},
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("04:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari),),),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: spaziato,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(right: 8),child: Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            innerWidget: (double value) {
                              valoriAutoDimm[12] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt().toString()} %", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 255, 255, 0),Color.fromARGB(245, 208, 208, 153),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriAutoDimm[12] = value},
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("05:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari),),),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            innerWidget: (double value) {
                              valoriAutoDimm[13] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt().toString()} %", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 255, 255, 0),Color.fromARGB(245, 208, 208, 153),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriAutoDimm[13] = value},
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text(" > 05:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari),),),
                      ],
                    ),
                  ],
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

}


