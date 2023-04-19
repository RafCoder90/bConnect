//pagine
import 'dart:io';

import 'package:bconnect/screens/HomePage.dart';

//utils
import '../Utils/FileManager.dart';

//librerie
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Impostazioni extends StatefulWidget{
    Impostazioni({Key? key}): super(key: key);

    final String title = "BConnect";

    @override
    _ImpostazioniState createState() => _ImpostazioniState();
}

class _ImpostazioniState extends State<Impostazioni>{
  bool temaScuro = true;

  Color coloreBG = Colors.black;
  Color coloreIcone = Colors.blueAccent;
  Color coloreTesto = Colors.blueAccent;
  Color coloreTestoAppBar = Colors.white;
  Color coloreAppBar = Colors.black;

  late TextEditingController _nomeFile;
  late List<String> contenutoFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nomeFile = TextEditingController();
    _salvaPercorsi();
    _recuperaListaFile();
  }

  Future<void> _salvaConfigurazione() async {
      await _dialogSalvaFile(context);
  }

  Future<void> _recuperaListaFile() async {
      String file = "";
      await FileManager.loadConfigurazione().then((value) => file = value);
      contenutoFile = file.split(",");
      print(contenutoFile.length);
  }

  Future<void> _recuperaListaView() async{
      await _dialogListaFile(context);
  }

  Future<void> _confermaSalvaConfigurazione() async {

      String flussoLuminoso = PrimaPagina().configurazioneCorrente.getFlussoLuminoso().toStringAsFixed(2);
      String temperaturaColore = PrimaPagina().configurazioneCorrente.getTemperaturaColore().toStringAsFixed(2);

      String data = flussoLuminoso + "\n" + temperaturaColore;

      String nomeFile = "_";

      if(_nomeFile.text != ""){
          nomeFile = _nomeFile.text;
      }

      bool risultato = await FileManager.saveConfigurazione(data, nomeFile);

      if(risultato == true){
          _messaggioToast("Salvataggio di " + nomeFile + ".txt effettuato correttamente", Colors.green, Toast.LENGTH_LONG);
      }else{
          _messaggioToast("Errore nel salvataggio file", Colors.red, Toast.LENGTH_LONG);
      }

      _nomeFile = TextEditingController();
  }

  Future<void> _dialogSalvaFile(BuildContext context) {
      return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
              return AlertDialog(
                  title: const Text('Salva Configurazione'),
                  content: Row(children: [Container(
                      width: 250,
                      height: 90,
                      child:TextField(
                      controller: _nomeFile,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: UnderlineInputBorder(),
                      ),
                  ),),]),
                  actions: <Widget>[
                      TextButton(
                          style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('Annulla'),
                          onPressed: () {
                              Navigator.of(context).pop();
                              _nomeFile = TextEditingController();
                          },
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('Salva'),
                          onPressed: () {
                              Navigator.of(context).pop();
                              _confermaSalvaConfigurazione();
                              _salvaPercorsi();
                              _recuperaListaFile();
                          },
                      ),
                  ],
              );
          },
      );
  }

  Future<void> _dialogListaFile(BuildContext context) {
      return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
              return AlertDialog(
                  title: const Text('Configurazioni salvate'),
                  content: Container(child: Row(children: [
                        Container(
                            height: 250,
                            width: 250,
                            child: ListView.builder(
                                itemCount: contenutoFile.length,
                                itemBuilder: (context, index) {
                                    if(contenutoFile[index].toString().length > 3){
                                        int inizio = contenutoFile[index].toString().length - 3;
                                        int fine = contenutoFile[index].toString().length;
                                        if(contenutoFile[index].toString().substring(inizio, fine) == "txt" && !(contenutoFile[index].toString().contains("tema.txt") || contenutoFile[index].toString().contains("mieiFile.txt"))){
                                            return Card(
                                                // In many cases, the key isn't mandatory
                                                key: ValueKey(contenutoFile[index]),
                                                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                                child: Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Text(contenutoFile[index])),
                                            );
                                        }
                                    }
                                    return Container(
                                        height: 0,
                                        width: 0,
                                    );
                                }),
                        ),
                  ],)),
                  actions: <Widget>[
                      TextButton(
                          style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('Annulla'),
                          onPressed: () {
                              Navigator.of(context).pop();
                          },
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('Recupera'),
                          onPressed: () {
                              Navigator.of(context).pop();
                          },
                      ),
                  ],
              );
          },
      );
  }

  void _salvaPercorsi(){
      FileManager().salvaPercorsi();
  }

  void _messaggioToast(String messaggio, Color colore,Toast tempoT){
      Fluttertoast.showToast(
          msg: messaggio,
          toastLength: tempoT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: colore,
          textColor: Colors.white,
          fontSize: 16.0
      );
  }

  @override
  Widget build(BuildContext context) {

      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

      FileManager.load().then((data)  {
          if((data == "chiaro")){
              setState(() {
                  temaScuro = false;
                  coloreBG = Colors.white;
                  coloreIcone = Colors.black;
                  coloreAppBar = Colors.white;
                  coloreTestoAppBar = Colors.black;
                  coloreTesto = Colors.black;
              });
          }
          else{
              setState(() {
                  temaScuro = true;
                  coloreBG = Colors.black;
                  coloreIcone = Colors.blueAccent;
                  coloreTesto = Colors.blueAccent;
                  coloreTestoAppBar = Colors.white;
                  coloreAppBar = Colors.black;
              });
          }
      });

      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;

      double fattoreIcone = 1;
      double fattoreTestoTitolo = 1;
      double fattoreTesto = 1;
      double fattoreImpostazioni = 1;

      double fattoreAltezza = 1;

      if(width > 500){
          fattoreIcone = 2;
          fattoreTestoTitolo = 1.75;
          fattoreTesto = 1.75;
          fattoreImpostazioni = 2;
      }

      if(height > 950){
          fattoreAltezza = 2.5;
      }

      double altezzaIcone = 75 * fattoreIcone;
      double dimensioneTestoTitolo = 20 * fattoreTestoTitolo;
      double dimensioneTesto = 15 * fattoreTesto;

      return SafeArea(
          child:
          Scaffold(
              backgroundColor: coloreBG,
              appBar: AppBar(
                  backgroundColor: coloreAppBar,
                  title: Text("Settings", style: TextStyle(color: coloreTestoAppBar, fontSize: dimensioneTestoTitolo),),
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
                      //Copia Configurazione
                      Padding(
                          padding: EdgeInsets.only(
                              top: 100,
                              bottom: 35 * fattoreAltezza,
                          ),
                          child:
                          Column(
                              children: <Widget>[
                                  IconButton(
                                      icon: Icon(Icons.copy),
                                      color: coloreIcone,
                                      onPressed: _salvaConfigurazione,
                                      iconSize: altezzaIcone,
                                      tooltip: "Salva la configurazione",
                                  ),
                                  Text("Copia Configurazione", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTesto ,),)
                              ],
                          ),
                      ),

                      //Importa Configurazione
                      Padding(
                          padding: EdgeInsets.only(
                              top: 35 * fattoreAltezza,
                              bottom: 35 * fattoreAltezza,
                          ),
                          child:
                          Column(
                              children: <Widget>[
                                  IconButton(
                                      icon: Icon(Icons.paste),
                                      color: coloreIcone,
                                      onPressed: _recuperaListaView,
                                      iconSize: altezzaIcone,
                                      tooltip: "Recupera una configurazione esistente",
                                  ),
                                  Text("Importa Configurazione", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTesto ,),)
                              ],
                          ),
                      ),

                      //Informazioni applicazione
                      Padding(
                          padding: EdgeInsets.only(
                              top: 35 * fattoreAltezza,
                              //bottom: 35 * fattoreAltezza,
                          ),
                          child:
                          Column(
                              children: <Widget>[
                                  Switch(value: temaScuro, onChanged: (bool value) {
                                      // This is called when the user toggles the switch.
                                      setState(() {
                                          temaScuro = value;
                                          if(temaScuro){
                                              //print("scuro");
                                              FileManager.save("scuro");
                                              temaScuro = true;
                                              coloreBG = Colors.black;
                                              coloreIcone = Colors.blueAccent;
                                              coloreTesto = Colors.blueAccent;
                                              coloreTestoAppBar = Colors.white;
                                              coloreAppBar = Colors.black;
                                          }else{
                                              //print("chiaro");
                                              FileManager.save("chiaro");
                                              temaScuro = false;
                                              coloreBG = Colors.white;
                                              coloreIcone = Colors.black;
                                              coloreAppBar = Colors.white;
                                              coloreTestoAppBar = Colors.black;
                                              coloreTesto = Colors.black;
                                          }
                                      });
                                  },),
                                  Text("Tema Scuro", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTesto ,),)
                              ],
                          ),
                      ),

                      //Informazioni applicazione
                      Padding(
                          padding: EdgeInsets.only(
                              top: 35 * fattoreAltezza,
                              //bottom: 35 * fattoreAltezza,
                          ),
                          child:
                          Column(
                              children: <Widget>[
                                  IconButton(
                                      icon: Icon(Icons.info),
                                      color: coloreIcone,
                                      onPressed: (){},
                                      iconSize: altezzaIcone,
                                      tooltip: "Informazioni sull\'applicazione",
                                  ),
                                  Text("Info App", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTesto ,),)
                              ],
                          ),
                      ),
                  ],
              ),
          ),
      );
  }

}


