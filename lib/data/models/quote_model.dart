class QuoteModel {

  //Definir elementos que vão compor esta classe
  final String trecho;
  final String livro;
  final String explicacao;

   //Construtor da classe
   QuoteModel({
     required this.trecho,
     required this.livro,
     required this.explicacao,
   });

  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    return QuoteModel(
      trecho: map['trecho'] ?? '',
      livro: map['livro'] ?? '',
      explicacao: map['explicacao'] ?? '',
    );
  }
}