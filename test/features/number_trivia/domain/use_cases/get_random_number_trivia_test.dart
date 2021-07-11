

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/usecases/usecases.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock implements NumbertriviaRepository{ 
}

void main() {
  
  GetRandomNumberTrivia usecases;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp((){
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    //Mocked repository
    usecases = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });
  
  final tNumberTrivia = NumberTrivia(text: 'test', number: 1);


  test('should get random number trivia from the repository', () async{
    //arrange
    when(mockNumberTriviaRepository.getRandomNumberTrivia())
    .thenAnswer((_) async => Right(tNumberTrivia));
    //act
    final result = await usecases.call(NoParams());

    //aseert
    expect(result , Right(tNumberTrivia));

    verify(mockNumberTriviaRepository.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockNumberTriviaRepository);



  });






}