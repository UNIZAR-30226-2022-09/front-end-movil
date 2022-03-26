import 'package:alejandria/models/tematica_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TematicasProvider with ChangeNotifier {
  String _selectedTematica = 'Preferencias';

  List<Tematica> tematicas = [
    Tematica(FontAwesomeIcons.dna, 'Biología', 'Biiologia'),
    Tematica(FontAwesomeIcons.ruler, 'C. Sociales', 'C. Sociales'),
    Tematica(FontAwesomeIcons.coins, 'Economía', 'Economia'),
    Tematica(FontAwesomeIcons.lightbulb, 'Electrónica', 'Electronica'),
    Tematica(FontAwesomeIcons.language, 'Filologia', 'Filologia'),
    Tematica(FontAwesomeIcons.book, 'Filosofía', 'Filosofia'),
    Tematica(FontAwesomeIcons.ruler, 'Física', 'Fisica'),
    Tematica(FontAwesomeIcons.accusoft, 'Geología', 'Geologia'),
    Tematica(FontAwesomeIcons.landmark, 'Historia', 'Historia'),
    Tematica(FontAwesomeIcons.microchip, 'Informática', 'Informatica'),
    Tematica(FontAwesomeIcons.brain, 'Ingeniería', 'Ingenieria'),
    Tematica(FontAwesomeIcons.ruler, 'Matemáticas', 'Matematicas'),
    Tematica(FontAwesomeIcons.ruler, 'Mecánica', 'Mecanica'),
    Tematica(FontAwesomeIcons.stethoscope, 'Medicina', 'Medicina'),
    Tematica(FontAwesomeIcons.atom, 'Química', 'Quimica'),
  ];

  get selectedTemaTica => this._selectedTematica;

  set selectedTematica(String valor) {
    this._selectedTematica = valor;
    notifyListeners();
  }

  set isSelected(int index) {
    this.tematicas[index].isSelected = !this.tematicas[index].isSelected;
    notifyListeners();
  }

  bool checkData() {
    tematicas.map((value) {
      if (value.isSelected == true) return true;
    });

    return false;
  }

  void resetData() {
    tematicas.map((value) => value.isSelected = false);
  }
}
