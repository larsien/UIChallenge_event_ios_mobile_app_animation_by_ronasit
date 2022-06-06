import 'package:flutter/material.dart';

import 'common.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(this.index, {super.key});
  final int index;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> calendarScaleAnimation;
  late Animation<double> gpsScaleAnimation;
  late Animation<double> timerScaleAnimation;
  late Animation<Offset> mainBodySlideAnimation;
  late Animation<double> mainTimeFadeInAnimation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    calendarScaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.7, curve: Curves.ease)));
    gpsScaleAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.25, 0.7, curve: Curves.ease)));
    timerScaleAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 1.0, curve: Curves.ease)));
    mainBodySlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -0.1))
            .animate(CurvedAnimation(
                parent: controller,
                curve: const Interval(0.5, 1.0, curve: Curves.ease)));
    mainTimeFadeInAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.5, 1.0, curve: Curves.ease)));
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderAppBar(
        index: widget.index,
        calendarScaleAnimation: calendarScaleAnimation,
        gpsScaleAnimation: gpsScaleAnimation,
        timerScaleAnimation: timerScaleAnimation,
        mainBodySlideAnimation: mainBodySlideAnimation,
        mainTimeFadeInAnimation: mainTimeFadeInAnimation,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: DetailContent(
          index: widget.index,
          detailBodyFadeInAnimation: mainTimeFadeInAnimation,
          detailBodySlideAnimation: mainBodySlideAnimation,
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  const DetailContent({
    super.key,
    required this.index,
    required this.detailBodySlideAnimation,
    required this.detailBodyFadeInAnimation,
  });

  final int index;
  final Animation<Offset> detailBodySlideAnimation;
  final Animation<double> detailBodyFadeInAnimation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: detailBodySlideAnimation,
      child: FadeTransition(
        opacity: detailBodyFadeInAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: 40, child: Text(sampleContentList[index]["content"]!)),
            const SizedBox(
                height: 20,
                child: Text("See more ",
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
      ),
    );
  }
}

class BodyMainInfoWidget extends StatelessWidget {
  const BodyMainInfoWidget({
    super.key,
    required this.calendarScaleAnimation,
    required this.gpsScaleAnimation,
    required this.timerScaleAnimation,
    required this.mainInfoTimeFadeInAnimation,
    required this.index,
  });

  final Animation<double> calendarScaleAnimation;
  final Animation<double> gpsScaleAnimation;
  final Animation<double> timerScaleAnimation;
  final Animation<double> mainInfoTimeFadeInAnimation;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Hero(
        tag: "content$index",
        child: Card(
          elevation: 10,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ScaleTransition(
                      scale: calendarScaleAnimation,
                      child: const Calendar(),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 192,
                      child: Text(sampleContentList[index]["title"]!,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ScaleTransition(
                        scale: gpsScaleAnimation,
                        child: const Icon(
                          Icons.location_pin,
                          color: Color(primaryRedColor),
                        )),
                    const SizedBox(width: 5),
                    Text(sampleContentList[index]["location"]!)
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ScaleTransition(
                        scale: timerScaleAnimation,
                        child: const Icon(
                          Icons.access_time_filled,
                          color: Color(primaryRedColor),
                        )),
                    const SizedBox(width: 5),
                    FadeTransition(
                        opacity: mainInfoTimeFadeInAnimation,
                        child: const Text("8:00 AM - 10:00 PM"))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderAppBar extends StatelessWidget with PreferredSizeWidget {
  const HeaderAppBar(
      {super.key,
      required this.index,
      required this.calendarScaleAnimation,
      required this.gpsScaleAnimation,
      required this.timerScaleAnimation,
      required this.mainBodySlideAnimation,
      required this.mainTimeFadeInAnimation});
  final Animation<double> calendarScaleAnimation;
  final Animation<double> gpsScaleAnimation;
  final Animation<double> timerScaleAnimation;
  final Animation<Offset> mainBodySlideAnimation;
  final Animation<double> mainTimeFadeInAnimation;

  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Stack(
        children: [
          Hero(
              tag: "test$index",
              child: Container(
                height: 300,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          "images/pug.jpeg",
                        )),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    )),
              )),
          Positioned(
            top: 300,
            child: SlideTransition(
              position: mainBodySlideAnimation,
              child: BodyMainInfoWidget(
                  index: index,
                  calendarScaleAnimation: calendarScaleAnimation,
                  gpsScaleAnimation: gpsScaleAnimation,
                  timerScaleAnimation: timerScaleAnimation,
                  mainInfoTimeFadeInAnimation: mainTimeFadeInAnimation),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(500, 500);
}
