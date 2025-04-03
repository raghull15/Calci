import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MathApp());
}

class MathApp extends StatelessWidget {
  const MathApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MathHome(),
    );
  }
}

class MathHome extends StatefulWidget {
  const MathHome({Key? key}) : super(key: key);

  @override
  State<MathHome> createState() => _MathHomeState();
}

class _MathHomeState extends State<MathHome> {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  String result = '';

  void calculate(String operation) {
    double num1 = double.tryParse(num1Controller.text) ?? 0;
    double num2 = double.tryParse(num2Controller.text) ?? 0;
    double res = 0;

    switch (operation) {
      case 'Add':
        res = num1 + num2;
        break;
      case 'Subtract':
        res = num1 - num2;
        break;
      case 'Multiply':
        res = num1 * num2;
        break;
      case 'Divide':
        res = num2 != 0 ? num1 / num2 : 0;
        break;
    }

    setState(() {
      result = res.toString();
    });
  }

  void clearFields() {
    setState(() {
      num1Controller.clear();
      num2Controller.clear();
      result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    var numberInputFormatters = [
      new FilteringTextInputFormatter.allow(RegExp("[0-9]")),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Calculator', style: TextStyle(color: Color.fromARGB(255, 8, 7, 7), fontSize: 30)),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/math.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Text(
                  'Image not found!',
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: num1Controller,
                  inputFormatters: numberInputFormatters,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter first number',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0), 
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: num2Controller,
                  inputFormatters: numberInputFormatters,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter second number',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.8),
                    contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0), 
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () => calculate('Add'), child: const Text('Add', style: TextStyle(color: Color.fromARGB(255, 20, 20, 20), fontSize: 20))),
                    ElevatedButton(onPressed: () => calculate('Subtract'), child: const Text('Subtract', style: TextStyle(color: Color.fromARGB(255, 20, 20, 20), fontSize: 20))),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () => calculate('Multiply'), child: const Text('Multiply', style: TextStyle(color: Color.fromARGB(255, 20, 20, 20), fontSize: 20))),
                    ElevatedButton(onPressed: () => calculate('Divide'), child: const Text('Divide', style: TextStyle(color: Color.fromARGB(255, 20, 20, 20), fontSize: 20))),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: clearFields,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Cancel', style: TextStyle(color: Colors.white, fontSize: 30)),
                ),
                const SizedBox(height: 10),
                Text(
                  'Result: $result',
                  style: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
