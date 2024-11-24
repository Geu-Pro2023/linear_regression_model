import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(WildlifePredictorApp());
}

class WildlifePredictorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wildlife Conservation Predictor',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BottomNavScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    PredictionScreen(),
    InfoScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green[700],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.paw, size: 30),
            label: 'Predict',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.circleInfo, size: 30),
            label: 'Info',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

class PredictionScreen extends StatefulWidget {
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for TextFields
  final TextEditingController animalNameController = TextEditingController();
  final TextEditingController hairController = TextEditingController();
  final TextEditingController feathersController = TextEditingController();
  final TextEditingController backboneController = TextEditingController();
  final TextEditingController finsController = TextEditingController();
  final TextEditingController classTypeController = TextEditingController();

  String predictionResult = "";
  String selectedAnimal = "clam"; // Default animal

  final List<String> _animals = ["clam", "slug", "seawasp", "worm", "octopus"];

  final List<String> _imageList = [
    'assets/images/Cow.jpg',
    'assets/images/Deer.jpg',
    'assets/images/Elephant.jpg',
    'assets/images/Giraffa.jpg',
    'assets/images/Lion.jpg',
  ];
  int _currentImageIndex = 0;

  void _nextImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % _imageList.length;
    });
  }

  void _previousImage() {
    setState(() {
      _currentImageIndex =
          (_currentImageIndex - 1 + _imageList.length) % _imageList.length;
    });
  }

  Future<void> makePrediction() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      predictionResult = "Loading Prediction..."; // Show a temporary status
    });

    try {
      final data = {
        "Animal_Name_clam": selectedAnimal == 'clam' ? 1 : 0,
        "Animal_Name_slug": selectedAnimal == 'slug' ? 1 : 0,
        "Animal_Name_seawasp": selectedAnimal == 'seawasp' ? 1 : 0,
        "Animal_Name_worm": selectedAnimal == 'worm' ? 1 : 0,
        "Animal_Name_octopus": selectedAnimal == 'octopus' ? 1 : 0,
        "Hair": int.parse(hairController.text),
        "Feathers": int.parse(feathersController.text),
        "Backbone": int.parse(backboneController.text),
        "Fins": int.parse(finsController.text),
        "Class_Type": double.parse(classTypeController.text),
      };

      final response = await http.post(
        Uri.parse('https://linear-regressionl-api.onrender.com/predict'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          predictionResult =
              "Conservation Score: ${responseData["prediction"].toStringAsFixed(2)}";
        });
      } else {
        setState(() {
          predictionResult = "Failed to get a prediction. Try again.";
        });
      }
    } catch (e) {
      setState(() {
        predictionResult = "An error occurred: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Wildlife Conservation Predictor')),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      _imageList[_currentImageIndex],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 10,
                    child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.chevronLeft,
                          color: Colors.white, size: 30),
                      onPressed: _previousImage,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    child: IconButton(
                      icon: FaIcon(FontAwesomeIcons.chevronRight,
                          color: Colors.white, size: 30),
                      onPressed: _nextImage,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedAnimal,
                items: _animals.map((String animal) {
                  return DropdownMenuItem<String>(
                    value: animal,
                    child: Text(animal),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedAnimal = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Animal Name (select one)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select a valid animal name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ..._buildNumberFields(),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: makePrediction,
                child: Text(
                  "Predict",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              if (predictionResult.isNotEmpty)
                Text(
                  predictionResult,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNumberFields() {
    return [
      _buildNumberField("Hair", hairController),
      _buildNumberField("Feathers", feathersController),
      _buildNumberField("Backbone", backboneController),
      _buildNumberField("Fins", finsController),
      _buildNumberField("Class Type", classTypeController),
    ];
  }

  Widget _buildNumberField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null ||
              value.isEmpty ||
              double.tryParse(value) == null) {
            return "Enter a valid number";
          }
          return null;
        },
      ),
    );
  }
}

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Information"),
        backgroundColor: Colors.green[700],
      ),
      body: Center(
        child: Text(
          "Wildlife Predictor Info\n\nEnter valid inputs to predict conservation scores.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.black54),
        ),
      ),
    );
  }
}
