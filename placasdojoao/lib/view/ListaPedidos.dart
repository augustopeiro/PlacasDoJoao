import 'dart:convert';
import 'package:flutter/material.dart';
import '../api/Call_API.dart';
import '../model/Pedido.dart';


class ListaPedidos extends StatefulWidget {
  ListaPedidos({Key? key}) : super(key: key);

  List<Pedido> Pedidos = [];

  @override
  State<ListaPedidos> createState() => _ListaPedidosState();
}

class _ListaPedidosState extends State<ListaPedidos> {
  void initState() {
    super.initState();
    //carregar os usuarios
    _getPedidos();
  }

  //metodo que vai buscar a lista de usuarios
  _getPedidos() async {
    try {
      var response = await CallApi().getData('/pedidos');
      if (response.statusCode == 200) {
        setState(() {
          widget.Pedidos = (json.decode(response.body)['pedidos'] as List)
              .map((data) => new Pedido.fromJson(data))
              .toList();
        });
      } else {
        throw Exception('Falha ao carregar pedidos');
      }
    } on Exception catch (e) {
      //ignore: avoid_print
      print('Erro _getPedidos() [ListaPedidos]: $e');
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
      title: const Text('Pedidos'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildBody() {
    return SafeArea(
        child: Column(
        children: [
        const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Lista de Pedidos',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Expanded(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.Pedidos.isEmpty
            ? const Text('Nenhum pedido')
            : GridView.builder(
                // itemCount: widget.Pedidos.length,
                itemCount: widget.Pedidos.where((pedidoAtivo) => pedidoAtivo == 'true').length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) => Text(
                  widget.Pedidos.where((pedidoAtivo) => pedidoAtivo == 'true').toList()[index].nome,
                ),
              ),
      )
      ),
    ]
    )
    );
  }
}

