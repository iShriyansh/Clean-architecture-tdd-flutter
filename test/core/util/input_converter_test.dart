
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/core/util/input_converter.dart';

void main() {
  
  InputConverter inputConverter;

  setUp((){
   
   inputConverter = InputConverter();


  });

  group('stringtoUnsignedInt', (){
 
   test(
     'should return an integer when the string represents an unsigned integer',
     (){
       final str = '123';
       final result  =  inputConverter.stringToUnsignedInteger(str);
       expect(result, Right(123));



     }
   );

      test(
     'should return a failure when the string is not an integer',
     (){
       final str = '123.233';
       final result  =  inputConverter.stringToUnsignedInteger(str);
       expect(result,Left(InvalidInputFailure()));

     }
   );

     test(
     'should return a failure when the string is a negarive number',
     (){
       final str = '-123';
       final result  =  inputConverter.stringToUnsignedInteger(str);
       expect(result,Left(InvalidInputFailure()));

     }
   );




   });

}