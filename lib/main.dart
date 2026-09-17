import 'dart:math' show Random;

import 'package:flutter/material.dart';

enum GayColor{
  unknown,
  gay,
  hetero,
}

class Person{
  Person({
    required this.name,
    required this.age,
    required this.gayProb,
    this.description = "",
  });

  final String name;
  final int age;
  final double gayProb;
  String description;
}

class PersonListElement extends StatelessWidget{
  PersonListElement({
    required this.person,
    required this.value,
    required this.shown,
  }) : super(key: ObjectKey(person));

  final Person person;
  final bool shown;
  final double value;

  bool isGay() {
    return value <= person.gayProb;
  }

  Color _getColor(BuildContext context){
    return shown ? ( isGay() ? Colors.pink : Colors.green) : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (isGay()) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(person.name[0]),
      ),
      title: Text(person.name + (isGay() && shown ? " (GAY)" : ""), style: _getTextStyle(context)),
    );
  }

}

class GayButton extends StatelessWidget{
  const GayButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: const Text("Scopri chi e' gay"));
  }

  
}

class PersonList extends StatefulWidget{
  const PersonList({
    required this.people,
    super.key,
  });

  final List<Person> people;

  @override
  State<PersonList> createState() => _PersonListState();
  
}


class _PersonListState extends State<PersonList>{

  bool buttonPressed = false;

  void show(){
    setState(() {
      buttonPressed = true;
    });
  }

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GayButton(onPressed: show),
        Expanded(child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: widget.people.map((person) {
            return PersonListElement(
              person : person,
              value : (buttonPressed ? Random().nextDouble() : 0),
              shown : buttonPressed,
            );
          }).toList(),
          ), 
        ) 
      ],
    );
    
  }

}


void main() {
  runApp(
    MaterialApp(
      title: 'Shopping App',
      home: Scaffold(
        appBar: AppBar(title: const Text('mamino')),
        body: PersonList(
          people: [
            Person(name: "Lorenzo Montano", age: 5, gayProb: 0.5),
            Person(name: "Peppe Monaco", age:8, gayProb: 0.5),
            Person(name: "Pippo Troia", age:8, gayProb: 0.5),
            Person(name: "Giorgo Abate", age:8, gayProb: 0.5),
            Person(name: "Tano Reitano", age:8, gayProb: 0.5),
            Person(name: "Coco Giovanni", age:8, gayProb: 0.9),
            Person(name: "Giulio Ranno", age:8, gayProb: 0.01),
          ],
        ),
      )
    ),
  );
}
