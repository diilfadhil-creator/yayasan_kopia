import 'package:flutter/material.dart';
import 'package:ppkd_belajar/apk_baziz/login.dart';
import 'package:ppkd_belajar/day_11/extension/navigator.dart';
import 'package:ppkd_belajar/day_11/tugas11.dart';
import 'package:ppkd_belajar/day_17/service/prefrence_handler.dart';
import 'package:ppkd_belajar/day_17/views/login_day_17.dart';
import 'package:ppkd_belajar/day_18/views/data_user.dart';
import 'package:ppkd_belajar/day_9/day9.dart';
import 'package:ppkd_belajar/day_9/tugas9.dart';

class BottomnavDay13 extends StatefulWidget {
  const BottomnavDay13({super.key});

  @override
  State<BottomnavDay13> createState() => _BottomnavDay13State();
}

class _BottomnavDay13State extends State<BottomnavDay13> {
  int _selectedBottom = 0;
  void changeBottom(int index) {
    _selectedBottom = index;
    print("Ini adalah value dari $_selectedBottom");
    setState(() {});
  }

  final List<Widget> _widgetOptions = [
    Login(),
    Tugas11(),
    Tugas9(),
    LogoutScreen(),
    DataUserDay18(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          changeBottom(value);
        },
        currentIndex: _selectedBottom,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school, color: Colors.black),
            label: "school",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business, color: Colors.black),
            label: "business",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout, color: Colors.black),
            label: 'Log Out',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
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
        context.pushAndRemoveAll(const LoginDay17());
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Anda Telah loguot')));
      },
      child: const Center(child: Icon(Icons.logout, size: 48)),
    );
  }
}
