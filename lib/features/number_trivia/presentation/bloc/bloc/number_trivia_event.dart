import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {
  NumberTriviaEvent([List props = const <dynamic>[]]) : super(props);
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent{
  final String numberString;
  //passing in super for value equality
  GetTriviaForConcreteNumber(this.numberString):super([numberString]);
 
}

class GetTriviaForRandomNumber extends NumberTriviaEvent{}