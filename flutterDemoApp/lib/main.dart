import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:metamap_plugin_flutter/metamap_plugin_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MetaMap flutter plugin demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'MetaMap Flutter Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void showMetaMapFlow() {
    final metaData = {"key": "value"};
    MetaMapFlutter.showMetaMapFlow("CLIENT_ID", "FLOW_ID", metaData);
    MetaMapFlutter.resultCompleter.future.then((result) =>
        Fluttertoast.showToast(
            msg: result is ResultSuccess
                ? "Success ${result.verificationId}"
                : "Cancelled",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          child: ElevatedButton(
        onPressed: showMetaMapFlow,
        child: const Text('Verify me'),
      )),
    );
  }
}
