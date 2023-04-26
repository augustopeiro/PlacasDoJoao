import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ListaPedidos.dart';
import 'NavBar.dart';
import 'NovoPedido.dart';
import 'api/Call_API.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

//import 'view/ListaPedidos.dart';


class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       drawer: NavBar(),
        appBar: AppBar(
          title: Text('Placas do João'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),       
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  child: Text('+ Adicionar um pedido',
                  style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () => Get.to(() => NovoPedido()),
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, 
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  child: Text('Ver lista de pedidos', 
                  style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () => Get.to(() => ListaPedidos()),
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, 
                  ),
                ),
              ),
            ],
          ),
        ),     
      );
  }
}