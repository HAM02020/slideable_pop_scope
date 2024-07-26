import 'package:flutter/material.dart';
import 'package:slideable_pop_scope/slideable_pop_scope.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SlideablePopScope Example',
      home: PageA(),
    );
  }
}

class PageA extends StatelessWidget {
  const PageA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PageA")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const PageB();
              },
            ));
          },
          child: const Text("to PageB"),
        ),
      ),
    );
  }
}

class PageB extends StatefulWidget {
  const PageB({super.key});

  @override
  State<PageB> createState() => _PageBState();
}

class _PageBState extends State<PageB> {
  @override
  Widget build(BuildContext context) {
    return SlideablePopScope(
      onWillPop: () async {
        return await _showPopConfrimDialog();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("PageB")),
        body: const Center(
          child: Text("PageB"),
        ),
      ),
    );
  }

  Future<bool> _showPopConfrimDialog() async {
    bool? res = await showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Back to PageA?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
    return res ?? false;
  }
}
