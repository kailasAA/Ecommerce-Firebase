import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoe_app/common/multiproviders.dart';
import 'package:shoe_app/route/route_generator.dart';
import 'package:shoe_app/firebase_options.dart';
import 'package:shoe_app/utils/color_pallette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
      providers: Multiproviders.providerList, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorPallette.scaffoldBgColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: ColorPallette.scaffoldBgColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      splitScreenMode: true,
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
