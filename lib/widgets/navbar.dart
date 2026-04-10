import 'package:absensi_ppkd/view/beranda/beranda.dart';
import 'package:absensi_ppkd/view/profile.dart/profile.dart';
import 'package:absensi_ppkd/view/riwayat/riwayat.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _PelangganNavbarState();
}

class _PelangganNavbarState extends State<Navbar> {
  int _currentIndex = 0;

  Color activeColor = const Color(0xFF32B2B2);
  Color inactiveColor = Colors.black.withOpacity(0.6);

  void ontapItem(int index) {
    /// LIST NAMA NAVBAR
    List<String> navbarNames = ["Beranda", "Riwayat", "Profile"];

    /// PRINT KE CONSOLE
    print("Navbar ${navbarNames[index]} diklik (index: $index)");

    /// PINDAH HALAMAN
    setState(() {
      _currentIndex = index;
    });
  }

  static List<Widget> listWidget = [Beranda(), Riwayat(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,

      body: Stack(
        children: [
          /// HALAMAN
          listWidget.elementAt(_currentIndex),

          /// NAVBAR FLOATING
          Positioned(
            left: 12,
            right: 12,
            bottom: 5 + MediaQuery.of(context).padding.bottom,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFC8F0F0),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: GNav(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    gap: 3,
                    backgroundColor: const Color(0xFFC8F0F0),

                    color: inactiveColor,
                    activeColor: activeColor,

                    tabBackgroundColor: const Color(
                      0xFF32B2B2,
                    ).withOpacity(0.20),

                    selectedIndex: _currentIndex,
                    onTabChange: ontapItem,

                    tabs: [
                      GButton(
                        icon: Icons.circle,
                        leading: Image.asset(
                          "assets/images/navbar/beranda.png",
                          width: 25,
                          height: 24,
                          color: _currentIndex == 0
                              ? activeColor
                              : inactiveColor,
                        ),
                        text: "Beranda",
                      ),
                      GButton(
                        icon: Icons.circle,
                        leading: Image.asset(
                          "assets/images/navbar/riwayat.png",
                          width: 25,
                          height: 25,
                          color: _currentIndex == 1
                              ? activeColor
                              : inactiveColor,
                        ),
                        text: "Riwayat",
                      ),
                      GButton(
                        icon: Icons.circle,
                        leading: Image.asset(
                          "assets/images/navbar/profile.png",
                          width: 25,
                          height: 23,
                          color: _currentIndex == 2
                              ? activeColor
                              : inactiveColor,
                        ),
                        text: "Profile",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
