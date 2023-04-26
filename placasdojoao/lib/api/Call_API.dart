import 'dart:convert';
import 'package:http/http.dart' as http;



class CallApi{
  final String _url = 'http://192.168.2.228/api';
  String token='';

  _getToken(){
    token = '123457890';
  }

  _setHeaders() => {
    'Accept':'application/json',
    'Content-type':'application/json',
    'Authorization':'Bearer $token'
  };
  

  //envia dados para a API via POST
  postData(data, apiURL) async{
    try{
      _getToken();
      String fullURL = _url + apiURL;
      return await http.post(
        Uri.parse(fullURL),
        body: json.encode(data),
        headers: _setHeaders(),
      );
    } on Exception catch(e){
      //ignore: avoid_print
      print('Erro postData($apiURL)[callApi]');
    }
  }

  //requisita a autenticacao para a api
  authData(data, apiURL) async {
    String fullURL = _url + apiURL;
    return await http.post(
      Uri.parse(fullURL),
      body: json.encode(data),
      headers: _setHeaders(),
    );
  }

  //envia dados para a api via PUT
  putData(data, apiURI) async {
    try{
      _getToken();
      String fullURL = _url + apiURI;
      print(fullURL);
      return await http.put(
        Uri.parse(fullURL),
        body: json.encode(data),
        headers: _setHeaders()
      );
      
    }on Exception catch (e){
      //ignore avoid_print
      print('Erro putData($apiURI) [callApi]: $e');
    }
  }

  //requisita dados para a api via get
  getData(apiURL) async{
    try{
      await _getToken();
      String fullURL = _url + apiURL;
      return await http.get(
        Uri.parse(fullURL),
        headers: _setHeaders()
      );
    }on Exception catch (e){
      //ignore: avoid_print
      print('Erro getData($apiURL)[callApi]: $e');
    }
  }

  
}