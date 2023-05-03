import 'package:flutter/material.dart';

class PrePostSegment{

  String? name;
  String? rating;
  String? description;


  TextEditingController descriptionController = TextEditingController();
  bool expand = false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['description'] = description;
    data['rating'] = rating;
    return data;
  }
}

List<PrePostSegment> getPreSegments(){
  List<PrePostSegment> list = [];

  PrePostSegment p1 = PrePostSegment();
  p1.name = "Interior look";
  list.add(p1);

  PrePostSegment p2 = PrePostSegment();
  p2.name = "Gift";
  list.add(p2);

  PrePostSegment p3 = PrePostSegment();
  p3.name = "Welcome";
  list.add(p3);

  PrePostSegment p4 = PrePostSegment();
  p4.name = "Keys";
  list.add(p4);

  PrePostSegment p5 = PrePostSegment();
  p5.name = "Exterior look";
  list.add(p5);

  PrePostSegment p6 = PrePostSegment();
  p6.name = "Sails & Bimini state";
  list.add(p6);

  PrePostSegment p7 = PrePostSegment();
  p7.name = "Charged Batteries";
  list.add(p7);

  PrePostSegment p8 = PrePostSegment();
  p8.name = "Filled Water Tank";
  list.add(p8);

  PrePostSegment p9 = PrePostSegment();
  p9.name = "Filled Fuel Tank";
  list.add(p9);

  PrePostSegment p10 = PrePostSegment();
  p10.name = "Dingy Fuel";
  list.add(p10);

  PrePostSegment p11 = PrePostSegment();
  p11.name = "2 Natural Gass Tanks";
  list.add(p11);

  return list;
}

List<PrePostSegment> getPostSegments(){
  List<PrePostSegment> list = [];

  PrePostSegment p1 = PrePostSegment();
  p1.name = "Yacht State";
  list.add(p1);

  PrePostSegment p2 = PrePostSegment();
  p2.name = "Cleanliness";
  list.add(p2);

  PrePostSegment p3 = PrePostSegment();
  p3.name = "Total inventory";
  list.add(p3);

  PrePostSegment p4 = PrePostSegment();
  p4.name = "Diving";
  list.add(p4);

  PrePostSegment p5 = PrePostSegment();
  p5.name = "Checkout Sailors";
  list.add(p5);

  return list;
}