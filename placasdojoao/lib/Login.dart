import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CadastroPage1.dart';
import 'Home_Page.dart';
import 'api/Call_API.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = '';
  String senha = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/placasjoaoborda.png", width: 800),      
                
                
                SizedBox(height: 60),
                TextField(
                  onChanged: (text) {
                    email = text;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
                SizedBox(height: 15),
                TextField(
                  onChanged: (text) {
                    senha = text;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Senha',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                ),
                SizedBox(height: 35),
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 175,
                      alignment: Alignment.centerLeft,
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
                            "Entrar",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          onPressed: () {                            
                              _validarLogin();                            
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      height: 60,
                      width: 175,
                      alignment: Alignment.centerLeft,
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
                            "Cadastrar",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          onPressed: () {
                            Get.to(CadastroPage1());
                          },
                        ),
                      ),
                    ),
                  ],
                ),               
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validarLogin() async {
    try {
      var data = {
        'email': email,
        'senha': senha,
      };
      var response = await CallApi().putData(data, '/verificaAdministrador');
      if (response.statusCode == 200) {
        print(response.body);
        Get.off(Home_Page());
      } else {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Falha no login"),
                  content: Text("Email ou senha inválida!"),
                ));
      }
    } on Exception catch (e) {
      //ignore: avoid_print
      print('Erro _validarLogin() [Login]: $e');
    }
  }
}