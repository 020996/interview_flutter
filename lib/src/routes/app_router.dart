import 'package:get/get.dart';
import 'package:interview_flutter/src/bindings/person_binding.dart';
import 'package:interview_flutter/src/views/person_screen.dart';

class AppRouters {
  static const initial = '/person_screen';

  static final routes = [
    GetPage(
      name: initial,
      page: () => const PersonScreen(),
      binding: PersonBinding(),
    ),
  ];
}
