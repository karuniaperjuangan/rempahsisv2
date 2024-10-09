import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar RempahSISAppbar() {
   return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage('assets/images/LogoPKM.png'),
          height: 40,
        ),
        SizedBox(width: 10,),
        Text("REMPAHSIS", 
        style: GoogleFonts.bebasNeue(fontSize: 24, color: Colors.white, fontWeight: FontWeight.w600)
        )
      ],
    ),
    flexibleSpace: Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/Appbar.png'),
      fit: BoxFit.cover,
      ),
    ),
    ),
  );
 }