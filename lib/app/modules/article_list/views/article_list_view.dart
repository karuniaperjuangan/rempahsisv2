import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rempahsisv2/app/components/appbar/rempah_sis_appbar.dart';

import '../controllers/article_list_controller.dart';

class ArticleListView extends GetView<ArticleListController> {
  const ArticleListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffE0E0E0),
        appBar: RempahSISAppbar(),
        body: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Obx(()=> controller.listArticle.isNotEmpty
                ? ListView.builder(
                    itemCount: controller.listArticle.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed('/article-page',
                              arguments: {'id': controller.listArticle[index].id});
                        },
                        child: 
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                          Container(
                          margin: EdgeInsets.all(12),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                  image: NetworkImage(
                                controller.listArticle[index].imageUrl,
                              ))),
                          height: 150,
                          alignment: Alignment.bottomLeft,
                        ),
                        Positioned.fill(
                            child: Container(
                                                        margin: EdgeInsets.all(12),
                          padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                                ],
                              ),
                              ),
                            ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(12),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                            controller.listArticle[index].title,
                            style: TextStyle(color: Colors.white, shadows: [
                              Shadow(color: Colors.black, blurRadius: 3)
                            ]),
                          ),)
                        ],)
                      );
                    })
                : Container())));
  }
}
