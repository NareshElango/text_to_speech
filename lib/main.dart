import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController txt = TextEditingController();
  final FlutterTts tts = FlutterTts();
  String typewords = "";
   FocusNode _focusNode = FocusNode();

  void _copy() {
    final value = ClipboardData(text: txt.text);
    Clipboard.setData(value);
  }

  speak(String text) async {
    await tts.setLanguage("en-US");
    await tts.setPitch(2);
    await tts.speak(text);
  }

  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Text to Speech App!",
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Container(
            child: Column(
              children: [
                TextField(
                  controller: txt,
                  focusNode: _focusNode,
                  onTap: () {
                    if (!_focusNode.hasFocus) {
                      FocusScope.of(context).requestFocus(_focusNode);
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      typewords = value;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "Type your text here!",
                      hintStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 250, 0),
                  child: FloatingActionButton(
                    onPressed: () {
                      _copy();
                    },
                    child: const Icon(
                      Icons.copy,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: ElevatedButton(
                    onPressed: () => speak(txt.text),
                    child: const Icon(
                      Icons.speaker,
                      size: 100,
                    ),
                  ),
                ),
                Text(typewords),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
