import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<String> history;
  const HistoryPage({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historico"),
        backgroundColor: Colors.lightBlue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (history.isEmpty)
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Nenhuma operação realizada",
                  style: TextStyle(fontSize: 20),
                ),
              )
            else
              ...history.map(
                (operation) => Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  margin:  EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(operation, style: const TextStyle(fontSize: 18)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
