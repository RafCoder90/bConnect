class UtenteLogin{
    String _nomeUtente = "x";
    String _password = "";

    void setNomeUtente(String nomeUtente){
        this._nomeUtente = nomeUtente;
    }

    void setPassword(String password){
        this._password = password;
    }

    String getNomeUtente(){
        return this._nomeUtente;
    }

    String getPassword(){
        return this._password;
    }
}