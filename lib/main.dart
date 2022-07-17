import 'dart:io';

import 'package:file_finder/bloc/file_search_bloc.dart';
import 'package:file_finder/services/file_search_service.dart';
import 'package:file_finder/widgets/search_query_widget.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if(Platform.isWindows) {
    setWindowMaxSize(const Size(1024, 900));
    setWindowMinSize(const Size(700, 750));
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'File Finder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchQueryWidget(bloc: FileSearchBloc(FileSearchService()))
    );
  }
}
