import 'package:event_ios_mobile_app_animation_by_ronasit/common.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'Page3.dart';

class LastResultPage extends StatefulWidget {
  const LastResultPage({super.key});

  @override
  State<LastResultPage> createState() => _LastResultPageState();
}

//1
const String appBarSearchText = "Search for ... ";

class _LastResultPageState extends State<LastResultPage>
    with SingleTickerProviderStateMixin {
  // late Animation<double> animation;
  late AnimationController controller;
  late Animation<Offset> cupMovingAnimation;
  late Animation<double> rotateAnimation;
  late Animation<double> opacityAnimation;
  late Animation<Offset> headerTextMovingAnimation;
  late Animation<int> appBarTextStepAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);

    //for cup
    rotateAnimation = Tween(begin: 0.0, end: 0.07).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 1,
            // curve: ShakeCurve(),
            curve: Curves.elasticInOut)));
    cupMovingAnimation = Tween(
            begin: const Offset(0, 1), end: const Offset(0, -0.12))
        .animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));

    opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutCubic));

    //for text
    headerTextMovingAnimation = Tween<Offset>(
            begin: const Offset(0, 1), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: controller, curve: Curves.elasticOut));
    appBarTextStepAnimation = StepTween(begin: 0, end: appBarSearchText.length)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCoffeeAppBar(cupMovingAnimation, rotateAnimation,
          opacityAnimation, appBarTextStepAnimation),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(
              opacityAnimation: opacityAnimation,
              textMovingAnimation: headerTextMovingAnimation),
          Expanded(
            child: ListView.builder(
              itemCount: sampleContentList.length,
              itemBuilder: (context, index) {
                var item = sampleContentList[index];
                return GestureDetector(
                  onTap: () => Navigator.push(context, delayedRoute(index)),
                  // MaterialPageRoute(builder: (contgext) => Page2(index))),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Text(item["dayOfWeek"]!,
                                style: const TextStyle(fontSize: 12)),
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
                              child: Card(
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(item["title"]!,
                                                maxLines: 2,
                                                overflow: TextOverflow.clip,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 5),
                                            Text(item["location"]!)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Hero(
                              tag: "test$index",
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 12),
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
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );

    // return const FlutterLogo();
  }

  Route delayedRoute(int index) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => DetailPage(index),
      transitionDuration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.opacityAnimation,
    required this.textMovingAnimation,
  }) : super(key: key);

  final Animation<double> opacityAnimation;
  final Animation<Offset> textMovingAnimation;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacityAnimation,
      child: SlideTransition(
        position: textMovingAnimation,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Last results",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class CustomCoffeeAppBar extends StatefulWidget with PreferredSizeWidget {
// class CustomAppBar extends AppBar {
  // ignore: use_key_in_widget_constructors
  CustomCoffeeAppBar(this.cupMovingAnimation, this.cupRotateAnimation,
      this.cupOpacityAnimation, this.textStepAnimation);
  final Animation<Offset> cupMovingAnimation;
  final Animation<double> cupRotateAnimation;
  final Animation<double> cupOpacityAnimation;
  final Animation<int> textStepAnimation;

  @override
  State<CustomCoffeeAppBar> createState() => _CustomCoffeeAppBarState();

  @override
  Size get preferredSize => const Size(700, 300);
}

class _CustomCoffeeAppBarState extends State<CustomCoffeeAppBar> {
  bool isMenu1Selected = true;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FadeTransition(
          opacity: widget.cupOpacityAnimation,
          child: Container(
            decoration: const BoxDecoration(
              color: Color(primaryBlueColor),
            ),
            child: GrowTransition(
                // animation: animation,
                movingAnim: widget.cupMovingAnimation,
                rotationAnim: widget.cupRotateAnimation,
                child: SizedBox(
                  height: 70,
                  //https://www.pngwing.com/en/free-png-zqryl
                  child: Image.asset(
                    "images/coffee.png",
                    fit: BoxFit.fitHeight,
                  ),
                )),
          ),
        ),
      ),
      const Align(
          alignment: Alignment.bottomCenter,
          child: Divider(
            thickness: 60,
            color: Colors.white,
            // decoration: const BoxDecoration(color: Colors.blue),
            // child: const SizedBox(height: 60))
          )),
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: FadeTransition(
              opacity: widget.cupOpacityAnimation,
              child: AnimatedBuilder(
                builder: (context, child) {
                  String text = appBarSearchText.substring(
                      0, widget.textStepAnimation.value);
                  return Text(text,
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold));
                },
                animation: widget.textStepAnimation,
              ),
            )),
      ),
      Padding(
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
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                            color:
                                isMenu1Selected ? Colors.blue : Colors.white),
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
                            color:
                                isMenu1Selected ? Colors.white : Colors.blue),
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
      )
    ]);
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

class GrowTransition extends StatelessWidget {
  const GrowTransition({
    super.key,
    required this.child,
    // required this.animation,
    required this.movingAnim,
    required this.rotationAnim,
  });

  final Widget child;
  // final Animation<double> animation;
  final Animation<Offset> movingAnim;
  final Animation<double> rotationAnim;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedBuilder(
            animation: movingAnim,
            builder: (context, child) {
              return SlideTransition(
                position: movingAnim,
                child: RotationTransition(
                    turns: rotationAnim,
                    // alignment: Alignment.bottomCenter,
                    child: child),
              );
              // return RotationTransition(turns: rotationAnim, child: child);
            },
            child: child));
  }
}
