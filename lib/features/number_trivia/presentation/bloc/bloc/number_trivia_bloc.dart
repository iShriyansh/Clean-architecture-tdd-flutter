import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:tdd/core/error/failures.dart';
import 'package:tdd/core/usecases/usecases.dart';
import 'package:tdd/core/util/input_converter.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:tdd/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server failure';
const String CACHE_FAILURE_MESSAGE = 'Cache failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    @required GetConcreteNumberTrivia concrete,
    @required GetRandomNumberTrivia random,
    @required this.inputConverter,
  })  : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random;

  @override
  NumberTriviaState get initialState => Empty();

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputEither.fold((failure) async* {
        yield Error(msg: INVALID_INPUT_FAILURE_MESSAGE);
      }, (integer) async* {
        yield Loading();
        final failureOrTrivia =
            await getConcreteNumberTrivia(Params(number: integer));
          yield* _eitherLoadedOrErrorState(failureOrTrivia);
      
      });
    }
    else if(event is GetTriviaForRandomNumber){
       yield Loading();
    final failureOrTrivia = await getRandomNumberTrivia(
      NoParams(),
    );
  yield* _eitherLoadedOrErrorState(failureOrTrivia);

    }
  }
}

Stream<NumberTriviaState> _eitherLoadedOrErrorState(Either<Failure,NumberTrivia> either)
async*{
  
    yield either.fold((failure) {
          return Error(msg: _mapFailureToMessage(failure));
        }, (trivia) => Loaded(trivia: trivia));

}

String _mapFailureToMessage(Failure failure) {
  // Instead of a regular 'if (failure is ServerFailure)...'
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected Error';
  }
}
