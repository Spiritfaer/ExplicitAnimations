import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Explicit Animations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Explicit Animations Demo'),
      initialBinding: BindingsBuilder.put(() => StateController()),
    );
  }
}

class StateController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animationRotate;
  late final Animation<double> _animationScale;

  @override
  void onInit() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animationRotate = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
        reverseCurve: Curves.ease,
      ),
    );

    _animationScale = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeOut,
      ),
    );

    _animationController.repeat(reverse: true);
    super.onInit();
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }
}

class MyHomePage extends GetView<StateController> {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: RotationTransition(
          turns: controller._animationRotate,
          child: ScaleTransition(
            scale: controller._animationScale,
            child: Container(
              height: 100,
              width: 100,
              color: Colors.amber,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
