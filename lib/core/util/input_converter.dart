import 'package:dartz/dartz.dart';
import 'package:tdd/core/error/failures.dart';

class InputConverter{

 Either<Failure,int> stringToUnsignedInteger(String str){
  
 try{
   final integer = int.parse(str);
   //after this flow goes to [On] block
   if(integer<0) throw FormatException();
   
return Right(integer);
 }on FormatException{
   return Left(InvalidInputFailure());
 }

  
 }




}

 class InvalidInputFailure extends Failure{}