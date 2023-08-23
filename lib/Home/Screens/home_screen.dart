import 'package:calculadoraimc/Home/models/home_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ImcModel> listImc = [];
  final key = GlobalKey<FormState>();
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();

  String imcCategoria(double imc) {
    if (imc < 16) {
      return 'Magreza leve';
    } else if (imc < 17) {
      return 'Magreza moderada';
    } else if (imc < 18.5) {
      return 'Magreza leve';
    } else if (imc < 25) {
      return 'Peso normal';
    } else if (imc < 30) {
      return 'Sobrepeso';
    } else if (imc < 35) {
      return 'Obesidade grau I';
    } else if (imc < 40) {
      return 'Obesidade grau II';
    } else if (imc > 40) {
      return 'Obesidade grau III (Mórbida)';
    } else {
      return "procure um medico urgente";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora IMC"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Form(
                key: key,
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Peso (kg)'),
                      controller: pesoController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Preencha o campo Ex:80 Kg";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Altura '),
                      controller: alturaController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Preencha o campo Ex:1.80 altura";
                        }
                        return null;
                      },
                    ),
                  ],
                )),
          ),
          ElevatedButton(
            onPressed: () {
              if (key.currentState!.validate()) {
                double peso = double.tryParse(pesoController.text
                        .replaceAll(',', '.')
                        .replaceAll(',', '.')) ??
                    0;
                double altura = double.tryParse(alturaController.text
                        .replaceAll(',', '.')
                        .replaceAll(',', '.')) ??
                    0;
                double imc = peso / (altura * altura);
                String categoria = imcCategoria(imc);
                ImcModel result = ImcModel(
                    peso: peso, altura: altura, imc: imc, categoria: categoria);

                setState(() {
                  listImc.add(result);
                });

                alturaController.clear();
                pesoController.clear();
              }
            },
            child: Text(
              "Calcular meu imc",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: listImc.length,
              itemBuilder: (context, index) {
                ImcModel result = listImc[index];
                return Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text('IMC: ${result.imc.toStringAsFixed(2)}'),
                    subtitle: Text(
                      'Peso: ${result.peso} kg, Altura: ${result.altura} \nCategoria: ${result.categoria}',
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
