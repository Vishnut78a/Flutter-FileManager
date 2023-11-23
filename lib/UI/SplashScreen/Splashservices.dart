

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Splashservices {
  BuildContext context;
 Splashservices(this.context);
 
  void enterapp(){

   Timer(Duration(seconds: 2), ()=>Navigator.pushReplacementNamed(context,"/home") );
  }
}