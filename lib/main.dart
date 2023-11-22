import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:interview_flutter/src/routes/app_router.dart';

void main() {
  /// config logic app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // todo add your (Xd / Figma) artboard size
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      rebuildFactor: (old, data) => true,
      builder: (context, widget) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Interview Application',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              color: Colors.blueAccent,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              iconTheme: IconThemeData(color: Colors.white),
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          initialRoute: AppRouters.initial,
          getPages: AppRouters.routes,
        );
      },
    );
  }
}
