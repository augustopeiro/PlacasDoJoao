import '/Home_Page.dart';
import '/Logout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CadastroPage1.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Nav(),
    );
  }
}

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  Widget build(BuildContext context) {
    return 
       Drawer(
        backgroundColor: Colors.black,
        child: Center(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  'Uma Ideia,',                
                  style: TextStyle(
                    fontSize: 30, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text('Uma Placa!',
                style: TextStyle(
                    fontSize: 30, 
                    fontWeight: FontWeight.bold,
                  ),),              
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 35),
              ListTile(
                title: Text('Página inicial', style: TextStyle(color: Colors.white)),
                tileColor: Colors.red,
                onTap: () {
                  Get.to(() => Home_Page());
                },
              ),
              SizedBox(height: 35),
              ListTile(
                title: Text('Sair', style: TextStyle(color: Colors.white)),
                tileColor: Colors.red,
                onTap: () {
                  Get.to(() => Logout());
                },
              ),
              SizedBox(height: 15),
            
              SizedBox(height: 65
              ),
              Image.asset("assets/placasjoaoborda.png", width: 20),
              SizedBox(height: 15),
             
            ],
          ),
        ),
      
    );
  }
}
