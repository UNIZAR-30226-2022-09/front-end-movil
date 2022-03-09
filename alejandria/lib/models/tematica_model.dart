import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Tematica {
  final IconData icon;
  final String name;
  bool isSelected;

  Tematica(this.icon, this.name, {this.isSelected = false});

  static List<Tematica> tematicas = [
    Tematica(FontAwesomeIcons.ruler, 'Matemáticas'),
    Tematica(FontAwesomeIcons.ruler, 'Física'),
    Tematica(FontAwesomeIcons.atom, 'Química'),
    Tematica(FontAwesomeIcons.dna, 'Biología'),
    Tematica(FontAwesomeIcons.accusoft, 'Geología'),
    Tematica(FontAwesomeIcons.stethoscope, 'Medicina'),
    Tematica(FontAwesomeIcons.microchip, 'Informática'),
    Tematica(FontAwesomeIcons.ruler, 'Mecánica'),
    Tematica(FontAwesomeIcons.lightbulb, 'Electrónica'),
    Tematica(FontAwesomeIcons.brain, 'Ingeniería'),
    Tematica(FontAwesomeIcons.coins, 'Economía'),
    Tematica(FontAwesomeIcons.landmark, 'Historia'),
    Tematica(FontAwesomeIcons.book, 'Filosofía'),
    Tematica(FontAwesomeIcons.language, 'Filologia'),
    Tematica(FontAwesomeIcons.ruler, 'C. Sociales'),
  ];
}
