import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:rempahsisv2/app/models/rempah.dart';
import 'package:rempahsisv2/app/modules/home/controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RempahItemCard extends StatelessWidget {
  const RempahItemCard({
    super.key,
    required this.rempah
  });

  final Rempah rempah;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          spreadRadius: -2,
        )
      ]),
      child: Card(
          //color: Colors.grey[300],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
          margin: EdgeInsets.only(top:10),
          child: MaterialButton(
            onPressed:()async{
              final prefs = await SharedPreferences.getInstance();
              final lastAccessedRempahNames = prefs.getStringList('lastAccessedRempahNames') ?? [];
              if(lastAccessedRempahNames.contains(rempah.namaRempah)){
                lastAccessedRempahNames.remove(rempah.namaRempah);
              }
              lastAccessedRempahNames.insert(0, rempah.namaRempah);
              if (lastAccessedRempahNames.length > 3) lastAccessedRempahNames.removeLast();
              // Filter to maximum 3 items
              prefs.setStringList('lastAccessedRempahNames', lastAccessedRempahNames);
              final HomeController homeController = Get.find();
              homeController.updateLastAccessedRempahs();
              Get.toNamed('/rempah-detail', arguments: {'id': rempah.id});
              },
            child: ListTile(
                title: Text(rempah.namaRempah,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                //Nama Ilmiah
                subtitle: MarkdownBody(data: rempah.namaIlmiah,
                  styleSheet: MarkdownStyleSheet(p: TextStyle(fontSize: 12,fontWeight: FontWeight.w300)),),
    
                trailing: Icon(Icons.navigate_next, color: Colors.black,),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(image: AssetImage('assets/images/rempah/${rempah.gambar}'), height: 45, width: 45, fit: BoxFit.fill,),
                )
            ),
          )
      ),
    );
  }
}
