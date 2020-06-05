import 'package:common_files/src/model/entities/interfaces.dart';

class Variante implements IEntity {
  int _id;
  int _idPessoaGrupo;
  String _nome;
  String _nomeAvatar;
  int _possuiImagem;
  String _corIcone;
  int _ehDeletado;
  DateTime _dataCadastro;
  DateTime _dataAtualizacao;

  Variante(
      {int id,
      int idPessoaGrupo,
      String nome,
      String nomeAvatar,
      int possuiImagem = 0,
      String corIcone = "0XFF808080",
      int ehDeletado = 0,
      DateTime dataCadastro,
      DateTime dataAtualizacao}) {
    this._id = id;
    this._idPessoaGrupo = idPessoaGrupo;
    this._nome = nome;
    this._nomeAvatar = nomeAvatar;
    this._possuiImagem = possuiImagem;
    this._corIcone = corIcone;
    this._ehDeletado = ehDeletado;
    this._dataCadastro = dataCadastro;
    this._dataAtualizacao = dataAtualizacao;
  }

  int get id => _id;
  set id(int id) => _id = id;
  int get idPessoaGrupo => _idPessoaGrupo;
  set idPessoaGrupo(int idPessoaGrupo) => _idPessoaGrupo = idPessoaGrupo;
  String get nome => _nome;
  set nome(String nome) => _nome = nome;
  String get nomeAvatar => _nomeAvatar;
  set nomeAvatar(String nomeAvatar) => _nomeAvatar = nomeAvatar;
  int get possuiImagem => _possuiImagem;
  set possuiImagem(int possuiImagem) => _possuiImagem = possuiImagem;
  String get corIcone => _corIcone;
  set corIcone(String corIcone) => _corIcone = corIcone;
  int get ehDeletado => _ehDeletado;
  set ehDeletado(int ehDeletado) => _ehDeletado = ehDeletado;
  DateTime get dataCadastro => _dataCadastro;
  set dataCadastro(DateTime dataCadastro) => _dataCadastro = dataCadastro;
  DateTime get dataAtualizacao => _dataAtualizacao;
  set dataAtualizacao(DateTime dataAtualizacao) =>
      _dataAtualizacao = dataAtualizacao;
	  
  Variante.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _idPessoaGrupo = json['id_pessoa_grupo'];
    _nome = json['nome'];
    _nomeAvatar = json['nome_avatar']; 
    _possuiImagem = json['possui_imagem'];
    _corIcone = json['iconecor'];
    _ehDeletado = json['ehdeletado'];
    _dataCadastro = DateTime.parse(json['data_cadastro']);
    _dataAtualizacao = DateTime.parse(json['data_atualizacao']);
  }	  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['idPessoaGrupo'] = this._idPessoaGrupo;
    data['nome'] = this._nome;
    data['nomeAvatar'] = this._nomeAvatar;
    data['possuiImagem'] = this._possuiImagem;
    data['corIcone'] = this._corIcone;
    data['ehDeletado'] = this._ehDeletado;
    data['dataCadastro'] = this._dataCadastro.toString();
    data['dataAtualizacao'] = this._dataAtualizacao.toString();
    return data;
  }
}
