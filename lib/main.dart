import 'package:flutter/material.dart';
import 'package:foodecommerce/pages/navHomeScreen.dart';
import 'package:foodecommerce/splashScreen.dart';
import 'package:foodecommerce/utils/constants.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'notifier/dynamicTableOrderNumbersNotifier.dart';
import 'notifier/themeNotifier.dart';
import 'pages/loginpage/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DynamicTableDetails>(create:(_)=>DynamicTableDetails()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: MyConstants.appName,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home:CarouselDemo(),
        home:SplashScreen(),
      ),
    );
  }
}


class test extends StatefulWidget {
  const test({Key? key}) : super(key: key);

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override

  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
