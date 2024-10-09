import 'dart:ui';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'package:get/get.dart';
import 'package:myapp/app/components/appbar/rempah_sis_appbar.dart';
import 'package:myapp/app/constant/colors.dart';
import 'package:myapp/utils/launch_url.dart';

import '../controllers/rempah_detail_controller.dart';

class RempahDetailView extends GetView<RempahDetailController> {
  const RempahDetailView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      appBar: RempahSISAppbar(),
      body: SingleChildScrollView(
          child: Obx(() => Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                            'assets/images/rempah/${controller.rempah.value.gambar}'),
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter)),
                child: Column(
                  children: [
                    SizedBox(height: 200),
                    Container(
                        padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 4,
                                  spreadRadius: 4)
                            ],
                            color: Color(0xffF5F5F5)),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 20),
                              //Nama Rempah
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(controller.rempah.value.namaRempah,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 28)),
                                ],
                              ),
                              //Nama Ilmiah Rempah
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MarkdownBody(
                                    data: controller.rempah.value.namaIlmiah,
                                    styleSheet: MarkdownStyleSheet(
                                        p: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12)),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //Ikhtisar
                                    Row(
                                      children: [
                                        Flexible(
                                          child: MarkdownBody(
                                            data: controller
                                                .rempah.value.ikhtisar,
                                            styleSheet: MarkdownStyleSheet(
                                                p: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12),
                                                textAlign:
                                                    WrapAlignment.spaceAround),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),

                                    SizedBox(
                                      height: 15,
                                    ),
                                    ExpandableInformation(
                                        title: "Morfologi",
                                        info: controller.rempah.value.morfologi,
                                        ref: controller
                                            .rempah.value.referensiMorfologi),
                                    ExpandableInformation(
                                        title: "Ciri-Ciri",
                                        info: controller.rempah.value.ciri,
                                        ref: controller
                                            .rempah.value.referensiCiri),
                                    ExpandableInformation(
                                        title: "Khasiat",
                                        info: controller.rempah.value.khasiat,
                                        ref: controller
                                            .rempah.value.referensiKhasiat),
                                    ExpandableInformation(
                                        title: "Kegunaan",
                                        info: controller.rempah.value.kegunaan,
                                        ref: controller
                                            .rempah.value.referensiKegunaan),
                                    ExpandableInformation(
                                        title: "Potensi",
                                        info: controller.rempah.value.potensi,
                                        ref: controller
                                            .rempah.value.referensiPotensi),
                                  ],
                                ),
                              )
                            ])),
                  ],
                ),
              ))));
}

class ExpandableInformation extends StatelessWidget {
  const ExpandableInformation(
      {super.key, required this.title, required this.info, required this.ref});

  final String title;
  final String ref;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.25)),
              borderRadius: BorderRadius.circular(5)),
          child: ExpandablePanel(
              header: Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Text(
                    title,
                  ),
                ),
              ),
              collapsed: SizedBox(),
              expanded: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            referensi(context, ref);
                          },
                          child: Text(
                            "Referensi",
                            style: TextStyle(color: RempahSISColor.darkBrown),
                          )),
                    ],
                  ),
                  MarkdownBody(
                    data: info,
                    styleSheet: MarkdownStyleSheet(
                        p: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                        textAlign: WrapAlignment.spaceBetween,
                        unorderedListAlign: WrapAlignment.spaceBetween),
                  ),
                ],
              )),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

void referensi(BuildContext context, String ref) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    constraints: BoxConstraints(minWidth: double.infinity, minHeight: 300),
    clipBehavior: Clip.antiAlias,
    builder: (BuildContext bc) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.25),
            ),
            child: Container(
              margin: EdgeInsets.all(12),
              child: Wrap(
                children: <Widget>[
                  MarkdownBody(
                    onTapLink: (text, url, title) {
                      launchLink(url!);
                      // Go to the URL
                    },
                    data: ref,
                    styleSheet: MarkdownStyleSheet(
                      p: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.white),
                      textAlign: WrapAlignment.spaceBetween,
                      listBullet: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.white),
                      orderedListAlign: WrapAlignment.spaceBetween,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
