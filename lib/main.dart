import 'package:flutter/material.dart';
import 'package:webview/webview_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  //WidgetsFlutterBinding();
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  await Permission.microphone.request(); // if you need microphone permission
//gtw diatas itu apa

  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WebViewScreen(),
      debugShowCheckedModeBanner: false,
      title: 'webview demo',
      //theme: ThemeData(
      //  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //  useMaterial3: true,
      //),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),

      
    );
  }
}


