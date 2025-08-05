import 'package:get/get.dart';

class FaceLoginController extends GetxController {
  bool _isVerifying = false;
  bool _isVerificationComplete = false;

  bool get isVerifying => _isVerifying;
  bool get isVerificationComplete => _isVerificationComplete;

  void startVerification() {
    _isVerifying = true;
    _isVerificationComplete = false;
    update();
  }

  void completeVerification() {
    _isVerifying = false;
    _isVerificationComplete = true;
    update();

    // Here you can add your authentication logic
    // For example, call an API to verify the face
    _handleSuccessfulVerification();
  }

  void resetVerification() {
    _isVerifying = false;
    _isVerificationComplete = false;
    update();
  }

  void _handleSuccessfulVerification() {
    // Add your authentication logic here
    // For example:
    // - Save user session
    // - Navigate to dashboard
    // - Update user login state

    print('Face verification successful!');

    // Example: You can call your login API here
    // await _authService.loginWithFace();
  }

  @override
  void onClose() {
    // Cleanup when controller is disposed
    super.onClose();
  }
}