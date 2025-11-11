import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const CalculatorApp(),
    ),
  );
}
class ThemeProvider extends ChangeNotifier {
  static const String _prefKey = 'isDarkMode';
  bool _isDark = false;
  bool get isDark => _isDark;

  ThemeProvider() {
    _loadFromPrefs();
  }

  toggleTheme() {
    _isDark = !_isDark;
    _saveToPrefs();
    notifyListeners();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool(_prefKey) ?? false;
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefKey, _isDark);
  }
}
class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.teal,
      ),
      home: const CalculatorScreen(),
    );
  }
}
class CalculatorLogic {
  String expression = '';
  String result = '0';

  final _operators = ['+', '-', '×', '÷', '*', '/'];
  void addInput(String input) {
    if (input == 'AC') {
      expression = '';
      result = '0';
      return;
    }

    if (input == '=') {
      _calculateResult();
      return;
    }

    if (expression.isEmpty && _isOperator(input) && input != '-') {
      return;
    }

    if (expression.isNotEmpty) {
      String last = expression[expression.length - 1];
      if (_isOperator(last) && _isOperator(input)) {

        return;
      }
      if (last == '.' && input == '.') return; // avoid ".."
    }

    if (input == '.') {

      int lastOp = -1;
      for (int i = expression.length - 1; i >= 0; i--) {
        if (_isOperator(expression[i])) {
          lastOp = i;
          break;
        }
      }
      String currentNumber = expression.substring(lastOp + 1);
      if (currentNumber.contains('.')) return;
      if (currentNumber.isEmpty) {

        expression += '0';
      }
    }

    expression += input;
  }

  void backspace() {
    if (expression.isNotEmpty) {
      expression = expression.substring(0, expression.length - 1);
      if (expression.isEmpty) result = '0';
    }
  }

  bool _isOperator(String s) {
    return _operators.contains(s);
  }

  void _calculateResult() {
    try {
      if (expression.isEmpty) {
        result = '0';
        return;
      }
      String finalExp = expression.replaceAll('×', '*').replaceAll('÷', '/');

      String last = finalExp[finalExp.length - 1];
      if (_isOperator(last)) {
        finalExp = finalExp.substring(0, finalExp.length - 1);
      }

      Parser p = Parser();
      Expression exp = p.parse(finalExp);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      if (eval % 1 == 0) {
        result = eval.toInt().toString();
      } else {
        result = eval.toString();
      }

      expression = result;
    } catch (e) {
      result = 'Error';
    }
  }
}

class CalculatorButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double flex;
  final Color? background;
  final Color? textColor;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.onTap,
    this.flex = 1,
    this.background,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final btn = Expanded(
      flex: flex.round(),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18),
            backgroundColor: background ?? Theme.of(context).colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: textColor ?? Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ),
      ),
    );
    return btn;
  }
}
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorLogic logic = CalculatorLogic();

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDark;
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        actions: [
          IconButton(
            tooltip: isDark ? 'Light mode' : 'Dark mode',
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Display
            Expanded(
              flex: isPortrait ? 2 : 1,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Text(
                        logic.expression.isEmpty ? '0' : logic.expression,
                        style: TextStyle(
                          fontSize: 28,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Text(
                        logic.result,
                        style: TextStyle(
                          fontSize: 44,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Buttons
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Column(
                  children: [
                    _buildRow(['AC', '⌫', '÷'], context),
                    _buildRow(['7', '8', '9', '×'], context),
                    _buildRow(['4', '5', '6', '-'], context),
                    _buildRow(['1', '2', '3', '+'], context),
                    _buildLastRow(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(List<String> labels, BuildContext context) {
    return Expanded(
      child: Row(
        children: labels.map((label) {
          return CalculatorButton(
            label: label,
            onTap: () => _onPressed(label, context),
            background: _buttonBackground(label, context),
            textColor: _buttonTextColor(label, context),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildLastRow(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          CalculatorButton(
            label: '0',
            flex: 2,
            onTap: () => _onPressed('0', context),
          ),
          CalculatorButton(
            label: '.',
            onTap: () => _onPressed('.', context),
          ),
          CalculatorButton(
            label: '=',
            onTap: () => _onPressed('=', context),
            background: Theme.of(context).colorScheme.secondaryContainer,
            textColor: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ],
      ),
    );
  }

  Color? _buttonBackground(String label, BuildContext context) {
    if (label == 'AC') return Colors.redAccent;
    if (label == '⌫') return Colors.orangeAccent;
    if (label == '=') return Theme.of(context).colorScheme.secondaryContainer;
    if (['÷', '×', '-', '+'].contains(label)) return Theme.of(context).colorScheme.primaryContainer;
    return null; // default
  }

  Color? _buttonTextColor(String label, BuildContext context) {
    if (label == 'AC' || label == '⌫') return Colors.white;
    if (label == '=') return Theme.of(context).colorScheme.onSecondaryContainer;
    return null;
  }

  void _onPressed(String label, BuildContext context) {
    setState(() {
      if (label == 'AC') {
        logic.addInput('AC');
      } else if (label == '⌫') {
        logic.backspace();
      } else if (label == '=') {
        logic.addInput('=');
      } else if (label == '÷' || label == '×' || label == '+' || label == '-' || label == '.' || _isDigit(label)) {
        logic.addInput(label);
      }
      // else ignore
    });
  }

  bool _isDigit(String s) {
    return RegExp(r'^[0-9]$').hasMatch(s);
  }
}
