import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(darkModeProvider);
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
                  ref.read(darkModeProvider.notifier).state = false;
                },
                child: Text('Ligth mode'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  ref.read(darkModeProvider.notifier).state =true;

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


final darkModeProvider = StateProvider((ref) {
  final brightness = PlatformDispatcher.instance.platformBrightness;
  return brightness.name == 'dark' ;
});
