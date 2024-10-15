import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:switcher/provider/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(vsync: this, duration: 2.seconds);

  late final provider = ThemeProvider(controller: controller);

  late final Animation<double> sunMoonAnimation;

  final String _lightImageUrl = 'assets/images/light_bg.png';
  final String _darkImageUrl = 'assets/images/dark_bg.png';
  final String sunUrl = 'assets/images/sun.png';
  final String moonUrl = 'assets/images/moon.png';

  bool isDay = true;

  @override
  void initState() {
    super.initState();

    sunMoonAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isDay ? 'Light Theme' : 'Dark Theme',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                provider.runAnimation();
                setState(() {
                  isDay = !isDay;
                });

                Future.delayed(100.milliseconds, () {
                  !isDay
                      ? AdaptiveTheme.of(context).setDark()
                      : AdaptiveTheme.of(context).setLight();
                });
              },
              child: AnimatedBuilder(
                builder: (context, _) {
                  return Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                          key: provider.containerKey,
                          width: 185,
                          height: 73,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 6,
                                    spreadRadius: 0,
                                    offset: const Offset(6, 6)),
                                BoxShadow(
                                    color: Colors.white.withOpacity(0.1),
                                    blurRadius: 6,
                                    spreadRadius: 0,
                                    offset: const Offset(-6, -6)),
                              ],
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.lerp(
                                          Colors.blueGrey[200] ??
                                              Colors.transparent,
                                          Colors.black,
                                          0.2) ??
                                      Colors.transparent,
                                  Colors.blueGrey[200] ?? Colors.transparent,
                                  Color.lerp(
                                          Colors.blueGrey[200] ??
                                              Colors.transparent,
                                          Colors.white,
                                          0.2) ??
                                      Colors.transparent,
                                ],
                              )),
                          child: AnimatedBuilder(
                            animation: controller,
                            builder: (BuildContext context, Widget? child) {
                              return ClipRRect(
                                  borderRadius: BorderRadius.circular(60.5),
                                  child: AnimatedCrossFade(
                                    firstCurve: Curves.linearToEaseOut,
                                    secondCurve: Curves.bounceInOut,
                                    firstChild: Image.asset(
                                      width: 185,
                                      height: 73,
                                      fit: BoxFit.cover,
                                      _lightImageUrl,
                                    ),
                                    secondChild: Image.asset(
                                      width: 185,
                                      height: 73,
                                      fit: BoxFit.cover,
                                      _darkImageUrl,
                                    ),
                                    crossFadeState: sunMoonAnimation.value > 0.6
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                    duration: 0.75.seconds,
                                  )
                                      .animate(
                                          controller: controller,
                                          autoPlay: false,
                                          onComplete: (controller) {})
                                      .scale(
                                        delay: 100.microseconds,
                                        duration: 0.5.seconds,
                                        begin: const Offset(1, 1),
                                        end: const Offset(1.1, 1.1),
                                      ));
                            },
                          )),
                      AnimatedBuilder(
                          animation: controller,
                          builder: (context, _) {
                            return Container(
                              margin: const EdgeInsets.only(left: 5),
                              key: provider.container2Key,
                              width: 62.5,
                              height: 62.5,
                              child: AnimatedCrossFade(
                                secondCurve: Curves.easeInOutQuart,
                                firstChild: Image.asset(
                                  fit: BoxFit.cover,
                                  sunUrl,
                                ),
                                secondChild: Image.asset(
                                  fit: BoxFit.cover,
                                  moonUrl,
                                ),
                                crossFadeState: sunMoonAnimation.value > 0.6
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: 0.75.seconds,
                              )
                                  .animate(
                                      autoPlay: false,
                                      controller: controller,
                                      onComplete: (controller) {})
                                  .moveX(
                                    delay: 100.microseconds,
                                    duration: 0.75.seconds,
                                    begin: 0,
                                    end: provider.size.value.width,
                                  ),
                            );
                          })
                    ],
                  );
                },
                animation: provider.size,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
