import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weight = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController Age = TextEditingController();
  String _selectedGender = "Male";
  String _selectedFrequency = "Not training";
  String result = "";

  String calc(double weight, double height, int age, String gender, String frequency) {
    double BMI, FatPercentage, BMR, TDEE;
    String category = "";
    String tips = "";

    BMI = weight / ((height / 100) * (height / 100));
    BMR = (10 * weight) + (6.25 * height) - (5 * age) + (gender == "Male" ? 5 : -161);

    if (gender == "Male") {
      FatPercentage = (1.39 * BMI) + (0.16 * age) - (10.3 * 1) - 9;
    } else {
      FatPercentage = (1.39 * BMI) + (0.16 * age) - (10.3 * 0) - 9;
    }

    if (frequency == "Not training") {
      TDEE = BMR * 1.1;
    } else if (frequency == "1-2 days per week") {
      TDEE = BMR * 1.2;
    } else if (frequency == "3-5 days per week") {
      TDEE = BMR * 1.55;
    } else {
      TDEE = BMR * 1.9;
    }

    if (BMI <= 15.9) {
      category = "Very Severely Underweight";
      tips += "Tip: Consider increasing your caloric intake with nutrient-dense foods.\n";
    } else if (BMI <= 16.9) {
      category = "Severely Underweight";
      tips += "Tip: Aim for balanced meals to support healthy weight gain.\n";
    } else if (BMI <= 18.4) {
      category = "Underweight";
      tips += "Tip: Gradually increase your caloric intake to reach a healthy weight.\n";
    } else if (BMI <= 24.9) {
      category = "Normal";
      tips += "Tip: You're in a healthy weight range! Keep it up.\n";
    } else if (BMI <= 29.9) {
      category = "Overweight";
      tips += "Tip: Focus on a balanced diet and increase activity to manage weight.\n";
    } else if (BMI <= 34.9) {
      category = "Obese Class I";
      tips += "Tip: Gradually reduce caloric intake and focus on regular physical activity.\n";
    } else if (BMI <= 39.9) {
      category = "Obese Class II";
      tips += "Tip: Focus on a sustainable, healthy weight loss plan with increased activity.\n";
    } else {
      category = "Obese Class III";
      tips += "Tip: Consult with a healthcare professional for personalized weight loss strategies.\n";
    }

    if (FatPercentage < 10) {
      tips += "Tip: Ensure you're getting enough healthy fats in your diet.\n";
    } else if (FatPercentage > 25) {
      tips += "Tip: Consider a more balanced approach to fats and carbs in your diet.\n";
    }

    if (frequency == "Not training" || frequency == "1-2 days per week") {
      tips += "Tip: Aim to increase your activity level to 3-5 days a week for better health.\n";
    } else {
      tips += "Tip: Make sure you're eating enough to support your exercise routine.\n";
    }

    String result = "BMI: ${BMI.toStringAsFixed(2)}\n" +
        "Fat Percentage: ${FatPercentage.toStringAsFixed(2)}%\n" +
        "BMR: ${BMR.toStringAsFixed(2)} kcal/day\n" +
        "TDEE: ${TDEE.toStringAsFixed(2)} kcal/day\n" +
        "Your current situation is: ${category}\n\n" +
        "Tips for you:\n" + tips;

    return result;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FitMate",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Weight (Kg): "),
                SizedBox(
                  width: 200,
                  height: 45,
                  child: Textfieldwidget(variable: weight),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Height (cm): "),
                SizedBox(
                  width: 200,
                  height: 45,
                  child: Textfieldwidget(variable: height),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Age:             "),
                SizedBox(
                  width: 200,
                  height: 45,
                  child: Textfieldwidget(variable: Age),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Gender: "),
                Row(
                  children: [
                    Radio<String>(
                      value: "Male",
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    const Text("Male"),
                  ],
                ),
                Row(
                  children: [
                    Radio<String>(
                      value: "Female",
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                    ),
                    const Text("Female"),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Workout Frequency: ",
                  style: TextStyle(fontSize: 16),
                ),
                DropdownButton<String>(
                  value: _selectedFrequency,
                  items: <String>[
                    "Not training",
                    "1-2 days per week",
                    "3-5 days per week",
                    "6-7 days per week",
                  ]
                      .map((String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFrequency = newValue!;
                    });
                  },
                ),
              ],
            ),
            Text(
              result,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 18,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:Colors.lightBlueAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  result = calc(
                    double.parse(weight.text),
                    double.parse(height.text),
                    int.parse(Age.text),
                    _selectedGender,
                    _selectedFrequency,
                  );
                }
                );

              },
              child: const Text("Calculate"),
            ),
          ],
        ),
      ),
    );
  }
}

class Textfieldwidget extends StatelessWidget {
  const Textfieldwidget({
    super.key,
    required this.variable,
  });

  final TextEditingController variable;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(border: OutlineInputBorder()),
      controller: variable,
      keyboardType: TextInputType.number,
    );
  }
}
