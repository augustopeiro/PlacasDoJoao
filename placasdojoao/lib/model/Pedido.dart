class Pedido{
  //atributos de usuarios retornados pela API (laravel)
  int id;
  String nome;
  String telefone;
  String altura;
  String largura;
  String frase; 
  String corPlaca;
  String corFrase;
  String area;
  String custoMaterial;
  String custoDesenho;
  String valorPlaca;  
  String pedidoAtivo;
  
 

  //construtor
  Pedido({
    required this.id,
    required this.nome, 
    required this.telefone,
    required this.altura,
    required this.largura, 
    required this.frase,  
    required this.corPlaca,
    required this.corFrase,
    required this.area,   
    required this.custoMaterial,
    required this.custoDesenho,
    required this.valorPlaca,       
    required this.pedidoAtivo,
  });

  //dart para json
  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
    id: json["id"],
    nome: json["nome"], 
    telefone: json["telefone"],
    altura: json["altura"],
    largura: json["largura"],  
    frase: json["frase"],
    corPlaca: json["corPlaca"],
    corFrase: json["corFrase"],
    area: json["area"], 
    custoMaterial: json["custoMaterial"],
    custoDesenho: json["custoDesenho"],
    valorPlaca: json["valorPlaca"],    
    pedidoAtivo: json["pedidoAtivo"],
  );

  set data(data) {}

  //json para dart
  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
    "telefone": telefone,
    "altura": altura,
    "largura": largura, 
    "frase": frase,     
    "corPlaca": corPlaca,
    "corFrase": corFrase,
    "area": area,   
    "custoMaterial": custoMaterial,
    "custoDesenho": custoDesenho,
    "valorPlaca": valorPlaca,     
    "pedidoAtivo": pedidoAtivo,
  };

  
}
