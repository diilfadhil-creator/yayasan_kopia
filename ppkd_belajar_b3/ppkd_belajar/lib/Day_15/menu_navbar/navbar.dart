import 'package:flutter/material.dart';
import 'package:ppkd_belajar/Day_14/tugas7saya.dart';
import 'package:ppkd_belajar/Day_15/menu_navbar/about.dart';
import 'package:ppkd_belajar/day_11/extension/navigator.dart';
import 'package:ppkd_belajar/day_11/routing.dart';
import 'package:ppkd_belajar/apk_baziz/login.dart';
import 'package:ppkd_belajar/day_17/service/prefrence_handler.dart';
import 'package:ppkd_belajar/day_18/views/data_user.dart';
import 'package:ppkd_belajar/day_18/views/login_day_18.dart';

class ButtomNavDay13 extends StatefulWidget {
  const ButtomNavDay13({super.key});

  @override
  State<ButtomNavDay13> createState() => _ButtomNavDay13State();
}

class _ButtomNavDay13State extends State<ButtomNavDay13> {
  int _selectedBottom = 0;
  void changeBottom(int index) {
    _selectedBottom = index;
    debugPrint("Ini adalah value dari $_selectedBottom");
    setState(() {});
  }

  final List<Widget> _widgetOptions = [ReferensTugas7NihDul(), DataUserDay18()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          changeBottom(value);
        },
        currentIndex: _selectedBottom,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "User"),
          BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout"),
          // BottomNavigationBarItem(
          //icon: Icon(Icons.business),
          //label: "business",
        ],
      ),
      body: _widgetOptions.elementAt(_selectedBottom),
    );
  }
}

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 1. Menghapus session status login di SharedPreferences lokal.
        PreferenceHandler.logOut();

        // 2. Mengarahkan pengguna kembali ke halaman LoginDay17 serta menghapus seluruh tumpukan navigasi sebelumnya (pushAndRemoveAll).
        context.pushAndRemoveAll(const LoginDay18SQFLITE());
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Anda Telah loguot')));
      },
      child: const Center(child: Icon(Icons.logout, size: 48)),
    );
  }
}
