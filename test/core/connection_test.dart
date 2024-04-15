import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sia_app/core/connection.dart';

@GenerateNiceMocks([MockSpec<Connectivity>()])
import 'connection_test.mocks.dart';

void main() {
  late MockConnectivity connectivity;
  late Connection connection;

  setUp(() {
    connectivity = MockConnectivity();
    connection = Connection(connectivity: connectivity);
  });

  test('constructor works', () {
    expect(connection, isA<Connection>());
  });

  group('checkConnection', () {
    test('should return false when there is no connection', () async {
      when(connectivity.checkConnectivity()).thenAnswer((realInvocation) async => List.empty());

      final isOnline = await connection.checkConnection();

      expect(isOnline, false);
    });
    
    test('should return true when there is connection', () async {
      when(connectivity.checkConnectivity()).thenAnswer((realInvocation) async => [ConnectivityResult.wifi]);

      final isOnline = await connection.checkConnection();

      expect(isOnline, true);
    });
  });
}
