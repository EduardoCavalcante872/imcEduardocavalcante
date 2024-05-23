import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IMC Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IMCCalculator(),
    );
  }
}

class IMCCalculator extends StatefulWidget {
  @override
  _IMCCalculatorState createState() => _IMCCalculatorState();
}

class _IMCCalculatorState extends State<IMCCalculator> {
  double _peso = 0;
  double _altura = 0;
  double _imc = 0;

  void setPeso(double value) {
    setState(() {
      _peso = value;
    });
  }

  void setAltura(double value) {
    setState(() {
      _altura = value;
    });
  }

  void calculateImc() {
    if (_peso > 0 && _altura > 0) {
      setState(() {
        _imc = _peso / (_altura * _altura);
      });
    }
  }

  String getStatus() {
    if (_imc < 18.5) {
      return 'Abaixo do Peso';
    } else if (_imc >= 18.5 && _imc < 25) {
      return 'Peso Ideal';
    } else if (_imc >= 25 && _imc < 30) {
      return 'Acima do Peso';
    } else if (_imc >= 30) {
      return 'Obesidade';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMC Calculator', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.red],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) {
                setPeso(double.parse(value));
              },
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Altura (m)',
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) {
                setAltura(double.parse(value));
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Calcular', style: TextStyle(color: Colors.white)),
              onPressed: () {
                calculateImc();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
                overlayColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Colors.red;
                    return Colors.blue; 
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              '$_imc',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            SizedBox(height: 20),
            Text(
              '${getStatus()}',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
