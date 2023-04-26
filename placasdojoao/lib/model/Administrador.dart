class Administrador{
  //atributos de usuarios retornados pela API (laravel)
  int id;
  String nome;
  String telefone;
  String email;
  String senha;
  
  
 

  //construtor
  Administrador({
    required this.id,
    required this.nome, 
    required this.telefone,
    required this.email,
    required this.senha,    
  });

  //dart para json
  factory Administrador.fromJson(Map<String, dynamic> json) => Administrador(
    id: json["id"],
    nome: json["nome"], 
    telefone: json["telefone"],
    email: json["email"],
    senha: json["senha"],  
  );

  //json para dart
  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "telefone": telefone,
    "email": email,
    "senha": senha,      
    
  };

  
}
