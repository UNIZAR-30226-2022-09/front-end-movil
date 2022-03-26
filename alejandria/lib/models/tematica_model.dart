import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Tematica {
  final IconData icon;
  final String name;
  final String dbName;
  bool isSelected;

  Tematica(this.icon, this.name, this.dbName, {this.isSelected = false});

  static List<Tematica> tematicas = [
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
}
