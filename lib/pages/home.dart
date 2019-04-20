import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController weightCtrl = TextEditingController();
  TextEditingController heightCtrl = TextEditingController();

  String _message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              this._resetForm();
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Form(
            key: this._formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person,
                  size: 120,
                  color: Colors.blue,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: this.weightCtrl,
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Insira seu peso!';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Peso (kg)'
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: this.heightCtrl,
                  validator: (value) {
                    if(value.isEmpty){
                      return 'Insira sua altura!';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Altura (cm)'
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text('Calcular'),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () {
                      if(this._formKey.currentState.validate()){
                        this._calcIMC();
                      }
                    },
                  ),
                ),
                Text(
                  this._message ?? '',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        )
      )
    );
  }

  _resetForm(){
    this.weightCtrl.clear();
    this.heightCtrl.clear();
    setState((){
      this._message = null;
    });
  }

  _calcIMC(){
    double weight = double.parse(this.weightCtrl.text);
    double height = double.parse(this.heightCtrl.text) / 100;
    double imc =  weight / (height * 2);
    setState((){
      if(imc < 18.5){
        this._message = 'Abaixo do Peso: ${imc.toStringAsPrecision(4)}';
      }else if(imc >= 18.5 && imc <= 24.9){
        this._message = 'Peso normal: ${imc.toStringAsPrecision(4)}';
      }else if(imc >= 25 && imc <= 29.9){
        this._message = 'Sobrepeso: ${imc.toStringAsPrecision(4)}';
      }else if(imc >= 30 && imc <= 34.9){
        this._message = 'Obesidade grau 1: ${imc.toStringAsPrecision(4)}';
      }else if(imc >= 35 && imc <= 39.9){
        this._message = 'Obesidade grau 2: ${imc.toStringAsPrecision(4)}';
      }else if(imc >= 40){
        this._message = 'Obesidade grau 3: ${imc.toStringAsPrecision(4)}';
      }
    });
  }
}
