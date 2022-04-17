import 'package:flutter/material.dart';
import 'package:imc_calc/text_field_custom.dart';

main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String pesoErrorText = 'Deve informar o peso.';
  String alturaErrorText = 'Deve informar a altura.';
  bool pesoIsEmpty = false;
  bool alturaIsEmpty = false;
  String infoTexto = 'Informe seus dados!';
  double fontInfo = 16;
  Color corInfo = Colors.grey;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController alturaController = TextEditingController();

  TextEditingController pesoController = TextEditingController();
  void resetFields() {
    alturaController.text = '';
    pesoController.text = '';
    setState(() {
      fontInfo = 16;
      infoTexto = 'Informe seus dados!';
    });
  }

  void calculate() {
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text) / 100;
    double imc = peso / (altura * altura);
    String imcString = 'Imc: ${imc.toStringAsFixed(1)}';

    if (imc < 18.5) {
      infoTexto = '$imcString \n Abaixo do peso.';
    } else if (imc > 18.5 && imc < 24.9) {
      infoTexto = '$imcString \n Peso normal.';
    } else if (imc > 24.9 && imc < 29.9) {
      infoTexto = '$imcString \n Sobrepeso.';
    } else if (imc > 29.9 && imc < 34.9) {
      infoTexto = '$imcString \n Obesidade grau 1.';
    } else if (imc > 34.9 && imc < 39.9) {
      infoTexto = '$imcString \n Obesidade grau 2.';
    } else if (imc > 39.9) {
      infoTexto = '$imcString \n Obesidade grau 3.';
    }
    setState(() {
      fontInfo = 20;
      corInfo = Colors.white;
      infoTexto = infoTexto;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2F2E2C),
        title: const Text(
          "Calculadora de IMC",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(
              Icons.replay,
              size: 30,
            ),
            onPressed: resetFields,
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 34, 33, 33),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person_rounded,
                  color: Colors.blueGrey,
                  size: 70,
                ),
                TextFieldCustom(
                  errorText: null,
                  infoController: pesoController,
                  label: 'Peso (kg)',
                ),
                TextFieldCustom(
                  errorText: null,
                  infoController: alturaController,
                  label: 'Altura (cm)',
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        child: const Text(
                          "Calcular",
                          style: TextStyle(fontSize: 19),
                        ),
                        onPressed: setData,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  infoTexto,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: corInfo,
                    fontSize: fontInfo,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void setData() {
    if (pesoController.text.isEmpty || alturaController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Informações necessárias."),
          content: const Text("Todos os campos devem ser preenchidos."),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 14),
          actions: [
            TextButton(
              child: const Text(
                'Ok',
                style: TextStyle(color: Color.fromARGB(255, 34, 33, 33)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } else {
      calculate();
    }
    //Limpar textfields
    alturaController.text = '';
    pesoController.text = '';
  }
}
