// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 119, 255)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> texts = ["Task one"];

  void changedText(String T) {
    this.setState(() {
      if (T != "") {
        texts.add(T);
      }
    });
  }

  void delete(int index) {
    this.setState(() {
      texts.removeAt(index);
    });
  }

  void up(int index) {
    this.setState(() {
      String temp = texts[index];
      texts[index] = texts[index - 1];
      texts[index - 1] = temp;
    });
  }

  void down(int index) {
    this.setState(() {
      String temp = texts[index];
      texts[index] = texts[index + 1];
      texts[index + 1] = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Manager"),
      ),
      body: Column(children: <Widget>[
        Expanded(child: ListText(this.texts, this.delete, this.up, this.down)),
        MyTextInput(this.changedText),
      ]),
    );
  }
}

class ListText extends StatefulWidget {
  final List<String> texts;
  final Function(int) del;
  final Function(int) up;
  final Function(int) down;
  const ListText(this.texts, this.del, this.up, this.down, {super.key});

  @override
  State<ListText> createState() => _ListTextState();
}

class _ListTextState extends State<ListText> {
  void delete(int index) {
    widget.del(index);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.texts.length,
        itemBuilder: (_, index) {
          var items = <Widget>[
            Tab(child:Text("${index+1} ")),
            Expanded(child: Text("${widget.texts[index]}"))
          ];
          if (index > 0) {
            items.add(IconButton(
                onPressed: () => widget.up(index),
                highlightColor: const Color.fromARGB(255, 255, 0, 0),
                icon: const Icon(Icons.arrow_upward)));
          }
          if (index < widget.texts.length - 1) {
            items.add(IconButton(
                onPressed: () => widget.down(index),
                highlightColor: const Color.fromARGB(255, 255, 0, 0),
                icon: const Icon(Icons.arrow_downward)));
          }
          items.add(
            IconButton(
                onPressed: () => this.delete(index),
                highlightColor: const Color.fromARGB(255, 255, 0, 0),
                icon: const Icon(Icons.delete)),
          );
          return Card(child: Row(children: items));
        });
  }
}

class MyTextInput extends StatefulWidget {
  final Function(String) callback;
  const MyTextInput(this.callback, {super.key});

  @override
  State<MyTextInput> createState() => _MyTextInputState();
}

class _MyTextInputState extends State<MyTextInput> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void click1() {
    widget.callback(controller.text);
    controller.clear();
  }

  double y = 109;
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: this.controller,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.message),
            labelText: "A text msg",
            suffixIcon: IconButton(
                onPressed: click1,
                highlightColor: const Color.fromARGB(255, 0, 124, 226),
                icon: const Icon(Icons.send))));
  }
}
