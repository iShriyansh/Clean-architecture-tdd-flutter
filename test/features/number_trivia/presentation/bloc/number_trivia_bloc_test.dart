import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/error/failures.dart';
import 'package:tdd/core/usecases/usecases.dart';
import 'package:tdd/core/util/input_converter.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:tdd/features/number_trivia/presentation/bloc/bloc/bloc.dart';


class MockGetConcreteNumberTrivia extends Mock implements GetConcreteNumberTrivia{}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia{}

class MockInputConverter extends Mock implements InputConverter{}

void main(){
  NumberTriviaBloc bloc;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp((){
   
   mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
   mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
   mockInputConverter = MockInputConverter();
   bloc = NumberTriviaBloc(concrete: mockGetConcreteNumberTrivia,
    random: mockGetRandomNumberTrivia,
     inputConverter: mockInputConverter);
  });

   test('initial state should be empty', (){
    
    expect(bloc.initialState,equals(Empty()));

  
   });

   group('GetTriviaForConcreteNumber', (){

    final tNumberString = '2';
    final tNumberParsed = 2;
    
    final tNumberTrivia =  NumberTrivia(text: 'test trivia', number: 1);

     void setUpMockInputConverterSuccess() =>
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(Right(tNumberParsed));

    test(
      'should call the inputConverter to validate and convert an unsinged interger',

      ()async{
       setUpMockInputConverterSuccess();

       bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
       await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
        verify(mockInputConverter.stringToUnsignedInteger(tNumberString));

      }
    );


    test(
      'should emit [Error] when the input is invalid',

      ()async{
        when(mockInputConverter.stringToUnsignedInteger(any)).thenReturn(Left(InvalidInputFailure()));
         
           final expected = [
          Empty(),
          Error(msg : INVALID_INPUT_FAILURE_MESSAGE)];
          //bloc.dispatch not returns any value insted bloc.state returns 
          //this function waits for 30 sec
         expectLater(bloc.state, emitsInOrder(expected)
          
          );


        bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
       

      }
    );

     test(
      'should get data from concrete use case',

      ()async{
        setUpMockInputConverterSuccess();
         
        when(mockGetRandomNumberTrivia(any)).thenAnswer((_) async=> Right(tNumberTrivia));

        //act
       bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
       await untilCalled(mockGetConcreteNumberTrivia(any));

       verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));

      }
    );

    test(
       'should emit [Loading, Loaded] when data is gotten successfully',
       (){
         setUpMockInputConverterSuccess();
         when(mockGetConcreteNumberTrivia(any))
        .thenAnswer((_) async => Right(tNumberTrivia));


         final expected = [
      Empty(),
      Loading(),
      Loaded(trivia: tNumberTrivia),
    ];

   expectLater(bloc.state, emitsInOrder(expected));

    // act
    bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));

      });


         test(
       'should emit [Loading, error] when getting data fails',
       (){
         setUpMockInputConverterSuccess();
         when(mockGetConcreteNumberTrivia(any))
        .thenAnswer((_) async => Left(ServerFailure()));


     final expected = [
      Empty(),
      Loading(),
      Error(msg: SERVER_FAILURE_MESSAGE),
    ];

   expectLater(bloc.state, emitsInOrder(expected));

    // act
    bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));

      });


    test(
  'should emit [Loading, Error] with a proper message for the error when getting data fails',
  () async {
    // arrange
    setUpMockInputConverterSuccess();
    when(mockGetConcreteNumberTrivia(any))
        .thenAnswer((_) async => Left(CacheFailure()));
    // assert later
    final expected = [
      Empty(),
      Loading(),
      Error(msg: CACHE_FAILURE_MESSAGE),
    ];
    expectLater(bloc.state, emitsInOrder(expected));
    // act
    bloc.dispatch(GetTriviaForConcreteNumber(tNumberString));
  },
);


   });


group('GetTriviaForRandomNumber', (){


    
    final tNumberTrivia =  NumberTrivia(text: 'test trivia', number: 1);






     test(
      'should get data from concrete use case',

      ()async{
     
         
        when(mockGetRandomNumberTrivia(any)).thenAnswer((_) async=> Right(tNumberTrivia));

        //act
       bloc.dispatch(GetTriviaForRandomNumber());
       await untilCalled(mockGetRandomNumberTrivia(any));

       verify(mockGetRandomNumberTrivia(NoParams()));

      }
    );

    test(
       'should emit [Loading, Loaded] when data is gotten successfully',
       (){
         
         when(mockGetRandomNumberTrivia(any))
        .thenAnswer((_) async => Right(tNumberTrivia));


         final expected = [
      Empty(),
      Loading(),
      Loaded(trivia: tNumberTrivia),
    ];

   expectLater(bloc.state, emitsInOrder(expected));

    // act
    bloc.dispatch(GetTriviaForRandomNumber());

      });


         test(
       'should emit [Loading, error] when getting data fails',
       (){
        
         when(mockGetRandomNumberTrivia(any))
        .thenAnswer((_) async => Left(ServerFailure()));


     final expected = [
      Empty(),
      Loading(),
      Error(msg: SERVER_FAILURE_MESSAGE),
    ];

   expectLater(bloc.state, emitsInOrder(expected));

    // act
    bloc.dispatch(GetTriviaForRandomNumber());

      });


    test(
  'should emit [Loading, Error] with a proper message for the error when getting data fails',
  () async {
    // arrange
   
    when(mockGetRandomNumberTrivia(any))
        .thenAnswer((_) async => Left(CacheFailure()));
    // assert later
    final expected = [
      Empty(),
      Loading(),
      Error(msg: CACHE_FAILURE_MESSAGE),
    ];
    expectLater(bloc.state, emitsInOrder(expected));
    // act
    bloc.dispatch(GetTriviaForRandomNumber());
  },
);


   });







}