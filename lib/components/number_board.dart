import 'package:flutter/material.dart';
import 'package:xPuzzle/components/number_row.dart';

/// Componente que representa o tabuleiro de números
class NumberBoard extends StatefulWidget {
  @override
  _NumberBoardState createState() => _NumberBoardState();
}

class _NumberBoardState extends State<NumberBoard> {
  List<List<String>> _numeros = List<List<String>>();
  List<Widget> _widgetNumeros = List();

  @override
  void initState() {
    _gerarNumeros();
    _widgetNumeros = _gerarLinhas();
    super.initState();
  }

  /// Callback enviada para os botões que recebe ação de apertar o botão,
  /// indicando o botão apertado em [botao]
  void _apertarBotao(String botao) {
    List<int> _posicao = _recuperarPosicao(botao);
    String _movimento = _direcaoMovimento(_posicao);
    if (_movimento != 'X') {
      String aux;
      switch (_movimento) {
        case 'T':
          setState(() {
            aux = _numeros[_posicao[0]][_posicao[1]];
            _numeros[_posicao[0]][_posicao[1]] =
                _numeros[_posicao[0] - 1][_posicao[1]];
            _numeros[_posicao[0] - 1][_posicao[1]] = aux;
            _widgetNumeros = _gerarLinhas();
          });
          print(_numeros);
          break;
        case 'D':
          setState(() {
            aux = _numeros[_posicao[0]][_posicao[1]];
            _numeros[_posicao[0]][_posicao[1]] =
                _numeros[_posicao[0]][_posicao[1] + 1];
            _numeros[_posicao[0]][_posicao[1] + 1] = aux;
            _widgetNumeros = _gerarLinhas();
          });
          print(_numeros);
          break;
        case 'B':
          setState(() {
            aux = _numeros[_posicao[0]][_posicao[1]];
            _numeros[_posicao[0]][_posicao[1]] =
                _numeros[_posicao[0] + 1][_posicao[1]];
            _numeros[_posicao[0] + 1][_posicao[1]] = aux;
            _widgetNumeros = _gerarLinhas();
          });
          print(_numeros);
          break;
        case 'E':
          setState(() {
            aux = _numeros[_posicao[0]][_posicao[1]];
            _numeros[_posicao[0]][_posicao[1]] =
                _numeros[_posicao[0]][_posicao[1] - 1];
            _numeros[_posicao[0]][_posicao[1] - 1] = aux;
            _widgetNumeros = _gerarLinhas();
          });
          print(_numeros);
          break;
        default:
      }
    }
  }

  /// Recupera a posição de [numero] na matriz de números, retornando uma
  /// lista no formato [linha, coluna]
  List<int> _recuperarPosicao(String numero) {
    for (var i = 0; i < 4; i++) {
      for (var j = 0; j < 4; j++) {
        if (_numeros[i][j] == numero) {
          return [i, j];
        }
      }
    }
    throw ('Número não encontrado');
  }

  /// Retorna a possível direção que o elemento na [posicao] poderá se mover,
  /// no formato 'T' (para cima), 'D' (direita), 'B' (baixo), 'E' (esquerda) ou 'X'
  /// caso o elemento não possa se mover
  String _direcaoMovimento(List<int> posicao) {
    int _i = posicao[0];
    int _j = posicao[1];
    List<String> _movimentos = List();
    try {
      _movimentos.add(_numeros[_i - 1][_j]);
    } on RangeError {
      _movimentos.add('X');
    }
    try {
      _movimentos.add(_numeros[_i][_j + 1]);
    } on RangeError {
      _movimentos.add('X');
    }
    try {
      _movimentos.add(_numeros[_i + 1][_j]);
    } on RangeError {
      _movimentos.add('X');
    }
    try {
      _movimentos.add(_numeros[_i][_j - 1]);
    } on RangeError {
      _movimentos.add('X');
    }
    for (var i = 0; i < 4; i++) {
      if (_movimentos[i] == '') {
        if (i == 0) return 'T';
        if (i == 1) return 'D';
        if (i == 2) return 'B';
        if (i == 3) return 'E';
      }
    }
    return 'X';
  }

  /// Gera a lista de números com valores embaralhados ou a partir de uma determinada
  /// [lista] passada como argumento
  void _gerarNumeros([List<String> lista]) {
    List<String> _listaNumeros;
    if (lista == null) {
      _listaNumeros = [for (var i = 1; i < 16; i++) i.toString()];
    } else {
      _listaNumeros = lista;
    }
    _listaNumeros.add('');
    _listaNumeros.shuffle();
    _numeros.add(_listaNumeros.sublist(0, 4));
    _numeros.add(_listaNumeros.sublist(4, 8));
    _numeros.add(_listaNumeros.sublist(8, 12));
    _numeros.add(_listaNumeros.sublist(12, 16));
  }

  /// Gera as linhas de números a partir da divisão da lista de números
  List<Widget> _gerarLinhas() {
    List<Widget> _linhas = List();
    _linhas.add(NumberRow(_numeros[0], _apertarBotao));
    _linhas.add(NumberRow(_numeros[1], _apertarBotao));
    _linhas.add(NumberRow(_numeros[2], _apertarBotao));
    _linhas.add(NumberRow(_numeros[3], _apertarBotao));
    return _linhas;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _widgetNumeros),
        flex: 4);
  }
}