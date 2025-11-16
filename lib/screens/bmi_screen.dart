import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/converters.dart';
import '../utils/bmi_helper.dart';
import '../widgets/result_card.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final feetController = TextEditingController();
  final inchController = TextEditingController();

  String weightUnit = "kg";
  String heightUnit = "cm";

  double? bmi;
  String category = "";
  Color categoryColor = Colors.grey;

  void calculateBMI() {
    try {
      double weight = double.parse(weightController.text);
      double heightM = 0;

      if (weightUnit == "lb") {
        weight = poundsToKg(weight);
      }

      if (heightUnit == "cm") {
        heightM = cmToMeters(double.parse(heightController.text));
      } else if (heightUnit == "m") {
        heightM = double.parse(heightController.text);
      } else {
        double ft = double.tryParse(feetController.text) ?? 0;
        double inch = double.tryParse(inchController.text) ?? 0;

        if (inch >= 12) {
          ft += (inch ~/ 12);
          inch = inch % 12;
        }

        heightM = feetInchToMeters(ft, inch);
      }

      if (heightM <= 0 || weight <= 0) {
        showError("Enter valid numbers.");
        return;
      }

      bmi = calculateBMIValue(weight, heightM);

      final result = getBMICategory(bmi!);
      category = result.category;
      categoryColor = result.color;

      setState(() {});
    } catch (_) {
      showError("Please enter all values correctly.");
    }
  }

  void showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("BMI Calculator")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Weight"),
            const SizedBox(height: 6),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: weightController,
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Enter weight",
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SegmentedButton(
                  segments: const [
                    ButtonSegment(value: "kg", label: Text("kg")),
                    ButtonSegment(value: "lb", label: Text("lb")),
                  ],
                  selected: {weightUnit},
                  onSelectionChanged: (v) =>
                      setState(() => weightUnit = v.first),
                )
              ],
            ),

            const SizedBox(height: 24),

            Text("Height"),
            const SizedBox(height: 6),

            SegmentedButton(
              segments: const [
                ButtonSegment(value: "cm", label: Text("cm")),
                ButtonSegment(value: "m", label: Text("m")),
                ButtonSegment(value: "ft", label: Text("ft + in")),
              ],
              selected: {heightUnit},
              onSelectionChanged: (v) =>
                  setState(() => heightUnit = v.first),
            ),

            const SizedBox(height: 12),

            if (heightUnit == "cm" || heightUnit == "m")
              TextField(
                controller: heightController,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                ],
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: heightUnit == "cm"
                      ? "Enter height (cm)"
                      : "Enter height (m)",
                ),
              ),

            if (heightUnit == "ft")
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: feetController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Feet",
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: inchController,
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Inch",
                      ),
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 24),

            Center(
              child: FilledButton(
                onPressed: calculateBMI,
                child: const Text("Calculate BMI"),
              ),
            ),

            const SizedBox(height: 24),

            if (bmi != null)
              ResultCard(
                bmi: bmi!,
                category: category,
                color: categoryColor,
              ),
          ],
        ),
      ),
    );
  }
}
