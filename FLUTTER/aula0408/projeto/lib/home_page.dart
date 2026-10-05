import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Meu Perfil", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.blueGrey,
        width: double.infinity,
        height: 300,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Vinicius Gabriel Buskievicz",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 3),
            Text(
              "Curso: Engenharia de Software",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 3),
            Text(
              "Disciplinas: Desenvolvimeto de sitemas para WEB/Mobile",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 3),
          ],
        ),
      ),
    );
  }
}
