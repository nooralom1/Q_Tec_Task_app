import 'package:get/get.dart';
import 'package:q_tec_task_app_/view/screens/home/home.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    nextPage();
    super.onInit();
  }

  Future nextPage() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.to(() => const HomeScreen());
  }
}
