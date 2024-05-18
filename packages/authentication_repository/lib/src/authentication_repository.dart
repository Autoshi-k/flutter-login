import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated, pendingAuthentication }
String _hardCodedPin = '12345';

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.pendingAuthentication),
    );
  }

  Future<void> authenticatePhoneNumber({
    required String pin
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => {
        if (pin == _hardCodedPin) {
          _controller.add(AuthenticationStatus.authenticated)
        } else {
          _controller.add(AuthenticationStatus.unauthenticated)
        }
      },
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}