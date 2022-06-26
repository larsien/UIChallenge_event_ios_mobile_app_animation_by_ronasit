import 'dart:ui';
import 'package:flutter/material.dart';
import 'common.dart';
import 'Page2.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        initialRoute: "/",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHome());
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 1));

  late Animation<Offset> animation;
  @override
  void initState() {
    super.initState();
    animation = Tween<Offset>(begin: Offset.zero, end: const Offset(1.0, 0.0))
        .animate(
            CurvedAnimation(parent: controller, curve: Curves.easeInCubic));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFFF47C74),
          onPressed: () async {
            controller.forward();
            await Future.delayed(const Duration(milliseconds: 1000));
            if (mounted) {
              Navigator.push(context, _createRoute())
                  .then((value) => controller.reset());
            }
          },
          child: const Icon(
            Icons.search,
          )),
//적용 후
      body: Column(
        children: [
          const SizedBox(height: 40),
          SlideTransition(position: animation, child: const HeaderList()),
          const SizedBox(height: 20),
          SlideTransition(position: animation, child: const MainBody()),
        ],
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
        pageBuilder: (_, __, ___) => const LastResultPage(),
        transitionDuration: const Duration(seconds: 1),
        transitionsBuilder: (_, animation, secondaryAnimation, child) {
          final opacityTween = Tween(begin: 0.0, end: 1.0).animate(animation);
          return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: FadeTransition(opacity: opacityTween, child: child));
        });
  }
}

class MainBody extends StatelessWidget {
  const MainBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 340,
        child: ListView.builder(
          padding: const EdgeInsets.only(
            left: 20,
            bottom: 40,
          ),
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return const CardContent();
          },
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  const CardContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        // margin: EdgeInsets.only(bottom: 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: Image.asset(
                    "images/test.jpeg",
                    fit: BoxFit.cover,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Calendar(),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text("Tea Ceremony",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Text("1270 Madison Avenue"),
                    ],
                  ),
                ],
              ),
            ),
            // )
          ],
        ));
  }
}

class HeaderList extends StatelessWidget {
  const HeaderList({super.key});
  final List headers = const <String>[
    "Popular",
    "Features",
    "Trending",
    "Recent"
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 20,
        children: headers
            .map((title) => Text(title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )))
            .toList());
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(left: 55.0),
        child: Container(
          decoration: const BoxDecoration(
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
              color: Color.fromARGB(255, 184, 222, 240)),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("You're in", style: TextStyle(color: Color(primaryRedColor))),
            SizedBox(height: 10),
            Text("New york",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                )),
            SizedBox(
                width: 100,
                child: Divider(
                  height: 4,
                  color: Color(primaryRedColor),
                  thickness: 1.5,
                ))
          ],
        ),
      )
    ]);
  }

  @override
  Size get preferredSize => const Size(500, 250);
}
