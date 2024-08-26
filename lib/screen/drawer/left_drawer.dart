import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pms_dashboard/conostants.dart';
import 'package:pms_dashboard/models/main_side.dart';

class LeftDrawer extends StatefulWidget {
  const LeftDrawer({Key? key}) : super(key: key);

  @override
  State<LeftDrawer> createState() => _LeftDrawerState();
}

class _LeftDrawerState extends State<LeftDrawer> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Container(
                child: Text(
                  'Menu',
                  style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: demoMainSide.length,
                itemBuilder: (context, index) {
                  return ListTile1(index,demoMainSide[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container ListTile1(int index,MainSide mainSide) {
    return Container(
      decoration: BoxDecoration(
        color: _selectedIndex == index
            ? Color(0xFFCCEDDD)
            : Colors.transparent,
        gradient: LinearGradient(
          colors: [
            Color(0xFF58D9D9),
            Color(0xFF5747EF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
                child: ListTile(
                  hoverColor: Color(0xFFCCEDDD),
                  onTap: () {
                    setState(() {
                      _selectedIndex = mainSide.index;
                    });
                  },
                  leading: SizedBox(
                    height: 30,
                    width: 30,
                    child: Icon(
                      mainSide.icon,
                      color: _selectedIndex == index
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  title: Text(
                    mainSide.title,
                    style: GoogleFonts.ubuntu(
                      color: _selectedIndex == index
                          ? Colors.black
                          : Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
  }
}
