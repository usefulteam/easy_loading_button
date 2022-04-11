import 'package:flutter/material.dart';

import 'package:easy_loading_button/easy_loading_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Loading Button',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Loading Button'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    onButtonPressed() async {
      await Future.delayed(const Duration(milliseconds: 3000), () => 42);

      // After [onPressed], it will trigger animation running backwards, from end to beginning
      return () {
        // Optional returns is returning a VoidCallback that will be called
        // after the animation is stopped at the beginning.
        // A best practice would be to do time-consuming task in [onPressed],
        // and do page navigation in the returned VoidCallback.
        // So that user won't missed out the reverse animation.
      };
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Elevated Button',
            ),
            const SizedBox(
              height: 5,
            ),
            EasyButton(
              idleStateWidget: const Text(
                'Elevated Button',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              loadingStateWidget: const CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
              useEqualLoadingStateWidgetDimension: true,
              useWidthAnimation: false,
              width: 150.0,
              height: 40.0,
              borderRadius: 4.0,
              contentGap: 6.0,
              buttonColor: Colors.blueAccent,
              onPressed: onButtonPressed,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Elevated Button - Animated',
            ),
            const SizedBox(
              height: 5,
            ),
            EasyButton(
              idleStateWidget: const Text(
                'Elevated Button',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              loadingStateWidget: const CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
              useWidthAnimation: true,
              width: 150.0,
              height: 40.0,
              borderRadius: 4.0,
              contentGap: 6.0,
              buttonColor: Colors.blueAccent,
              onPressed: onButtonPressed,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Outlined Button',
            ),
            const SizedBox(
              height: 5,
            ),
            EasyButton(
              type: EasyButtonType.outlined,
              idleStateWidget: const Text(
                'Outlined Button',
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
              loadingStateWidget: const CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blueAccent,
                ),
              ),
              useEqualLoadingStateWidgetDimension: true,
              useWidthAnimation: false,
              width: 150.0,
              height: 40.0,
              borderRadius: 4.0,
              contentGap: 6.0,
              onPressed: onButtonPressed,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Outlined Button - Animated',
            ),
            const SizedBox(
              height: 5,
            ),
            EasyButton(
              type: EasyButtonType.outlined,
              idleStateWidget: const Text(
                'Outlined Button',
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
              loadingStateWidget: const CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blueAccent,
                ),
              ),
              useWidthAnimation: true,
              width: 150.0,
              height: 40.0,
              borderRadius: 4.0,
              contentGap: 6.0,
              onPressed: onButtonPressed,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Text Button',
            ),
            const SizedBox(
              height: 5,
            ),
            EasyButton(
              type: EasyButtonType.text,
              idleStateWidget: const Text(
                'Text Button',
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
              loadingStateWidget: const CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blueAccent,
                ),
              ),
              useEqualLoadingStateWidgetDimension: true,
              useWidthAnimation: false,
              width: 150.0,
              height: 28.0,
              borderRadius: 4.0,
              onPressed: onButtonPressed,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Elevated Button Fullwidth',
            ),
            const SizedBox(
              height: 5,
            ),
            EasyButton(
              idleStateWidget: const Text(
                'Elevated Button Fullwidth',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              loadingStateWidget: const CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
              useEqualLoadingStateWidgetDimension: true,
              useWidthAnimation: false,
              width: double.infinity,
              height: 40.0,
              contentGap: 6.0,
              buttonColor: Colors.blueAccent,
              onPressed: onButtonPressed,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Elevated Button Fullwidth - Animated',
            ),
            const SizedBox(
              height: 5,
            ),
            EasyButton(
              idleStateWidget: const Text(
                'Elevated Button Fullwidth',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              loadingStateWidget: const CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
              useWidthAnimation: true,
              width: double.infinity,
              height: 40.0,
              contentGap: 6.0,
              buttonColor: Colors.blueAccent,
              onPressed: onButtonPressed,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
