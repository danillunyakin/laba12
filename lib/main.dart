

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ColorModel extends ChangeNotifier {
  double red = 120;
  double green = 80;
  double blue = 200;

  void setRed(double value) {
    red = value;
    notifyListeners();
  }

  void setGreen(double value) {
    green = value;
    notifyListeners();
  }

  void setBlue(double value) {
    blue = value;
    notifyListeners();
  }


  Color get color {
    return Color.fromARGB(255, red.toInt(), green.toInt(), blue.toInt());
  }
}



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ColorModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Підбір кольору RGB'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ColorPreview(),
            SizedBox(height: 24),
            SlidersSection(),
          ],
        ),
      ),
    );
  }
}



class ColorPreview extends StatelessWidget {
  const ColorPreview({super.key});

  @override
  Widget build(BuildContext context) {

    final model = context.watch<ColorModel>();

    return Column(
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: model.color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black26),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'RGB(${model.red.toInt()}, ${model.green.toInt()}, ${model.blue.toInt()})',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}



class SlidersSection extends StatelessWidget {
  const SlidersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ColorModel>();

    return Column(
      children: [
        ColorSlider(
          title: 'Red',
          value: model.red,
          sliderColor: Colors.red,
          onChanged: (value) => context.read<ColorModel>().setRed(value),
        ),
        ColorSlider(
          title: 'Green',
          value: model.green,
          sliderColor: Colors.green,
          onChanged: (value) => context.read<ColorModel>().setGreen(value),
        ),
        ColorSlider(
          title: 'Blue',
          value: model.blue,
          sliderColor: Colors.blue,
          onChanged: (value) => context.read<ColorModel>().setBlue(value),
        ),
      ],
    );
  }
}



class ColorSlider extends StatelessWidget {
  final String title;
  final double value;
  final Color sliderColor;
  final ValueChanged<double> onChanged;

  const ColorSlider({
    super.key,
    required this.title,
    required this.value,
    required this.sliderColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(title, style: const TextStyle(fontSize: 16)),
        ),
        Expanded(
          child: Slider(
            value: value,
            min: 0,
            max: 255,
            activeColor: sliderColor,
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: 40,
          child: Text('${value.toInt()}'),
        ),
      ],
    );
  }
}
