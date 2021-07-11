import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:tdd/core/network/network_info.dart';


class MockDataConnectionChecker extends Mock implements DataConnectionChecker{}
void main() {
  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;
  

  setUp((){
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('is Connected', (){
    test('should forward the call to DataConnectionChecker.hasConnection',
     (){
       
       final tHasConnectionFuture  = Future.value(true);
       when(mockDataConnectionChecker.hasConnection).thenAnswer((realInvocation) => 
       tHasConnectionFuture
       );
       final result  =  networkInfo.isConnected;
       expect(result, tHasConnectionFuture);

     }
     );
  


  });

}