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
      title: 'Easy Loading Button',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExamplePage(title: 'Easy Loading Button'),
    );
  }
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
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
              'Elevated button',
            ),
            const SizedBox(
              height: 5,
            ),
            EasyButton(
              idleStateWidget: const Text(
                'Elevated button',
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
              elevation: 2.0,
              contentGap: 6.0,
              buttonColor: Colors.blueAccent,
              onPressed: onButtonPressed,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Elevated button (width animated)',
            ),
            const SizedBox(
              height: 5,
            ),
            EasyButton(
              idleStateWidget: const Text(
                'Elevated button',
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
              useEqualLoadingStateWidgetDimension: true,
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
              'Outlined button',
            ),
            const SizedBox(
              height: 5,
            ),
            EasyButton(
              type: EasyButtonType.outlined,
              idleStateWidget: const Text(
                'Outlined button',
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
              'Outlined button (width animated)',
            ),
            const SizedBox(
              height: 5,
            ),
            EasyButton(
              type: EasyButtonType.outlined,
              idleStateWidget: const Text(
                'Outlined button',
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
              useEqualLoadingStateWidgetDimension: true,
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
              'Text button',
            ),
            const SizedBox(
              height: 5,
            ),
            EasyButton(
              type: EasyButtonType.text,
              idleStateWidget: const Text(
                'Text button',
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
              'Fullwidth elevated button',
            ),
            const SizedBox(
              height: 5,
            ),
            EasyButton(
              idleStateWidget: const Text(
                'Fullwidth elevated button',
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
              'Fullwidth elevated button (width animated)',
            ),
            const SizedBox(
              height: 5,
            ),
            EasyButton(
              idleStateWidget: const Text(
                'Fullwidth elevated button',
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
              useEqualLoadingStateWidgetDimension: true,
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
