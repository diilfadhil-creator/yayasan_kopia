import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

// Model Data UserModelSQL untuk merepresentasikan struktur kolom tabel 'users' pada database SQLite.
class UserModelSQL {
  final int? id; // Primary Key tabel (auto-increment)
  final String email; // Email pengguna (unik)
  final String password; // Password pengguna
  final String? nomorHp;
  final String? asalKota; // Nomor HP pengguna (opsional)

  UserModelSQL({
    this.id,
    required this.email,
    required this.password,
    this.nomorHp,
    this.asalKota,
  });

  // Mengonversi objek UserModelSQL menjadi Map<String, dynamic>
  // Format Map ini digunakan oleh sqflite untuk operasi insert/update ke database SQLite.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'password': password,
      'nomor_hp': nomorHp,
      'asal_kota': asalKota,
    };
  }

  // Factory constructor untuk membuat instance UserModelSQL dari Map hasil query SQLite.
  factory UserModelSQL.fromMap(Map<String, dynamic> map) {
    return UserModelSQL(
      id: map['id'] != null ? map['id'] as int : null,
      email: map['email'] as String,
      password: map['password'] as String,
      nomorHp: map['nomor_hp'] != null ? map['nomor_hp'] as String : null,
      asalKota: map['asal_kota'] != null ? map['asal_kota'] as String : null,
    );
  }

  // Mengonversi objek menjadi format string JSON.
  String toJson() => json.encode(toMap());

  // Factory constructor untuk membuat instance UserModelSQL dari string JSON.
  factory UserModelSQL.fromJson(String source) =>
      UserModelSQL.fromMap(json.decode(source) as Map<String, dynamic>);
}
