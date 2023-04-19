class Configurazione{

  double flussoLuminoso = 0;
  double temperaturaColore = 0;
  List<int> autoDim = [];
  List<int> whiteDim = [];

  double getFlussoLuminoso(){return this.flussoLuminoso;}

  void setFlussoLuminoso(double flussoLuminoso){
    this.flussoLuminoso = flussoLuminoso;
  }

  double getTemperaturaColore(){return this.temperaturaColore;}

  void setTemperaturaColore(double temperaturaColore){
    this.temperaturaColore = temperaturaColore;
  }

  List<int> getAutoDim(){
    return this.autoDim;
  }

  void aggiungiAutoDim(int valore){
    this.autoDim.add(valore);
  }

  List<int> getWhiteDim(){
    return this.whiteDim;
  }

  void aggiungiWhiteDim(int valore){
    this.whiteDim.add(valore);
  }
}