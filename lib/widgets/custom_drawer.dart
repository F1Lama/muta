import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:map/screens/login_employee_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:typed_data';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

// استيراد الشاشات المناسبة
import 'package:map/screens/BarcodeScannerScreen.dart';
import 'package:map/screens/add_parents_screen.dart';
import 'package:map/screens/add_students_screen.dart';
import 'package:map/screens/add_teachers_screen.dart';
import 'package:map/screens/login_screen.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isLoading = false;

  Future<void> generateAndSaveBarcodes() async {
    // ... (كود توليد الباركود كما هو)
  }

  Future<void> sendBarcodeByEmail(String studentName, String barcodeUrl) async {
    // ... (كود إرسال البريد كما هو)
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          drawerItem(
            title: "إضافة أولياء الأمور",
            icon: Icons.group_add,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddParentsScreen()),
              );
            },
          ),
          drawerItem(
            title: "إضافة طلاب",
            icon: Icons.person_add,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddStudentsScreen()),
              );
            },
          ),
          drawerItem(
            title: "إضافة المعلمين",
            icon: Icons.school,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddTeachersScreen()),
              );
            },
          ),
          drawerItem(
            title: "الأعذار المرفقة",
            icon: Icons.attachment,
            onTap: () {
              print("📎 تم الضغط على الأعذار المرفقة");
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton.icon(
                      onPressed: generateAndSaveBarcodes,
                      icon: const Icon(Icons.qr_code, color: Colors.white),
                      label: const Text(
                        "توليد وحفظ أكواد QR",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
          ),
          drawerItem(
            title: "مسح الباركود",
            icon: Icons.qr_code_scanner,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BarcodeScannerScreen()),
              );
            },
          ),
          const Spacer(),
          drawerItem(
            title: "تسجيل خروج",
            icon: Icons.logout,
            onTap: () => _logout(context),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ✅ الدالة المصححة مع إضافة return
  Widget drawerItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: Colors.blue, size: 24),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginEmployeeScreen()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print("❌ خطأ في تسجيل الخروج: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('فشل تسجيل الخروج: $e')));
    }
  }
}
