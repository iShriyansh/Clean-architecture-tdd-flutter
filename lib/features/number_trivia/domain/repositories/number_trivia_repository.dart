import 'package:dartz/dartz.dart';
import 'package:tdd/core/error/failures.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumbertriviaRepository{

Future<Either<Failure,NumberTrivia>> getConcreteNumberTrivia(int number);

Future<Either<Failure,NumberTrivia>> getRandomNumberTrivia();



}

