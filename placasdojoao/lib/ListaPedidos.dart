import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'NavBar.dart';
import 'api/Call_API.dart';
import 'model/Pedido.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

//import 'view/ListaPedidos.dart';

class ListaPedidos extends StatefulWidget {
  @override
  _ListaPedidosState createState() => _ListaPedidosState();
}

class _ListaPedidosState extends State<ListaPedidos> {
  List<Pedido> pedidos = [];
  DateTime _dataEntrega = DateTime.now();
  DateTime _proximoLote = DateTime.now().add(Duration(days: 1));

  @override
  void initState() {
    super.initState();
    buscarPedidos().then((pedidos) {
      setState(() {
        this.pedidos = pedidos.where((p) => p.pedidoAtivo == 'true').toList();
        this.pedidos.sort((a, b) => a.id.compareTo(b.id));

        List<DateTime> datasEntrega = [];
        for (int i = 0; i < this.pedidos.length; i++) {
          if (i % 6 == 0) {
            for (int j = i; j < i + 6 && j < this.pedidos.length; j++) {
              datasEntrega.add(_dataEntrega);
            }
            _dataEntrega = _proximoLote;
            _proximoLote = _proximoLote.add(Duration(days: 1));
          }
        }

        // for (int i = 0; i < this.pedidos.length; i++) {
        //   this.pedidos[i] = datasEntrega[i];
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text("Placas do João", style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        itemCount: pedidos.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(pedidos[index].toString()),
            direction: DismissDirection.startToEnd,
            onDismissed: (direction) {
              setState(() {
                _atualizarEstadoPedido;
                pedidos[index].pedidoAtivo == 'false';
                pedidos.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Pedido Concluído'),
                backgroundColor: Colors.green,
              ));
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Detalhes do pedido"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nome: ${pedidos[index].nome}"),
                            Text("Telefone: ${pedidos[index].telefone}"),
                            Text("Altura: ${pedidos[index].altura} m"),
                            Text("Largura: ${pedidos[index].largura} m"),
                            Text("Área: ${pedidos[index].area} m"),
                            Text("Cor da placa: ${pedidos[index].corPlaca}"),
                            Text("Frase: ${pedidos[index].frase}"),
                            Text("Cor da frase: ${pedidos[index].corFrase}"),
                            Text("Data de Entrega: ${DateFormat('dd/MM/yyyy').format(_dataEntrega)}"),
                            Text("Valor: R\$ ${pedidos[index].valorPlaca}"),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {                             
                              Printing.layoutPdf(                                
                                onLayout: (PdfPageFormat format) {                                  
                                  return buildPdf(
                                      format,
                                      pedidos[index].nome,
                                      pedidos[index].telefone,
                                      pedidos[index].altura,
                                      pedidos[index].largura,
                                      pedidos[index].area,
                                      pedidos[index].corPlaca,
                                      pedidos[index].frase,
                                      pedidos[index].corFrase,
                                      _dataEntrega,
                                      pedidos[index].valorPlaca);
                                },
                              );
                              Navigator.of(context).pop();
                            },
                            child: Text("Nota Fiscal"),
                          ),
                          TextButton(
                            onPressed: () async {
                              await _atualizarEstadoPedido;
                              Navigator.of(context).pop();
                            },
                            child: Text("Concluir Pedido"),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Fechar"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text(pedidos[index].nome),
                    subtitle: Text(pedidos[index].frase),
                    trailing: Text(
                      "R\$ ${pedidos[index].valorPlaca}",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<Uint8List> buildPdf(
      PdfPageFormat format,
      String nome,
      String telefone,
      String altura,
      String largura,
      String area,
      String corPlaca,
      String frase,
      String corFrase,
      DateTime dataEntrega,
      String valorPlaca) async {
    final pw.Document doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.ConstrainedBox(
            constraints: pw.BoxConstraints.expand(),
            child: pw.Container(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text("Nome: $nome"),
                  pw.Text("Telefone: $telefone"),
                  pw.Text("Altura: $altura m"),
                  pw.Text("Largura: $largura m"),
                  pw.Text("Área: $area m"),
                  pw.Text("Cor da placa: $corPlaca"),
                  pw.Text("Frase: $frase"),
                  pw.Text("Cor da frase: $corFrase"),
                  pw.Text("Data de Entrega: ${DateFormat('dd/MM/yyyy').format(dataEntrega)}"),
                  pw.Text("Valor: R\$ $valorPlaca"),
                ],
              ),
            ),
          );
        }));    
    return await doc.save();
  }
}

Future<List<Pedido>> buscarPedidos() async {
  try {
    var response = await CallApi().getData('/allPedidos');
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      return List<Pedido>.from(
          body['pedidos'].map((pedido) => Pedido.fromJson(pedido)));
    } else {
      throw Exception(response.body);
    }
  } on Exception catch (e) {
    print('Erro buscarPedidos(): $e');
    return [];
  }
}

_atualizarEstadoPedido(pedidos) async {
  try {
    var data = {
      'id': pedidos.id,
      'pedidoAtivo': pedidos.pedidoAtivo,
    };
    var response = await CallApi().putData(data, '/atualizaPedido');
    if (response.statusCode == 200) {
      // setState(() {
      //   pedidos.pedidoAtivo = 'false';
      // });
    } else {
      throw Exception(response.body);
    }
  } on Exception catch (e) {
    print('Erro _updatePedidoAtivo(): $e');
  }
}




