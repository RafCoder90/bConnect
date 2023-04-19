//libreria principale
// ignore_for_file: unused_field
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//pagine
import '../screens/SettingsPage.dart';
import '../screens/AutoDimmingPage.dart';
import '../screens/WhiteDimmingPage.dart';
import '../screens/PersonalPage.dart';

//utils
import '../Utils/FileManager.dart';
import '../Utils/Utente.dart';
import '../Utils/Configurazione.dart';

//librerie
import 'package:url_launcher/url_launcher.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';


UtenteLogin utente = UtenteLogin();
Configurazione configurazione = Configurazione();

class PrimaPagina extends StatefulWidget{
  PrimaPagina({Key? key}): super(key: key);

  UtenteLogin utenteTest = utente;
  Configurazione configurazioneCorrente = configurazione;

  final String title = "BConnect";
  final double width = 200;

  @override
  _PrimaPaginaState createState() => _PrimaPaginaState();
}

double _flussoLuminoso = 0;
double _temperaturaColore = 0;

class _PrimaPaginaState extends State<PrimaPagina>{

  Color coloreBG = Colors.black;
  Color coloreAppBar = Colors.black;
  Color coloreTestoAppBar = Colors.blueAccent;
  Color coloreContronoBluetooth = Colors.blueAccent;
  Color iconaBluetooth = Colors.blueAccent;
  Color coloreTesto = Colors.blueAccent;
  Color coloreSlider = Colors.white;

  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;
  late BluetoothConnection _bluetoothConnection;
  List<BluetoothDevice> _deviceList = [];
  late BluetoothDevice _device;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Sto chiamando initState di Home Page");
    _permessiConcessi();
    _ricercaBluetooth();
  }

  @override
  void dispose(){
    super.dispose();
    bluetooth.cancelDiscovery();
    _bluetoothConnection.dispose();
  }

  //Indice barra navigazione
  int _selectedIndex = 0;

  //Gestione Colori
  final List<Color> _colors = [
      Color.fromARGB(255, 255, 128, 0),
      Color.fromARGB(255, 255, 128, 0),
      Color.fromARGB(255, 255, 255, 0),
      Color.fromARGB(255, 255, 255, 0),
      Color.fromARGB(255, 255, 255, 0),
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 184, 224, 223),
      Color.fromARGB(255, 184, 224, 223),
      Color.fromARGB(255, 184, 224, 223),
      Color.fromARGB(255, 184, 224, 223),
  ];
  double _colorSliderPosition = 0;
  Color _currentColor = Color.fromARGB(255, 255, 255, 0);

  //Metodi per gestire la temperatura colore
  _colorChangeHandler(double position) {
    //handle out of bounds positions
    if (position > widget.width) {
      position = widget.width;
    }
    if (position < 0) {
      position = 0;
    }
    print("New pos: $position");
    setState(() {
      _colorSliderPosition = position;
      _currentColor = _calculateSelectedColor(_colorSliderPosition);
      _temperaturaColore = position;
    });
  }

  Color _calculateSelectedColor(double position) {
    //determine color
    double positionInColorArray = (position / widget.width * (_colors.length - 1));
    print(positionInColorArray);
    int index = positionInColorArray.truncate();
    print(index);
    double remainder = positionInColorArray - index;
    if (remainder == 0.0) {
      _currentColor = _colors[index];
    } else {
      //calculate new color
      int redValue = _colors[index].red == _colors[index + 1].red
          ? _colors[index].red
          : (_colors[index].red +
          (_colors[index + 1].red - _colors[index].red) * remainder)
          .round();
      int greenValue = _colors[index].green == _colors[index + 1].green
          ? _colors[index].green
          : (_colors[index].green +
          (_colors[index + 1].green - _colors[index].green) * remainder)
          .round();
      int blueValue = _colors[index].blue == _colors[index + 1].blue
          ? _colors[index].blue
          : (_colors[index].blue +
          (_colors[index + 1].blue - _colors[index].blue) * remainder)
          .round();
      _currentColor = Color.fromARGB(255, redValue, greenValue, blueValue);
    }
    return _currentColor;
  }

  //Gestione link sito
  final Uri _url = Uri.parse('http://www.phaenomena.it/');

  //Metodo per aprire pagina sito
  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw 'Could not launch $_url';
    }
  }

  //Metodo per gestire il tap sulla barra di navigazione
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _apriControlli(_selectedIndex);
    });
  }

  void _apriControlli(int indice){
      Navigator.push(context, MaterialPageRoute<void>(
          builder: (context){
            if(indice == 0){return ADimming();}
            if(indice == 1){return WDimming();}
            return Impostazioni();
      }
    ),);
  }

  //Metodi per la gestione bluetooth
  void _ricercaBluetooth () async{

      _deviceList = [];

      setState(() {
        iconaBluetooth = Colors.blueAccent;
      });

      await bluetooth.startDiscovery().listen((event) {

      if(event.device.name != null){
        _deviceList.add(event.device);
      }
      if(event.device.type == BluetoothDeviceType.classic){
          print("Ok aggiungo alla lista");
          print("Stampo la dimensione della lista");
          print(_deviceList.length);
      }
      if(event.device.name == "phLab"){_device = event.device;
          print("Dispositivo trovato!!!!!!!!!!!!");
          //_connettiAlDispositivo(event.device.address);
          //_scrivi(bluetooth, event.device);
      }
      print(event.device); print(event.device.name);
      print(event.device.type); print("-------------------------");
    });

    Future.delayed(const Duration(seconds: 5),() => bluetooth.cancelDiscovery());

  }

  Future<void> _connetti(BluetoothDevice dispositivo) async {

    Color controlloIcona = iconaBluetooth;

    if(controlloIcona == Colors.green){
      messaggioToast("Sei gia' collegato ad un dispositivo", Colors.blueAccent, Toast.LENGTH_LONG);
      return;
    }

    messaggioToast("Tentativo di connessione...", Colors.blueAccent, Toast.LENGTH_SHORT);

    Navigator.of(context).pop();
    print("Connessione a "+ dispositivo.name.toString() + "... ");
    try{

      print("Connessione a " + dispositivo.address.toString());
      _bluetoothConnection = await BluetoothConnection.toAddress(dispositivo.address);
      print(_bluetoothConnection.isConnected ? true : false);

      _bluetoothConnection.input?.listen((event) { print(event.toString());});

      messaggioToast("Connessione effettuata a " + dispositivo.name.toString(), Colors.green, Toast.LENGTH_LONG);
      setState(() {
        iconaBluetooth = Colors.green;
      });

      _bluetoothConnection.output.add(ascii.encode("[0x24]"));

    }
    catch (e){
      setState(() {
        iconaBluetooth = Colors.red;
      });
      messaggioToast("Errore connessione a " + dispositivo.name.toString(), Colors.red, Toast.LENGTH_LONG);
      print(e);
    }

  }

  void _stampaBluetooth () async{
    print("Posso stampare la lista");
    _deviceList.forEach((element) {print(element.name.toString());});
    bluetooth.cancelDiscovery();
    _dialogListaBluetooth(context, _deviceList);
  }

  Widget _listaDispositiviTrovati(){
    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: Wrap(
        children: List.generate(
          _deviceList.length,
              (index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [Text(_deviceList.elementAt(index).name.toString()),TextButton(onPressed: () => _connetti(_deviceList.elementAt(index)), child: Text("Connetti"))],),],
            );
          },
        ),
      )
    );
  }

  Future<void> _dialogListaBluetooth(BuildContext context, List<BluetoothDevice> listaDispositivi) {
    Icon icona = Icon(Icons.info, color: Colors.lightGreen);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row( children: <Widget>[icona ,Text("Dispositivi Trovati")]),
          content: _listaDispositiviTrovati(),
        );
      },
    );
  }

  void _salvaSuDevice(){
    print("Il valore di Flusso Luminoso : " + _flussoLuminoso.toStringAsFixed(2));
    print("Il valore di Temperatura Colore : " + _temperaturaColore.toStringAsFixed(2));

    configurazione.setFlussoLuminoso(_flussoLuminoso);
    configurazione.setTemperaturaColore(_temperaturaColore);
  }

  Future<void> _dialogEffettuaLogout(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Sei sicuro di voler effettuare il logout?\n'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Si'),
              onPressed: () {
                utente.setNomeUtente("");
                utente.setPassword("");
                Navigator.of(context).pop();
                messaggioToast("Hai effettuato il logout", Colors.green, Toast.LENGTH_SHORT);
                //_dialogLogout(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _permessiConcessi() async {
    print("chiamo la fuinzione permesso di localizzazione");
    if(await Permission.location.serviceStatus.isEnabled){
      print("localizzazione abiltiata");
    }
    else {
      print("localizzazione disabilitata");
      messaggioToast("Attiva la localizzazione", Colors.blueAccent, Toast.LENGTH_LONG);
    }

    if(await bluetooth.isEnabled == false){
      messaggioToast("Attiva il Bluetooth", Colors.blueAccent, Toast.LENGTH_LONG);
      bluetooth.openSettings();
    }

    var status = await Permission.location.status;
    if(status.isGranted){
      print("localizzazione concessa");
    }
    else if(status.isDenied){
      print("Localizzazione non concessa");
      messaggioToast("Concedi il permesso di localizzazione", Colors.red, Toast.LENGTH_LONG);
      openAppSettings();
    }
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

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    bool asserzione = true;
    String nomeUtente = utente.getNomeUtente();
    if(nomeUtente == "test"){asserzione = false;}

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double fattoreBluetooth = 1;
    double fattoreTesto = 1;
    double fattoreNavigationBar = 1;
    double fattoreTemperaturaColoreWidth = 1;
    double fattoreTemperaturaColoreAltezza = 1;

    double fattorePaddingAltezza = 1;

    double fattoreImpostazioni = 1;

    if(width > 500){
      fattoreBluetooth = 1.5;
      fattoreTesto = 1.75;
      fattoreNavigationBar = 2;
      fattoreTemperaturaColoreWidth = 2;
      fattoreImpostazioni = 2;
    }

    if(height > 950){
      fattorePaddingAltezza = 3;
      fattoreTemperaturaColoreAltezza = 2;
    }

    double dimensioneIconaBottoneBluetooth = 70 * fattoreBluetooth;
    double dimensioneTesto = 20 * fattoreTesto;
    double dimensioneIconeNavigationBar = 25 * fattoreNavigationBar;

    FileManager.load().then((data)  {
      if((data == "chiaro")){
        setState(() {
          coloreBG = Colors.white;
          coloreAppBar = Colors.white;
          coloreTestoAppBar = Colors.black;
          coloreContronoBluetooth = Colors.black;
          //iconaBluetooth = Colors.blueAccent;
          coloreTesto = Colors.black;
          coloreSlider = Colors.black;
        });
      }
      if((data == "scuro")){
        setState(() {
          coloreBG = Colors.black;
          coloreAppBar = Colors.black;
          coloreTestoAppBar = Colors.blueAccent;
          coloreContronoBluetooth = Colors.blueAccent;
          //iconaBluetooth = Colors.blueAccent;
          coloreTesto = Colors.blueAccent;
          coloreSlider = Colors.white;
        });
      }
    });

    void _paginaPersonale(BuildContext context, bool asserzione){
      if(asserzione){
        Navigator.push(context, MaterialPageRoute<void>(
            builder: (context){
              return Personal();
            }
        ),
        );
      }else{
        _dialogEffettuaLogout(context);
      }

    }

    Icon _iconaAreaPersonale(bool asserzione){
        if(asserzione){
          return Icon(Icons.account_circle, color: coloreTesto,);
        }
        else{
          return Icon(Icons.logout, color: coloreTesto,);
        }
    }

    return SafeArea(child:
        Scaffold(
          backgroundColor: coloreBG,
            bottomNavigationBar:
              BottomNavigationBar(
                  backgroundColor: coloreBG,
                  unselectedItemColor: coloreTesto,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.access_time, size: dimensioneIconeNavigationBar,),
                      label: 'AutoDIM',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.access_time, size: dimensioneIconeNavigationBar),
                      label: 'WhiteDIM',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings, size: dimensioneIconeNavigationBar),
                      label: 'Altre Funzioni',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: coloreTesto,
                  onTap: _onItemTapped,
            ),
        appBar: AppBar(
          backgroundColor: coloreAppBar,
          title:
          SizedBox(
            width: 50 * fattoreImpostazioni,
            height: 50 * fattoreImpostazioni,
            child:
                IconButton(
                    icon :Image.asset("contents/image/logoAppBar.png",),
                    onPressed: _launchUrl,
                ),
          ),
          actions: <Widget>[
            IconButton(
              iconSize: 25 * fattoreImpostazioni,
              onPressed: () => _ricercaBluetooth(),
              icon: Icon(Icons.refresh_rounded, color: coloreTesto),
            ),
            IconButton(
              iconSize: 25 * fattoreImpostazioni,
              onPressed: () => _salvaSuDevice(),
              icon: Icon(Icons.save, color: coloreTesto),
            ),
            IconButton(
                iconSize: 25 * fattoreImpostazioni,
                onPressed: () => _paginaPersonale(context, asserzione),
                icon: _iconaAreaPersonale(asserzione),
            ),
          ],
        ),
        body:
        Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child:
                Container(
                  decoration:
                  BoxDecoration(
                      border: Border.all(color: coloreContronoBluetooth,)
                  ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: iconaBluetooth,
                            shape: BoxShape.circle,
                          ),
                          child:
                          IconButton(
                            //iconSize: 70,
                            iconSize: dimensioneIconaBottoneBluetooth,
                            onPressed: _stampaBluetooth,
                            icon: Image.asset("contents/image/bluetooth_logo_icon_145444.png"),
                            tooltip: "Avvia ricerca bluetooth",
                            color: iconaBluetooth,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),),

              Expanded(
                child:
                  Padding(
                    padding: EdgeInsets.only(top: 25 * fattorePaddingAltezza),
                    child: ListView(
                      children: <Widget>[
                        Container(
                            child:
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(padding: EdgeInsets.only(top: 15 * fattorePaddingAltezza, bottom: 15 * fattorePaddingAltezza), child: Text("- FLUSSO LUMINOSO -", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTesto),),),
                                    Column(
                                      children: <Widget>[
                                            SleekCircularSlider(
                                            innerWidget: (double value) {
                                              _flussoLuminoso = value;
                                              //This the widget that will show current value
                                              return Center(child: Text("${value.toInt().toString()} %", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: coloreSlider),));
                                            },
                                            appearance: CircularSliderAppearance(customColors: CustomSliderColors(progressBarColors: [ Color.fromARGB(
                                                255, 184, 224, 223), Color.fromARGB(255, 225, 128, 0),], trackColor: coloreSlider)),
                                            onChange: (double value) => {_flussoLuminoso = value},
                                          ),
                                      ],
                                    ),

                                    //Gestione autodimming

                                    //Temperatura Colore
                                    Column(
                                      children: <Widget>[
                                        Padding(padding: EdgeInsets.only(bottom: 5 * fattorePaddingAltezza, top: 5 * fattorePaddingAltezza), child: Text("- TEMPERATURA COLORE -", style: TextStyle(color: coloreTesto, fontWeight: FontWeight.bold, fontSize: dimensioneTesto),),),
                                      ],
                                    ),
                                    Row(
                                      children:
                                      <Widget>[
                                        Text("2200 K°", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 15 * fattoreTesto),),
                                        Center(
                                          child: GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onHorizontalDragStart: (DragStartDetails details) {
                                              print("_-------------------------STARTED DRAG");
                                              _colorChangeHandler(details.localPosition.dx);
                                            },
                                            onHorizontalDragUpdate: (DragUpdateDetails details) {
                                              _colorChangeHandler(details.localPosition.dx);
                                            },
                                            onTapDown: (TapDownDetails details) {
                                              _colorChangeHandler(details.localPosition.dx);
                                            },
                                            //This outside padding makes it much easier to grab the   slider because the gesture detector has
                                            // the extra padding to recognize gestures inside of
                                            child: Padding(
                                              padding: EdgeInsets.all(15),
                                              child: Container(
                                                width: widget.width * fattoreTemperaturaColoreWidth,
                                                height: 15 * fattoreTemperaturaColoreAltezza,
                                                decoration: BoxDecoration(
                                                  border: Border.all(width: 2, color: Colors.grey.shade800),
                                                  borderRadius: BorderRadius.circular(15),
                                                  gradient: LinearGradient(colors: _colors),
                                                ),
                                                child: CustomPaint(
                                                  painter: _SliderIndicatorPainter(_colorSliderPosition),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text("5700 K°", style: TextStyle(color: Colors.lightBlue.shade200, fontWeight: FontWeight.bold, fontSize: 15 * fattoreTesto,),),
                                      ],
                                    ),
                                    Container(
                                      height: 25 * fattoreTemperaturaColoreWidth,
                                      width: 25 * fattoreTemperaturaColoreWidth,
                                      decoration: BoxDecoration(
                                        color: _currentColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black),
                                      ),
                                    ),
                                    Text(_temperaturaColore.toStringAsFixed(2), style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: 15 * fattoreTesto,),),
                                  ],
                                )
                              ],
                            )

                        ),
                      ],

                    ),
                  ),
              )
            ]
        ),
    ),);
  }
}

class _SliderIndicatorPainter extends CustomPainter {
  final double position;
  _SliderIndicatorPainter(this.position);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(position, size.height / 2), 12, Paint()..color = Colors.white,);
  }
  @override
  bool shouldRepaint(_SliderIndicatorPainter old) {
    _temperaturaColore = position;
    _temperaturaColore = _temperaturaColore * 17.5;
    _temperaturaColore = _temperaturaColore + 2200;
    return true;
  }
}
