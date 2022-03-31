import 'package:flutter/material.dart';

class Tematica {
  final IconData icon;
  final String name;
  final String dbName;
  bool isSelected;

  Tematica(this.icon, this.name, this.dbName, {this.isSelected = false});
}
