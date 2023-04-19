import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../Utils/FileManager.dart';

class WDimming extends StatefulWidget{
  WDimming({Key? key}): super(key: key);

  final String title = "BConnect";

  @override
  _WDimmingState createState() => _WDimmingState();
}

class _WDimmingState extends State<WDimming>{

  //colori schermata
  Color coloreBG = Colors.black;
  Color coloreAppBar = Colors.black;
  Color coloreTestoAppBar = Colors.white;
  Color coloreTesto = Colors.blueAccent;
  Color coloreSlider = Colors.white;

  //disposizione slider
  MainAxisAlignment centro = MainAxisAlignment.center;
  MainAxisAlignment spaziato = MainAxisAlignment.spaceEvenly;

  List valoriWhiteDimm = [50.00,50.00,50.00,50.00,50.00,50.00,50.00,50.00,50.00,50.00,50.00,50.00,50.00,50.00];

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
    double fattoreTestoWhiteDim = 1;
    double fattoreImpostazioni = 1;

    if(width > 500){
      fattoreAltezzaSlider = 2;
      fattoreLarghezzaSlider = 2;
      fattoreTestoTitolo = 1.75;
      fattoreTestoOrari = 1.75;
      fattoreTestoWhiteDim = 0.75;
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
          title: Text("WhiteDIM", style: TextStyle(color: coloreTestoAppBar, fontSize: 15 * fattoreTestoTitolo),),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(bottom: 15 * fattoreTestoWhiteDim), child: Text("- WHITEDIM -", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoTitolo),),),
                  Row(
                    mainAxisAlignment: spaziato,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(right: 8),child: Container(
                            width: larghezzalider,
                            height: altezzaSlider,
                            child: SleekCircularSlider(
                              min: 22.0,
                              max: 57.0,
                              innerWidget: (double value) {
                                valoriWhiteDimm[0] = value;
                                //This the widget that will show current value
                                return Center(child: Text("${value.toInt() * 100} K", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));
                              },
                              appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                  255, 184, 224, 223), Color.fromARGB(255, 225, 128, 0),], trackColor: coloreSlider)),
                              onChange: (double value) => {valoriWhiteDimm[0] = value},
                            ),
                          ),),
                          Padding(padding: EdgeInsets.only(bottom: 35), child: Text(" < 18:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari,),),),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(right: 8),child: Container(
                            width: larghezzalider,
                            height: altezzaSlider,
                            child: SleekCircularSlider(
                              min: 22.0,
                              max: 57.0,
                              innerWidget: (double value) {
                                valoriWhiteDimm[1] = value;
                                //This the widget that will show current value
                                return Center(child: Text("${value.toInt() * 100} K", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));
                              },
                              appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                  255, 184, 224, 223), Color.fromARGB(255, 225, 128, 0),], trackColor: coloreSlider)),
                              onChange: (double value) => {valoriWhiteDimm[1] = value},
                            ),
                          ),),
                          Padding(padding: EdgeInsets.only(bottom: 35), child: Text("18:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari,),),),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            width: larghezzalider,
                            height: altezzaSlider,
                            child: SleekCircularSlider(
                              min: 22.0,
                              max: 57.0,
                              innerWidget: (double value) {
                                valoriWhiteDimm[2] = value;
                                //This the widget that will show current value
                                return Center(child: Text("${value.toInt() * 100} K", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));
                              },
                              appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                  255, 184, 224, 223), Color.fromARGB(255, 225, 128, 0),], trackColor: coloreSlider)),
                              onChange: (double value) => {valoriWhiteDimm[2] = value},
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 35), child: Text("19:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari,),),),
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
                            min: 22.0,
                            max: 57.0,
                            innerWidget: (double value) {
                              valoriWhiteDimm[3] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt() * 100} K", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));
                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 184, 224, 223), Color.fromARGB(255, 225, 128, 0),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriWhiteDimm[3] = value},
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("20:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari,),),),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(right: 8), child: Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            min: 22.0,
                            max: 57.0,
                            innerWidget: (double value) {
                              valoriWhiteDimm[5] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt() * 100} K", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));
                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 184, 224, 223), Color.fromARGB(255, 225, 128, 0),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriWhiteDimm[5] = value},
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("21:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari,),),),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            min: 22.0,
                            max: 57.0,
                            innerWidget: (double value) {
                              valoriWhiteDimm[6] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt() * 100} K", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));
                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 184, 224, 223), Color.fromARGB(255, 225, 128, 0),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriWhiteDimm[6] = value},
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("22:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari,),),),
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
                            min: 22.0,
                            max: 57.0,
                            innerWidget: (double value) {
                              valoriWhiteDimm[7] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt() * 100} K", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));
                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 184, 224, 223), Color.fromARGB(255, 225, 128, 0),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriWhiteDimm[7] = value},
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("23:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari,),),),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(right: 8), child: Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            min: 22.0,
                            max: 57.0,
                            innerWidget: (double value) {
                              valoriWhiteDimm[8] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt() * 100} K", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));
                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 184, 224, 223), Color.fromARGB(255, 225, 128, 0),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriWhiteDimm[8] = value},
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("24:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari,),),),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(right: 8), child:Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            min: 22.0,
                            max: 57.0,
                            innerWidget: (double value) {
                              valoriWhiteDimm[9] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt() * 100} K", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));
                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 184, 224, 223), Color.fromARGB(255, 225, 128, 0),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriWhiteDimm[9] = value},
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("01:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari,),),),
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
                            min: 22.0,
                            max: 57.0,
                            innerWidget: (double value) {
                              valoriWhiteDimm[10] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt() * 100} K", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));
                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 184, 224, 223), Color.fromARGB(255, 225, 128, 0),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriWhiteDimm[10] = value},
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("02:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari,),),),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(right: 8),child: Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            min: 22.0,
                            max: 57.0,
                            innerWidget: (double value) {
                              valoriWhiteDimm[11] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt() * 100} K", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));
                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 184, 224, 223), Color.fromARGB(255, 225, 128, 0),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriWhiteDimm[11] = value},
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("03:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari,),),),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            min: 22.0,
                            max: 57.0,
                            innerWidget: (double value) {
                              valoriWhiteDimm[12] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt() * 100} K", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));
                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 184, 224, 223), Color.fromARGB(255, 225, 128, 0),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriWhiteDimm[12] = value},
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("04:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari,),),),
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
                            min: 22.0,
                            max: 57.0,
                            innerWidget: (double value) {
                              valoriWhiteDimm[13] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt() * 100} K", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));
                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 184, 224, 223), Color.fromARGB(255, 225, 128, 0),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriWhiteDimm[13] = value},
                          ),
                        ),),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text("05:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari,),),),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          width: larghezzalider,
                          height: altezzaSlider,
                          child: SleekCircularSlider(
                            min: 22.0,
                            max: 57.0,
                            innerWidget: (double value) {
                              valoriWhiteDimm[14] = value;
                              //This the widget that will show current value
                              return Center(child: Text("${value.toInt() * 100} K", style: TextStyle(fontSize: dimensioneTestoOrari, fontWeight: FontWeight.bold, color: coloreSlider),));
                            },
                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                255, 184, 224, 223), Color.fromARGB(255, 225, 128, 0),], trackColor: coloreSlider)),
                            onChange: (double value) => {valoriWhiteDimm[14] = value},
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 35), child: Text(" > 05:00", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTestoOrari,),),),
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


