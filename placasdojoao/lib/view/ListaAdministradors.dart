import 'dart:convert';
import 'package:flutter/material.dart';
import '../model/Administrador.dart';
import '../api/Call_API.dart';


class ListaAdministradors extends StatefulWidget {
  ListaAdministradors({Key? key}) : super(key: key);

  List<Administrador> Administradors = [];

  @override
  State<ListaAdministradors> createState() => _ListaAdministradorsState();
}

class _ListaAdministradorsState extends State<ListaAdministradors> {
  void initState() {
    super.initState();
    //carregar os usuarios
    _getAdministradors();
  }

  //metodo que vai buscar a lista de usuarios
  _getAdministradors() async {
    try {
      var response = await CallApi().getData('/administradors');
      if (response.statusCode == 200) {
        setState(() {
          widget.Administradors = (json.decode(response.body)['administradors'] as List)
              .map((data) => new Administrador.fromJson(data))
              .toList();
        });
      } else {
        throw Exception('Falha ao carregar administradors');
      }
    } on Exception catch (e) {
      //ignore: avoid_print
      print('Erro _getAdministradors() [ListaAdministradors]: $e');
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
      title: const Text('Administradors'),
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
          'Lista de Administradors',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Expanded(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.Administradors.isEmpty
            ? const Text('Nenhum administradors')
            : GridView.builder(
                itemCount: widget.Administradors.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) => Text(
                  widget.Administradors[index].nome,
                ),
              ),
      )
      ),
    ]
    )
    );
  }
}

