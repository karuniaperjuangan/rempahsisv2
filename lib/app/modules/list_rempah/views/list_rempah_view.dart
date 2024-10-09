import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/components/card/rempah_item_card.dart';

import '../controllers/list_rempah_controller.dart';

class ListRempahView extends GetView<ListRempahController> {
  const ListRempahView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Color(0xffE0E0E0),
      appBar:  AppBar(
          backgroundColor: Color(0xFFfdfdfd),
          elevation: 0,
          title: Container(
            height: 40,
            margin: EdgeInsets.all(50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffeaeaea),
            ),
            child: TextField(
              decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  prefixIcon: Icon(Icons.search, size: 18,),
                  hintText: "Cari...",
                  filled: true,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none),
              style: TextStyle(color: Colors.grey[800],),
              onChanged: (value) => controller.filter(value),
              textAlignVertical: TextAlignVertical.center,
            ),
          )


      ),
      body: Padding(padding: EdgeInsets.only(left: 15, right: 15),
        child: Obx(()=>controller.isInitialized.value ? 
        
        Column(children: [
                  //SizedBox(height: 20,),
                   Expanded(child: controller.dataFilter.isNotEmpty
                      ? ListView.builder(
                      itemCount: controller.dataFilter.length,
                      itemBuilder: (context,index)
                      => RempahItemCard(rempah: controller.dataFilter[index],)
                  )
                      :Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Rempah tidak ditemukan",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),textAlign: TextAlign.center,),
                            Text("☹",style: TextStyle(fontSize: 64),)]
                      )
                  )

                  )
                ],
                ): Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator()),
                ],
              )
        ) ,
      ));
}

