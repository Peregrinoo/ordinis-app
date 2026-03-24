class QuoteModel {

  //Definir elementos que vão compor esta classe
   String _trecho = "";
   String _livro = "";
   String _explicacao = "";

   //Construtor da classe
   QuoteModel(this._trecho, this._livro, this._explicacao);

  //Setters
  String get trecho => _trecho;
  String get livro => _livro;
  String get explicacao => _explicacao;

}