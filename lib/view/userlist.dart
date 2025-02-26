
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:task/view/userdetail.dart';
import '../model/user_model.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blueAccent.shade700,
          child: Text(
            user.name[0].toUpperCase(),
            style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        title: Text(
          user.name,
          style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
        subtitle: Text(
          user.email,
          style: GoogleFonts.lato(fontSize: 13, color: Colors.grey.shade600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
        onTap: () {
          Get.to(() => UserDetailScreen(user: user));
        },
      ),
    );
  }
}
