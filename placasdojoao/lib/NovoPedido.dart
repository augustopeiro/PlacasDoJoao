import 'dart:convert';
import 'package:brasil_fields/brasil_fields.dart';
import '/Home_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'NovoPedido2.dart';
import 'api/Call_API.dart';
import 'model/Pedido.dart';

class NovoPedido extends StatefulWidget {
  const NovoPedido({super.key});

  @override
  State<NovoPedido> createState() => _NovoPedidoState();
}

class _NovoPedidoState extends State<NovoPedido> {
  late Pedido pedido;

  String corPlaca = '';
  String corFrase = '';
  double altura = 0;
  double largura = 0;
  double area = 0.0;  
  double custoMaterial = 0.0;
  int numeroLetras = 0;
  double custoDesenho = 0;
  double valorPlaca = 0;
  DateTime dataEntrega = DateTime.now();
  bool pedidoAtivo = true;
  //double custoFixoMat = 147.30;
  
  
  TextEditingController campoNome = TextEditingController();
  TextEditingController campoTelefone = TextEditingController();
  TextEditingController campoAltura = TextEditingController();
  TextEditingController campoLargura = TextEditingController();
  TextEditingController campoFrase = TextEditingController();
  TextEditingController campocorPlaca = TextEditingController();
  TextEditingController campocorFrase = TextEditingController();
  TextEditingController campoArea = TextEditingController();
  TextEditingController campoCustoMaterial = TextEditingController();
  TextEditingController campoCustoDesenho = TextEditingController();
  TextEditingController campoValorPlaca = TextEditingController();  
  TextEditingController campoPedidoAtivo = TextEditingController();


  _Cadastro() {
    setState(() {
      pedido = Pedido(
        id: 0,
        nome: campoNome.text,
        telefone: campoTelefone.text,
        altura: campoAltura.text,
        largura: campoLargura.text,
        frase: campoFrase.text,
        corPlaca: campocorPlaca.text,
        corFrase: campocorFrase.text,
        area: campoArea.text,
        custoMaterial: campoCustoMaterial.text,
        custoDesenho: campoCustoDesenho.text,
        valorPlaca: campoValorPlaca.text,        
        pedidoAtivo: campoPedidoAtivo.text,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text("Placas do João", style: TextStyle(color: Colors.white)),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: campoNome,
              decoration: InputDecoration(
                labelText: "Nome",
                hintText: 'Escreva seu nome',
                prefixIcon: Icon(Icons.person),
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
              validator: (nome) {
                if (nome == null || nome.isEmpty) {
                  return '* Preenchimento de campo Obrigatório';
                }
              },
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: campoTelefone,
              decoration: InputDecoration(
                labelText: "Telefone",
                hintText: 'Escreva seu telefone',
                prefixIcon: Icon(Icons.phone_android),
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
              validator: (telefone) {
                if (telefone == null) {
                  return '* Preenchimento de campo Obrigatório';
                }
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TelefoneInputFormatter(),
              ],
            ),
            SizedBox(height: 15),
            TextFormField(
                controller: campoAltura,
                decoration: InputDecoration(
                  labelText: "Altura",
                  hintText: 'Digite altura',
                  prefixIcon: Icon(Icons.height_outlined),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                style: const TextStyle(
                  color: Colors.black,
                ),
                validator: (altura) {
                  if (altura == null || altura.isEmpty) {
                    return '* Preenchimento de campo Obrigatório';
                  }
                },
                onChanged: (value) {
                  setState(() {
                    _calcularArea();
                  });
                }),
            SizedBox(height: 15),
            TextFormField(
                controller: campoLargura,
                decoration: InputDecoration(
                  labelText: "Largura",
                  hintText: 'Digite Largura',
                  prefixIcon: Icon(Icons.width_wide_outlined),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                style: const TextStyle(
                  color: Colors.black,
                ),
                validator: (largura) {
                  if (largura == null || largura.isEmpty) {
                    return '* Preenchimento de campo Obrigatório';
                  }
                },
                onChanged: (value) {
                  setState(() {
                    _calcularArea();
                  });
                }),
                SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: null,
              decoration: InputDecoration(
                labelText: "Cor da Placa",
                hintText: 'Insira a cor da placa',
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              onChanged: (String? newValue) {
                setState(() {
                  corPlaca = newValue!;
                  campocorPlaca.text = corPlaca.toString();
                });
              },
              items: <String>['Branca', 'Cinza']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              validator: (corPlaca) {
                if (corPlaca == null || corPlaca.isEmpty) {
                  return '* Preenchimento de campo Obrigatório';
                }
              },
            ),
            SizedBox(height: 15),
            TextFormField(
                controller: campoArea,
                decoration: InputDecoration(
                  labelText: "Area",
                  hintText: 'Area',
                  prefixIcon: Icon(Icons.width_wide_outlined),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                style: const TextStyle(
                  color: Colors.black,
                ),                
                onChanged: (value) {
                  setState(() {
                  // _calcularCustoMaterial();
                  });
                }),
                SizedBox(height: 15),
            TextFormField(
              controller: campoArea,
              decoration: InputDecoration(
                labelText: "Area da placa",
                hintText: 'Area da Placa',
                prefixIcon: Icon(Icons.width_full),
                filled: true,
                fillColor: Colors.grey[300],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),              
              enabled: false,
              onChanged: (value) {
                  setState(() {
                    //_calcularCustoMaterial();
                     //print(area);
                    // print(custoMaterial);
                  });
                }               
            ),            
            SizedBox(height: 15),
            TextFormField(
              controller: campoCustoMaterial,
              decoration: InputDecoration(
                labelText: "Custo da placa",
                hintText: 'Custo da placa',
                prefixIcon: Icon(Icons.width_full),
                filled: true,
                fillColor: Colors.grey[300],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),              
              enabled: false,                           
            ),            
            SizedBox(height: 35),
            Builder(builder: (context) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          height: 60,
                          width: 165,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.3, 1],
                              colors: [
                                Color.fromARGB(255, 245, 36, 36),
                                Color.fromARGB(255, 249, 43, 43),
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: SizedBox.expand(
                            child: TextButton(
                              child: Text(
                                "Voltar",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              onPressed: () {
                                Get.to(Home_Page());
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(
                          height: 60,
                          width: 165,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.3, 1],
                              colors: [
                                Color.fromARGB(255, 245, 36, 36),
                                Color.fromARGB(255, 249, 43, 43),
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: SizedBox.expand(
                            child: TextButton(
                              child: Text(
                                "Próximo",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              onPressed: () {
                                if (Form.of(context).validate() == true) {
                                  print(campocorPlaca);
                                  _Cadastro();
                                  //_calcularCustoMaterial();
                                  print(campoArea);
                    print(custoMaterial);
                                  Get.to(NovoPedido2(
                                    pedido: pedido,
                                   custoMaterial: custoMaterial                                     
                                  ));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                            title: Text("Ops!!!"),
                                            content: Text(
                                                "Preencha todos os campos"),
                                          ));
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _calcularArea() {
    altura = double.parse(campoAltura.text);
    largura = double.parse(campoLargura.text);

    double area = altura * largura;
    campoArea.text = area.toStringAsFixed(2);

    const custoFixoMat = 147.30;

    custoMaterial = area * custoFixoMat;
    campoCustoMaterial.text = custoMaterial.toStringAsFixed(2);
  }

  // void _calcularCustoMaterial() {
  //   area = double.parse(campoArea.text);
  //   custoFixoMat = double.parse(campocusto.text);;

  //   custoMaterial = area * custoFixoMat;
  //   campoCustoMaterial.text = custoMaterial.toStringAsFixed(2);
  // }
  //   area;
  //   const custoFixoMat = 0.32;

  //   custoMaterial = area * custoFixoMat;
  //   campoCustoMaterial.text = custoMaterial.toStringAsFixed(2);



}
