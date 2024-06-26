import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = PlatformDispatcher.instance.platformBrightness;
      //yellow print
        print('\x1B[33m${brightness.name}\x1B[0m');

    final isDark = ref.watch(platformBrightnessProvider).isDark;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Riverpod example'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  ref.read(platformBrightnessProvider.notifier).setToLight();
                },
                child: Text('Ligth mode'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  ref.read(platformBrightnessProvider.notifier).setToDark();

                },
                child: Text('dark mode'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


final platformBrightnessProvider = ChangeNotifierProvider((ref) {
  final brightness = PlatformDispatcher.instance.platformBrightness;
  return PlatformBrightnessModel(isDark: brightness.name == 'dark');
},);


class PlatformBrightnessModel extends ChangeNotifier{
  //create a bool variable
  bool isDark ;

  //constructor with required value
  PlatformBrightnessModel({required this.isDark});

  //function to set it to true named setToDark
  void setToDark(){
    isDark = true;
    notifyListeners();
  }

  //function to set it to false named setToLight
  void setToLight(){
    isDark = false;
    notifyListeners();
  }




}