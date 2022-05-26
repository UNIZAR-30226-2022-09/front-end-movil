import 'package:alejandria/models/tematica_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TematicasProvider with ChangeNotifier {
  String _selectedTematica = 'pref';

  List<Tematica> tematicas = [
    Tematica(FontAwesomeIcons.user, 'Preferencias', 'pref'),
    Tematica(FontAwesomeIcons.dna, 'Biología', 'Biologia'),
    Tematica(FontAwesomeIcons.earthEurope, 'C. Sociales', 'C.Sociales'),
    Tematica(FontAwesomeIcons.coins, 'Economía', 'Economia'),
    Tematica(FontAwesomeIcons.lightbulb, 'Electrónica', 'Electronica'),
    Tematica(FontAwesomeIcons.language, 'Filologia', 'Filologia'),
    Tematica(FontAwesomeIcons.book, 'Filosofía', 'Filosofia'),
    Tematica(FontAwesomeIcons.ruler, 'Física', 'Fisica'),
    Tematica(FontAwesomeIcons.gem, 'Geología', 'Geologia'),
    Tematica(FontAwesomeIcons.landmark, 'Historia', 'Historia'),
    Tematica(FontAwesomeIcons.microchip, 'Informática', 'Informatica'),
    Tematica(FontAwesomeIcons.brain, 'Ingeniería', 'Ingenieria'),
    Tematica(FontAwesomeIcons.calculator, 'Matemáticas', 'Matematicas'),
    Tematica(FontAwesomeIcons.gear, 'Mecánica', 'Mecanica'),
    Tematica(FontAwesomeIcons.stethoscope, 'Medicina', 'Medicina'),
    Tematica(FontAwesomeIcons.atom, 'Química', 'Quimica'),
  ];

  get selectedTemaTica => this._selectedTematica;

  set selectedTematica(String valor) {
    this._selectedTematica = valor;
    notifyListeners();
  }

  bool isSelectedTematica(int index) {
    return tematicas[index].isSelected;
  }

  set isSelected(int index) {
    this.tematicas[index].isSelected = !this.tematicas[index].isSelected;
    notifyListeners();
  }

  bool checkData() {
    for (int i = 0; i < tematicas.length; i++) {
      if (tematicas[i].isSelected) return true;
    }
    return false;
  }

  void resetData() {
    for (int i = 0; i < tematicas.length; i++) {
      tematicas[i].isSelected = false;
    }
  }
}
