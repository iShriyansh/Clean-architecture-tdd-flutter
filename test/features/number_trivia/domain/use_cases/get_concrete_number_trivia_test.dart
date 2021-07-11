import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
//mocked v of NumberTriviaRepo
class MockNumberTriviaRepository extends Mock
    implements NumbertriviaRepository  {}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;
//Tests in Dart have a handy method called setUp which runs before every individual test. This is where we will instantiate the objects.

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    //passing mocked number trivia repo for testing
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(text: 'test', number: 1);

  test('should get trivia for the number from the repository', () async {
    //arrange

     // "On the fly" implementation of the Repository using the Mockito package.
      // When getConcreteNumberTrivia is called with any argument, always answer with
      // the Right "side" of Either containing a test NumberTrivia object.
      //?main business login (output)
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
        .thenAnswer((_) async => Right(tNumberTrivia));

    //act
    //?calling tesing logic
    final result = await usecase.call(Params(number: tNumber));

    //assert
      // UseCase should simply return whatever was returned from the Repository
    //?comparing result with expected output
    expect(result, Right(tNumberTrivia));
  // Verify that the method has been called on the Repository
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
 // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
