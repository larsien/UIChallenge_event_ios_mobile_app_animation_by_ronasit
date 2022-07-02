import 'package:event_ios_mobile_app_animation_by_ronasit/common.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'page3.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> with SingleTickerProviderStateMixin {
  // late Animation<double> animation;
  late final AnimationController controller;
  late final Animation<double> headerTextFadeInAnimation;
  late final Animation<Offset> headerTextSlideUpAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    //for text
    headerTextFadeInAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutCubic));

    headerTextSlideUpAnimation = Tween<Offset>(
            begin: const Offset(0, 1), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
    controller.forward();
  }

  List<bool> boolList = [true, true, true];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCoffeeAppBar(controller),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeTransition(
              opacity: headerTextFadeInAnimation,
              child: SlideTransition(
                position: headerTextSlideUpAnimation,
                child: const Header(),
              ),
            ),
            Body(controller: controller)
          ],
        ),
      ),
    );

    // return const FlutterLogo();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Body extends StatelessWidget {
  const Body({super.key, required this.controller});
  final AnimationController controller;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: sampleContentList.length,
        itemBuilder: (context, index) {
          var item = sampleContentList[index];
          Animation<double> itemOpacityAnimation = Tween(begin: 0.0, end: 1.0)
              .animate(CurvedAnimation(
                  parent: controller,
                  curve: Interval(0.1 * index, 0.6 + index * 0.1,
                      curve: Curves.linear)));
          Animation<Offset> itemSlideAnimation =
              Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
                  .animate(CurvedAnimation(
                      parent: controller,
                      curve: Interval(0.1 * index, 0.6 + index * 0.1,
                          curve: Curves.linear)));
          return FadeTransition(
            opacity: itemOpacityAnimation,
            child: SlideTransition(
              position: itemSlideAnimation,
              child: GestureDetector(
                onTap: () => Navigator.push(context, delayedRoute(index)),
                // MaterialPageRoute(builder: (contgext) => Page2(index))),
                child: Item(item: item, index: index),
              ),
            ),
          );
        },
      ),
    );
  }

  Route delayedRoute(int index) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => Page3(index),
      transitionDuration: const Duration(milliseconds: 1200),
    );
  }
}

class Item extends StatelessWidget {
  const Item({Key? key, required this.item, required this.index})
      : super(key: key);

  final Map<String, String> item;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(item["dayOfWeek"]!, style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 5),
              Text(item["day"]!,
                  style: const TextStyle(
                      fontSize: 18,
                      color: Color(primaryRedColor),
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Hero(
                tag: "content$index",
                child: CardBody(item: item),
              ),
              Hero(
                tag: "test$index",
                child: CardImage(item: item),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class CardImage extends StatelessWidget {
  const CardImage({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Map<String, String> item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 12),
      child: Container(
        width: 50,
        height: 80,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image:
                    //  Image.asset(item["image"]!)
                    AssetImage(
                  item["image"]!,
                )),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}

class CardBody extends StatelessWidget {
  const CardBody({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Map<String, String> item;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 15,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.end,
        // mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              width: 50,
              height: 80,
            ),
          ),
          SizedBox(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item["title"]!,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(item["location"]!)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text("Last results",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
    );
  }
}

class CustomCoffeeAppBar extends StatefulWidget with PreferredSizeWidget {
// class CustomAppBar extends AppBar {
  // ignore: use_key_in_widget_constructors
  CustomCoffeeAppBar(this.controller);
  final AnimationController controller;
  @override
  State<CustomCoffeeAppBar> createState() => _CustomCoffeeAppBarState();

  @override
  Size get preferredSize => const Size(700, 300);
}

class _CustomCoffeeAppBarState extends State<CustomCoffeeAppBar> {
  late AnimationController controller;
  late Animation<Offset> cupSlideUpAnimation;
  late Animation<double> cupRotateAnimation;
  late Animation<double> cupFadeInAnimation;
  late Animation<int> textStepAnimation;
  final String appBarSearchText = "Search for ...";
  @override
  void initState() {
    controller = widget.controller;
    //for cup
    cupRotateAnimation = Tween(begin: 0.0, end: 0.07).animate(
        CurvedAnimation(parent: controller, curve: const ShakeCurve(count: 3)));
    cupSlideUpAnimation = Tween(
            begin: const Offset(0, 1), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));

    cupFadeInAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutCubic));
    textStepAnimation = StepTween(begin: 0, end: appBarSearchText.length)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      FadeTransition(
        opacity: cupFadeInAnimation,
        child: const AppBarBackground(),
      ),
      Align(
        alignment: const Alignment(0.5, 0.6),
        child: CupTransition(
            //적용 전
            // animation: animation,
            movingAnim: cupSlideUpAnimation,
            rotationAnim: cupRotateAnimation,
            opacityAnim: cupFadeInAnimation,
            child: SizedBox(
              height: 70,
              //https://www.pngwing.com/en/free-png-zqryl
              child: Image.asset(
                "images/coffee.png",
                fit: BoxFit.fitHeight,
              ),
            )),
      ),
      const AppBarBottomWhiteBackground(),
      SearchForTextWidget(
        cupOpacityAnimation: cupFadeInAnimation,
        textStepAnimation: textStepAnimation,
        appBarSearchText: appBarSearchText,
      ),
      const MenuBar(),
    ]);
  }
}

class MenuBar extends StatefulWidget {
  const MenuBar({Key? key}) : super(key: key);

  @override
  State<MenuBar> createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  bool isMenu1Selected = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 40,
          width: 200,
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurStyle: BlurStyle.outer,
                    offset: Offset(0.5, 0.5),
                    blurRadius: 0.1,
                    spreadRadius: 0.1)
              ],
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                  onTap: () {
                    isMenu1Selected = true;
                    setState(() {});
                  },
                  child: Container(
                      // width: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: isMenu1Selected
                              ? const Color.fromARGB(255, 2, 58, 105)
                              : Colors.white),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          child: Text('Events',
                              style: TextStyle(
                                  color: isMenu1Selected
                                      ? Colors.white
                                      : Colors.grey))))),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () {
                    isMenu1Selected = false;
                    setState(() {});
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: isMenu1Selected
                              ? Colors.white
                              : const Color.fromARGB(255, 2, 58, 105)),
                      child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text('Organizers',
                              style: TextStyle(
                                  color: isMenu1Selected
                                      ? Colors.grey
                                      : Colors.white))))),
            ]),
          ),
        ),
      ),
    );
  }
}

class SearchForTextWidget extends StatelessWidget {
  const SearchForTextWidget({
    super.key,
    required this.cupOpacityAnimation,
    required this.textStepAnimation,
    required this.appBarSearchText,
  });
  final String appBarSearchText;
  final Animation<double> cupOpacityAnimation;
  final Animation<int> textStepAnimation;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: FadeTransition(
            opacity: cupOpacityAnimation,
            child: AnimatedBuilder(
              builder: (context, child) {
                String text =
                    appBarSearchText.substring(0, textStepAnimation.value);
                return Text(text,
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.bold));
              },
              animation: textStepAnimation,
            ),
          )),
    );
  }
}

class AppBarBottomWhiteBackground extends StatelessWidget {
  const AppBarBottomWhiteBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
        alignment: Alignment.bottomCenter,
        child: Divider(
          thickness: 60,
          color: Colors.white,
          // decoration: const BoxDecoration(color: Colors.blue),
          // child: const SizedBox(height: 60))
        ));
  }
}

class AppBarBackground extends StatelessWidget {
  const AppBarBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 50.0,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(primaryBlueColor),
        ),
      ),
    );
  }
}

class ShakeCurve extends Curve {
  final double count;
  const ShakeCurve({this.count = 1});

  @override
  double transformInternal(double t) {
    var val = sin(count * 2 * pi * t + 0.5) * 0.5 + 0.7;
    return val;
  }
}

class CupTransition extends StatelessWidget {
  const CupTransition({
    super.key,
    required this.child,
    // required this.animation,
    required this.movingAnim,
    required this.rotationAnim,
    required this.opacityAnim,
  });

  final Widget child;
  // final Animation<double> animation;
  final Animation<Offset> movingAnim;
  final Animation<double> rotationAnim;
  final Animation<double> opacityAnim;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacityAnim,
      child: SlideTransition(
        position: movingAnim,
        child: RotationTransition(turns: rotationAnim, child: child),
      ),
    );
  }
}
