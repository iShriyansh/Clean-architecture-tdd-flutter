import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class NumberTrivia extends Equatable{
 
 final String text;
 final int number;

  NumberTrivia({
    //passing to equatable for equatable
  @required  this.text, @required this.number}):super([text,number]);

 



}