import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Tematica {
  final IconData icon;
  final String name;
  bool isSelected;

  Tematica(this.icon, this.name, {this.isSelected = false});

  static List<Tematica> tematicas = [
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
}
