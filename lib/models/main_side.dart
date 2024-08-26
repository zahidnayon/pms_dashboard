import 'package:flutter/material.dart';

class MainSide {
  final String title;
  final IconData icon;
  final int index;

  MainSide({
    required this.title,
    required this.icon,
    required this.index,
  });
}

List demoMainSide = [
  MainSide(
      icon: Icons.dashboard_outlined,
      title: "Reservation",
      index: 0
  ),
  MainSide(
      icon: Icons.rocket_outlined,
      title: "Front Office",
      index: 1
  ),
  MainSide(
      icon: Icons.fitness_center_outlined,
      title: "Restaurant",
      index: 2
  ),
  MainSide(
      icon: Icons.email_outlined,
      title: "Housekeeping",
      index: 3
  ),
  MainSide(
      icon: Icons.egg_alt_outlined,
      title: "Procurement",
      index: 4
  ),
  MainSide(
      icon: Icons.egg_alt_outlined,
      title: "Inventory",
      index: 5
  ),
  MainSide(
      icon: Icons.egg_alt_outlined,
      title: "banquet",
      index: 6
  ),
  MainSide(
      icon: Icons.egg_alt_outlined,
      title: "Food Production",
      index: 7
  ),
  MainSide(
      icon: Icons.egg_alt_outlined,
      title: "Spa & Salon",
      index: 8
  ),
  MainSide(
      icon: Icons.egg_alt_outlined,
      title: "Human Resource",
      index: 9
  ),
  MainSide(
      icon: Icons.egg_alt_outlined,
      title: "CRM & Lead",
      index: 10
  ),
  MainSide(
      icon: Icons.egg_alt_outlined,
      title: "Revenue & Budget",
      index: 11
  ),
  MainSide(
      icon: Icons.egg_alt_outlined,
      title: "Boutique",
      index: 12
  ),
  MainSide(
      icon: Icons.egg_alt_outlined,
      title: "Coffe Shop",
      index: 13
  ),
  MainSide(
      icon: Icons.egg_alt_outlined,
      title: "Accounts",
      index: 14
  ),
  MainSide(
      icon: Icons.egg_alt_outlined,
      title: "Back Office",
      index: 15
  ),
];