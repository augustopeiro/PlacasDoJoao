import 'dart:convert';
import '/ListaPedidos.dart';
import '/NovoPedido.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'api/Call_API.dart';
import 'model/Pedido.dart';
//import 'view/ListaPedidos.dart';

class NovoPedido2 extends StatefulWidget {
  NovoPedido2({Key? key, required this.pedido, required this.custoMaterial})
      : super(key: key);

  Pedido pedido;
  double custoMaterial;

  @override
  State<NovoPedido2> createState() => _NovoPedido2State();
}

class _NovoPedido2State extends State<NovoPedido2> {
  late Pedido pedi;
  // List<Pedido> Pedidos = [];


  @override
  initState() {
    pedi = widget.pedido;
    // super.initState();
    // _getPedidos();
  }

  String corFrase = '';
  int numeroLetras = 0;
  double custoDesenho = 0;
  double valorPlaca = 0;  
  bool pedidoAtivo = true;

  TextEditingController campoFrase = TextEditingController();
  TextEditingController campocorFrase = TextEditingController();
  TextEditingController campoArea = TextEditingController();
  TextEditingController campoCustoMaterial = TextEditingController();
  TextEditingController campoCustoDesenho = TextEditingController();
  TextEditingController campoValorPlaca = TextEditingController();
  // TextEditingController campoDataEntrega = TextEditingController();
  TextEditingController campoPedidoAtivo = TextEditingController();

  final dataEntregaController = TextEditingController();

  _Cadastro() {
    setState(() {
      pedi.frase = campoFrase.text;
      pedi.corFrase = campocorFrase.text;
      pedi.custoDesenho = campoCustoDesenho.text;
      pedi.valorPlaca = campoValorPlaca.text;     
      pedi.pedidoAtivo = campoPedidoAtivo.text;
    });    
  }

////////////////////////////////////////////////////////////////////////////////////////////////
  _enviaDados() async {
    try {
      var data = {
        'pedido': pedi,
      };
      var response = await CallApi().putData(data, '/cadastroPedido');
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        pedi.id = body['pedido']['id'];
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Pedido Adicionado'),backgroundColor: Colors.green,));
        Get.to(ListaPedidos());
      } else {
        throw Exception(response.body);
      }
    } on Exception catch (e) {
      print('Erro _enviaDados() [CadastroPedido]: $e');
    }
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
            SizedBox(height: 15),
            TextFormField(
              controller: campoFrase,
              decoration: InputDecoration(
                labelText: "Insira a Frase",
                hintText: 'Insira a Frase',
                prefixIcon: Icon(Icons.text_fields),
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (frase) {
                setState(() {
                  // contar o número de letras digitadas
                  numeroLetras = frase.replaceAll(" ", "").length;
                  calcularDesenho();
                });
              },
              validator: (frase) {
                if (frase == null || frase.isEmpty) {
                  return '* Preenchimento de campo Obrigatório';
                }
                return null;
              },
            ),
            SizedBox(height: 15),
            DropdownButtonFormField<String>(
              value: null,
              decoration: InputDecoration(
                labelText: "Cor da Frase",
                hintText: 'Insira a cor da frase',
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
                  corFrase = newValue!;
                  campocorFrase.text = corFrase.toString();
                  print(corFrase);
                });
              },
              items: <String>['Azul', 'Vermelho', 'Amarelo', 'Preto', 'Verde']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              validator: (corFrase) {
                if (corFrase == null || corFrase.isEmpty) {
                  return '* Preenchimento de campo Obrigatório';
                }
              },
            ),
            SizedBox(height: 35),
            TextFormField(
              controller: campoCustoDesenho,
              decoration: InputDecoration(
                labelText: "Preço da frase",
                hintText: 'Preço da frase',
                prefixIcon: Icon(Icons.width_full),
                filled: true,
                fillColor: Colors.grey[300],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (frase) {
                setState(() {
                  //calcularValorPlaca();
                });
              },
              enabled: false,
            ),
            SizedBox(height: 35),
            TextFormField(
              controller: campoValorPlaca,
              decoration: InputDecoration(
                labelText: "Valor total da Placa",
                hintText: 'Valor total da Placa',
                prefixIcon: Icon(Icons.width_full),
                filled: true,
                fillColor: Colors.grey[300],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
              readOnly: true,
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
                                Get.to(NovoPedido());
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
                                "Confirmar Pedido",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: () {
                                if (Form.of(context).validate() == true) {                                  
                                  _Cadastro();
                                  _enviaDados();
                                  Get.to(ListaPedidos());
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

  void calcularDesenho() {
    numeroLetras;
    const custoFixoDesenho = 0.32;

    custoDesenho = numeroLetras * custoFixoDesenho;
    campoCustoDesenho.text = custoDesenho.toStringAsFixed(2);

    widget.custoMaterial;

    valorPlaca = widget.custoMaterial + custoDesenho;
    campoValorPlaca.text = valorPlaca.toStringAsFixed(2);

    pedidoAtivo = true;
    campoPedidoAtivo.text = pedidoAtivo.toString();   
  }
  
}
