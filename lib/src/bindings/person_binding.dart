import 'package:get/get.dart';
import 'package:interview_flutter/src/controllers/person_controller.dart';

class PersonBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PersonController());
  }
}
