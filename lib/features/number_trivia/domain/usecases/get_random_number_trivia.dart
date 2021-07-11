import 'package:tdd/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd/core/usecases/usecases.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';

 class GetRandomNumberTrivia extends UseCase<NumberTrivia,NoParams> {
   final NumbertriviaRepository repository;

  GetRandomNumberTrivia(this.repository);
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params)  async{
   
   return await repository.getRandomNumberTrivia();
  }
 


}