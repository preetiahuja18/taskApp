import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/user_model.dart';


class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({Key? key, required this.user}) : super(key: key);

  Widget buildInfoRow(IconData icon, String title, String value) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.blueAccent.shade700, size: 26),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600)),
                  Text(value,
                      style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F7FC),
      appBar: AppBar(
        title: Text(
          "User Details",
          style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blueAccent.shade700,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueAccent.shade700,
              child: Text(
                user.name[0].toUpperCase(),
                style: GoogleFonts.lato(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            buildInfoRow(Icons.person, "Name", user.name),
            buildInfoRow(Icons.email, "Email", user.email),
            buildInfoRow(Icons.phone, "Phone", user.phone),
            buildInfoRow(Icons.web, "Website", user.website),
            buildInfoRow(Icons.business, "Company", user.companyName),
            buildInfoRow(Icons.location_on, "Address", user.address),
          ],
        ),
      ),
    );
  }
}
