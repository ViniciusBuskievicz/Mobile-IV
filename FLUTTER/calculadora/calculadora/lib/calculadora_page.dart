import 'package:calculadora/enums/operation_type.dart';
import 'package:calculadora/history_page.dart';
import 'package:calculadora/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  late String displayNumber;
  late List<String> history;

  @override
  void initState() {
    displayNumber = "0";
    history = [];
    super.initState();
  }

  void setOperationType(OperationType newType) {
    setState(() {
      displayNumber += newType.symbol;
    });
  }

  void clearCalculator() {
    setState(() {
      displayNumber = "0";
    });
  }

  void appendNumber(String stringNumber) {
    setState(() {
      if (displayNumber == "0" && stringNumber != ",") {
        displayNumber = stringNumber;
      } else {
        displayNumber += stringNumber;
      }
    });
  }

  void removeNumber() {
    setState(() {
      if (displayNumber.length <= 1) {
        displayNumber = "0";
      } else {
        displayNumber = displayNumber.substring(0, displayNumber.length - 1);
      }
    });
  }

  List<double> parseNumbers(String expression) {
    RegExp regExp = RegExp(r"[0-9]+\.?[0-9]*");

    var matches = regExp.allMatches(expression);
    List<double> numbers = [];

    for (var match in matches) {
      String numberText = match.group(0)!;
      numbers.add(double.parse(numberText));
    }

    return numbers;
  }

  List<OperationType> getOperations(String expression) {
    final expression1 = expression.characters.where(
      (x) => OperationType.values.any((op) => op.symbol == x),
    );

    return expression1
        .map((x) => OperationType.values.firstWhere((op) => op.symbol == x))
        .toList();
  }

  void resolvePriorityOperations(
    List<double> numbers,
    List<OperationType> operations,
  ) {
    int index = 0;

    while (index < operations.length) {
      if (operations[index] == OperationType.multiplication) {
        numbers[index] = numbers[index] * numbers[index + 1];
        numbers.removeAt(index + 1);
        operations.removeAt(index);
      } else if (operations[index] == OperationType.division) {
        numbers[index] = numbers[index] / numbers[index + 1];
        numbers.removeAt(index + 1);
        operations.removeAt(index);
      } else {
        index++;
      }
    }
  }

  double resolveOperations(
    List<double> numbers,
    List<OperationType> operators,
  ) {
    int index = 0;

    while (index < operators.length) {
      if (operators[index] == OperationType.addition) {
        numbers[index] = numbers[index] + numbers[index + 1];
        numbers.removeAt(index + 1);
        operators.removeAt(index);
      } else if (operators[index] == OperationType.subtraction) {
        numbers[index] = numbers[index] - numbers[index + 1];
        numbers.removeAt(index + 1);
        operators.removeAt(index);
      } else {}
    }
    return numbers[0];
  }

  void calculate(){
    String expression = displayNumber.replaceAll(',','.');
    List<double> numbers = parseNumbers(expression);
    List<OperationType> operations = getOperations(expression);

    resolvePriorityOperations(numbers, operations);
    final result = resolveOperations(numbers, operations);

    history.add("$displayNumber = $result");

    setState((){
      displayNumber = result.toString().replaceAll(".",",");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculadora',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue,
        actions: [IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => HistoryPage(history: history)));
        }, icon: Icon(Icons.history))],
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            color: Colors.black12,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                displayNumber,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              Row(
                children: [
                  ButtonWidget(
                    text: "C",
                    onPressed: () => clearCalculator(),
                    color: Colors.red,
                  ),
                  ButtonWidget(
                    text: "\u232b",
                    onPressed: () {
                      removeNumber();
                    },
                    color: Colors.orange,
                  ),
                  ButtonWidget(
                    text: "\u00f7",
                    onPressed: () {
                      setOperationType(OperationType.division);
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ],
              ),
              Row(
                children: [
                  ButtonWidget(
                    text: "7",
                    onPressed: () {
                      appendNumber("7");
                    },
                  ),
                  ButtonWidget(
                    text: "8",
                    onPressed: () {
                      appendNumber("8");
                    },
                  ),
                  ButtonWidget(
                    text: "9",
                    onPressed: () {
                      appendNumber("9");
                    },
                  ),
                  ButtonWidget(
                    text: "x",
                    onPressed: () {
                      setOperationType(OperationType.multiplication);
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ],
              ),
              Row(
                children: [
                  ButtonWidget(
                    text: "4",
                    onPressed: () {
                      appendNumber("4");
                    },
                  ),
                  ButtonWidget(
                    text: "5",
                    onPressed: () {
                      appendNumber("5");
                    },
                  ),
                  ButtonWidget(
                    text: "6",
                    onPressed: () {
                      appendNumber("6");
                    },
                  ),
                  ButtonWidget(
                    text: "-",
                    onPressed: () {
                      setOperationType(OperationType.subtraction);
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ],
              ),
              Row(
                children: [
                  ButtonWidget(
                    text: "1",
                    onPressed: () {
                      appendNumber("1");
                    },
                  ),
                  ButtonWidget(
                    text: "2",
                    onPressed: () {
                      appendNumber("2");
                    },
                  ),
                  ButtonWidget(
                    text: "3",
                    onPressed: () {
                      appendNumber("3");
                    },
                  ),
                  ButtonWidget(
                    text: "+",
                    onPressed: () {
                      setOperationType(OperationType.addition);
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ],
              ),
              Row(
                children: [
                  ButtonWidget(
                    text: "0",
                    onPressed: () {
                      appendNumber("0");
                    },
                  ),
                  ButtonWidget(
                    text: ",",
                    onPressed: () {
                      appendNumber(",");
                    },
                  ),
                  ButtonWidget(
                    text: "=",
                    onPressed: () {
                      calculate();
                    },
                    color: Colors.green,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
