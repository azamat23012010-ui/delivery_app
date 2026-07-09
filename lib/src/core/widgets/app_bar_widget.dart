import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
        this.isLeading = false,
        required this.title,
        this.actions = const [],
        this.isDark = false});
  final String title;
  final List<Widget> actions;
  final bool isLeading;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: isDark == true ? const Color.fromARGB(179, 47, 46, 46) : Colors.white70,
      centerTitle: true,
      actions: actions,
      leading: isLeading == true ? IconButton(onPressed: () {}, icon: Icon( Icons.menu, size: 30, color: Colors.deepPurple,)) : null,
      title: Text(
        title,
        style: GoogleFonts.workSans(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, kToolbarHeight.toDouble());
}