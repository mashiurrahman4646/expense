class LocalAuthService {
  Future<bool> isSupported() async => false;

  Future<bool> authenticate({String reason = 'Authenticate to continue'}) async => false;
}