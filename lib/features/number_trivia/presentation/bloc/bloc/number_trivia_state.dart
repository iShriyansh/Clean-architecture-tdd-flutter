import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';

@immutable
abstract class NumberTriviaState extends Equatable {
  NumberTriviaState([List props = const <dynamic>[]]) : super(props);
}



class Empty extends NumberTriviaState{}

class Loading extends NumberTriviaState{}

class Loaded extends NumberTriviaState{
  final NumberTrivia trivia;

  Loaded({@required this.trivia}):super([trivia]);

}

class Error extends NumberTriviaState{ 
  final String msg;

  Error({@required this.msg}):super([msg]);

}
