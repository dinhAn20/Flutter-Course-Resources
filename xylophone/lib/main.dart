import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

void main() => runApp(const XylophoneApp());
const List<String> notes = [
  'note1.wav',
  'note2.wav',
  'note3.wav',
  'note4.wav',
  'note5.wav',
  'note6.wav',
  'note7.wav'
];
const List<Color> colors = [
  Colors.red,
  Colors.purple,
  Colors.green,
  Colors.blue,
  Colors.teal,
  Colors.yellow,
  Colors.indigo
];

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: notes
                .mapIndexed((index, note) => Expanded(
                      child: GestureDetector(
                        onTap: () {
                          final player = AudioPlayer();
                          player.play(AssetSource(note));
                        },
                        child: Container(
                          width: double.infinity,
                          color: colors[index],
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
