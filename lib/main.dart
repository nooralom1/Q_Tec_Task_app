import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:q_tec_task_app_/splash.dart';
import 'package:q_tec_task_app_/view/home.dart';
import 'model/all_product_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);

  Hive.registerAdapter(AllProductModelAdapter());
  Hive.registerAdapter(RatingAdapter());

  await Hive.openBox<AllProductModel>('productBox');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future nextPage() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.to(() => const HomeScreen());
  }

  @override
  void initState() {
    nextPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
      builder: EasyLoading.init(),
    );
  }
}
