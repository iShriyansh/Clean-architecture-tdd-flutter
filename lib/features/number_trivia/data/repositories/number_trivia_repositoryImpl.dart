import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd/core/error/exception.dart';

import 'package:tdd/core/network/network_info.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:tdd/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd/core/error/failures.dart';

import 'package:tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef Future<NumberTrivia> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumbertriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
return await _getTrivia(() {
    return remoteDataSource.getConcreteNumberTrivia(number);
  });
      }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
   return await _getTrivia(() {
      return remoteDataSource.getRandomNumberTrivia();
    });
  }

Future<Either<Failure, NumberTrivia>> _getTrivia(
_ConcreteOrRandomChooser _concreteOrRandomChooser
) async{

    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia =
            await _concreteOrRandomChooser();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
     



}

  
}
