import 'package:alejandria/models/tematica_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TematicasProvider with ChangeNotifier {
  String _selectedTematica = 'Preferencias';

  List<Tematica> tematicas = [
    Tematica(FontAwesomeIcons.user, 'Preferencias'),
    Tematica(FontAwesomeIcons.dna, 'Biología'),
    Tematica(FontAwesomeIcons.ruler, 'C. Sociales'),
    Tematica(FontAwesomeIcons.coins, 'Economía'),
    Tematica(FontAwesomeIcons.lightbulb, 'Electrónica'),
    Tematica(FontAwesomeIcons.language, 'Filologia'),
    Tematica(FontAwesomeIcons.book, 'Filosofía'),
    Tematica(FontAwesomeIcons.ruler, 'Física'),
    Tematica(FontAwesomeIcons.accusoft, 'Geología'),
    Tematica(FontAwesomeIcons.landmark, 'Historia'),
    Tematica(FontAwesomeIcons.microchip, 'Informática'),
    Tematica(FontAwesomeIcons.brain, 'Ingeniería'),
    Tematica(FontAwesomeIcons.ruler, 'Matemáticas'),
    Tematica(FontAwesomeIcons.ruler, 'Mecánica'),
    Tematica(FontAwesomeIcons.stethoscope, 'Medicina'),
    Tematica(FontAwesomeIcons.atom, 'Química'),
  ];

  get selectedTemaTica => this._selectedTematica;

  set selectedTematica(String valor) {
    this._selectedTematica = valor;

    //this._isLoading = true;
    //this.getArticlesByCategory( valor );
    notifyListeners();
  }

  set isSelected(int index) {
    this.tematicas[index].isSelected = !this.tematicas[index].isSelected;
    notifyListeners();
  }
}
