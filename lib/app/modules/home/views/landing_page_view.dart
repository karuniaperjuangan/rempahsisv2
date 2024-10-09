import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:myapp/app/components/card/rempah_item_card.dart';
import 'package:myapp/app/models/rempah.dart';
import '../controllers/home_controller.dart';

import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    super.key,
    required this.controller,
  });

  final HomeController controller;
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
      color: Colors.white,
    ),
    Image.asset(
      "assets/images/Motif.png",
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.fitWidth,
    ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LandingPageHeader(),
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.all(12),
                height: 100,
                //box with shadow
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ]),
                child: FunFactContainer(),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    0.05 * MediaQuery.of(context).size.width,
                    8,
                    0.05 * MediaQuery.of(context).size.width,
                    8),
                alignment: Alignment.centerLeft,
                child: ArticleCarouselHeader(),
              ),
              ArticlesCarousel(controller: controller),
              LastAccessedHeader(),
              SingleChildScrollView(
                child: Expanded(
                  child: Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(()=> Column(
                      children: controller.listRempah
                          .map((element) => RempahItemCard(rempah: element))
                          .toList(),
                    )),
                  ),
                ),
              )
            ]),
      ],
    );
  }
}

class LandingPageHeader extends StatelessWidget {
  const LandingPageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.fromLTRB(
          0.05 * MediaQuery.of(context).size.width,
          0,
          0.05 * MediaQuery.of(context).size.width,
          0),
      alignment: Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: const Text(
        "Selamat datang,\nAyo mengenal rempah lebih dalam!",
        style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ArticleCarouselHeader extends StatelessWidget {
  const ArticleCarouselHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.info),
          SizedBox(width: 5),
          Center(child: Text("Informasi Mengenai Rempah")),
          Expanded(child: Container()),
          Center(child: Text("Lainnya"))
        ]);
  }
}

class LastAccessedHeader extends StatelessWidget {
  const LastAccessedHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          0.05 * MediaQuery.of(context).size.width,
          0,
          0.05 * MediaQuery.of(context).size.width,
          0),
      alignment: Alignment.centerLeft,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.history),
            SizedBox(width: 5),
            Text("Rempah Terakses")
          ]),
    );
  }
}

class LastAccessedRempahCard extends StatelessWidget {
  const LastAccessedRempahCard({
    super.key,
    this.rempah,
  });

  final Rempah? rempah;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          spreadRadius: -2,
        )
      ]),
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          elevation: 0,
          margin: EdgeInsets.only(bottom: 10),
          child: MaterialButton(
            onPressed: () {},
            child: ListTile(
                title: Text(
                  "Nama Rempah",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                //Nama Ilmiah
                subtitle: MarkdownBody(
                  data: "Nama ilmiah",
                  styleSheet: MarkdownStyleSheet(
                      p: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300)),
                ),
                trailing: Icon(
                  Icons.navigate_next,
                  color: Colors.black,
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image:
                        AssetImage("assets/images/Motif.png"),
                    height: 45,
                    width: 45,
                    fit: BoxFit.fill,
                  ),
                )),
          )),
    );
  }
}

class ArticlesCarousel extends StatelessWidget {
  const ArticlesCarousel({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Obx( ()=> Row(
          children: controller.listArticle
              .map((element) => GestureDetector(
                onTap: () {
                  controller.goToArticlePage(element.id);
                },
                child: Container(
                      width: 150,
                      height: 150,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ]),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          SizedBox.expand(
                              child: Image.network(
                            element.imageUrl,
                            fit: BoxFit.cover,
                          )),
                          // Gradient Top to Bottom, Transparent to Black
                          SizedBox.expand(
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.6, 1.0],
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ))),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              element.title,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        offset: Offset(0, 2),
                                        blurRadius: 2)
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
              ))
              .toList(),
        ))
        );
  }
}

class FunFactContainer extends StatelessWidget {
  const FunFactContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tahukah kamu?",
            textAlign: TextAlign.start,
          ),
          Text(
            "Jahe, lengkuas, kunyit, dan kencur memiliki bentuk yang mirip. Untuk membedakannya jahe memiliki ukuran yang paling besar diikuti oleh lengkuas, kunyit, lalu kencur.",
            style: TextStyle(fontSize: 13),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}

