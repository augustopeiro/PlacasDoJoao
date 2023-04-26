import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:password_validator/password_validator.dart';
import 'Home_Page.dart';
import 'Login.dart';
import 'api/Call_API.dart';
import 'model/Administrador.dart';

class CadastroPage1 extends StatefulWidget {
  const CadastroPage1({Key? key}) : super(key: key);
  // Administrador administrador;

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage1> {
  late  Administrador administrador;

  String nome = '';
  String telefone = '';
  String email = '';
  String senha = '';
 

  TextEditingController campoNome = TextEditingController();  
  TextEditingController campoTelefone = TextEditingController();
  TextEditingController campoEmail = TextEditingController();
  TextEditingController campoSenha = TextEditingController();
  TextEditingController campoConfirmaSenha = TextEditingController();

  _Cadastro() {
    setState(() {
      administrador = Administrador(
          id: 0,
          nome: campoNome.text,          
          telefone: campoTelefone.text,
          email: campoEmail.text,
          senha: campoSenha.text,
      ) ;         
    });
  }

  _enviaDados() async {
    try {
      var data = {
        'administrador': administrador,
      };
      var response = await CallApi().putData(data, '/cadastroAdministrador');
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        administrador.id = body['administrador']['id'];           
          Get.off(Home_Page());
        } else {
          throw Exception(response.body);
        }
      
    } on Exception catch (e) {      
      print('Erro _enviaDados() [CadastroAdministrador]: $e');
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
              controller: campoEmail,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: 'Escreva seu email',
                prefixIcon: Icon(Icons.email),
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),              
              validator: (email) => EmailValidator.validate(email)
                  ? null
                  : "Digite um e-mail válido.",
            ),
            SizedBox(height: 15),
            TextFormField(
              obscureText: true,
              controller: campoSenha,
              decoration: InputDecoration(
                labelText: "Senha",
                hintText: 'Crie uma senha',
                prefixIcon: Icon(Icons.key),
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),             
              validator: (senha) {
                PasswordValidator passwordValidator = new PasswordValidator(
                    uppercase: 1,
                    min: 8,
                    digits: 1,
                    blacklist: ["senha", "senh4", "password", "senha123"]);
                if (passwordValidator.validate(senha) == false)
                  return 'Senha deve conter 8 caracteres, 1 número e 1 letra maiúscula';
              },
            ),
            SizedBox(height: 15),
            TextFormField(
              obscureText: true,
              controller: campoConfirmaSenha,
              decoration: InputDecoration(
                labelText: "Confirmação de senha",
                hintText: 'Confirme sua senha',
                prefixIcon: Icon(Icons.key),
                filled: true,
                fillColor: Colors.white,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
              validator: (senha) {
                PasswordValidator passwordValidator = new PasswordValidator(
                    uppercase: 1,
                    min: 8,
                    digits: 1,
                    blacklist: ["senha", "senh4", "password", "senha123"]);
                if (passwordValidator.validate(senha) == false)
                  return 'Senha deve conter ao menos 8 caracteres, 1 número e 1 letra maiúscula';
              },
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
                                Get.to(Login());
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
                                if (campoConfirmaSenha.text ==
                                    campoSenha.text) {
                                  if (Form.of(context).validate() == true) {
                                    _Cadastro();
                                    _enviaDados();
                                    Get.to(Home_Page());
                                  }
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                            title: Text("Senha incorreta"),
                                            content:
                                                Text("As senhas não conferem!"),
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
}
