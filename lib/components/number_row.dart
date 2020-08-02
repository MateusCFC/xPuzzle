import 'package:flutter/material.dart';
import 'package:xPuzzle/components/number_block.dart';

/// Componente que representa uma linha de números
class NumberRow extends StatelessWidget {
  final List<String> _numeros;

  NumberRow(this._numeros);

  List<Widget> _gerarNumeros() {
    List<Widget> _listaNumeros = List();
    _numeros.forEach((numero) {
      _listaNumeros.add(NumberBlock(numero));
    });
    return _listaNumeros;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _gerarNumeros(),
        ));
  }
}
