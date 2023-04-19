import 'dart:async';

import 'package:flutter/material.dart';

//librerie
import 'package:mysql_client/mysql_client.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

//utils
import '../Utils/FileManager.dart';
import 'package:bconnect/screens/HomePage.dart';

class Personal extends StatefulWidget{
  Personal({Key? key}): super(key: key);

  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal>{

    Color coloreBG = Colors.black;
    Color coloreIcona = Colors.blueAccent;
    Color coloreBottone = Colors.blueAccent;

    late TextEditingController _controllerUtente;
    late TextEditingController _controllerPassword;

    @override
    void initState() {
      super.initState();
      _controllerUtente = TextEditingController();
      _controllerPassword = TextEditingController();
    }

    @override
    void dispose() {
      _controllerUtente.dispose();
      _controllerPassword.dispose();
      super.dispose();
    }

    Future<void> verificaLogin() async {
      if(_controllerUtente.text == "" && _controllerPassword.text == ""){
        PrimaPagina().utenteTest.setNomeUtente(_controllerUtente.text);
        //Navigator.pop(context);
        messaggioToast("Il campi non possono essere vuoti", Colors.blueAccent, Toast.LENGTH_LONG);
        return;
      }

      testConnessione(_controllerUtente.text, _controllerPassword.text);
    }

    Future<void> testConnessione(String nomeUtente, String password) async {

      final conn = await MySQLConnection.createConnection(
        host: "aws.connect.psdb.cloud",
        port: 3306,
        userName: "26075dj60ib14smt4lek",
        password: "pscale_pw_znGK0pA4YW3iEKvfUfm62VN1Q6auDuyFZkekxU4Sn4l",
        secure: true,
        databaseName: "utenti", // optional
      );


      // actually connect to database
      await conn.connect().then((value){});

      bool esito = false;
      var risultati = await conn.execute("SELECT* FROM user WHERE username='$nomeUtente';", {}, true);
      risultati.rowsStream.listen((row) {
        if((row.colAt(2).toString()) == ((md5.convert(utf8.encode(password)).toString()))){
          messaggioToast("Autenticazione effettuata", Colors.green, Toast.LENGTH_SHORT);
          Timer(Duration(seconds: 1), () {
            PrimaPagina().utenteTest.setNomeUtente("test");
            esito = true;
            Navigator.pop(context);
          });
        }else{
          messaggioToast("Errore Autenticazione", Colors.red, Toast.LENGTH_SHORT);
        }
      });

      Future.delayed(const Duration(seconds: 3),(){if(esito == false){messaggioToast("Errore Autenticazione", Colors.red, Toast.LENGTH_SHORT);}});
    }

    void messaggioToast(String messaggio, Color colore,Toast tempoT){
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

    double height = MediaQuery.of(context).size.height;

    FileManager.load().then((data)  {
      if((data == "chiaro")){
        setState(() {
          coloreBG = Colors.white;
          coloreIcona = Colors.black;
          coloreBottone = Colors.black;
        });
      }
      if((data == "scuro")){
        setState(() {
          coloreBG = Colors.black;
          coloreIcona = Colors.blueAccent;
          coloreBottone = Colors.blueAccent;
        });
      }
    });

    // TODO: implement build
    return SafeArea(
        child: Scaffold(
          backgroundColor: coloreBG,
          body:
          ListView(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: height/4),
                  child:
                  Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 150,
                                  height: 90,
                                  child: TextField(
                                    controller: _controllerUtente,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                      labelText: 'Utente',
                                      icon: Icon(Icons.account_box, color: coloreIcona),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 150,
                                  height: 90,
                                  child: TextField(
                                    controller: _controllerPassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                      labelText: 'Password',
                                      icon: Icon(Icons.visibility_off, color: coloreIcona),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 150,
                                  height: 45,
                                  child: ElevatedButton(onPressed: verificaLogin, child: Text("Login"), style: ElevatedButton.styleFrom(primary: coloreBottone),),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                  ),
                ),
              ],
          ),
        ),
    );
  }

}


