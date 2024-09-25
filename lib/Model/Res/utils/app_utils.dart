class AppUtils{



  String? validateEmail(String? value) {
    // Regular expression for validating an Email
    String pattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);

    if (value == null || value.isEmpty) {
      // showToast(
      //     txtColor: Colors.white,
      //     bgColor: Colors.red,
      //     text:"Please enter your email"
      // );
      return 'Please enter your email';
    } else if (!regex.hasMatch(value)) {
      // showToast(
      //     txtColor: Colors.white,
      //     bgColor: Colors.red,
      //     text:"Please enter a valid email"
      // );
      return 'Please enter a valid email';
    }
    return null; // Return null if the email is valid
  }
  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (!hasUppercase) {
      // showToast(
      //     txtColor: Colors.white,
      //     bgColor: Colors.red,
      //     text:"Password must contain at least one uppercase letter"
      // );
      return 'Password must contain at least one uppercase letter';
    }
    if (!hasLowercase) {
      // showToast(
      //     txtColor: Colors.white,
      //     bgColor: Colors.red,
      //     text:"Password must contain at least one lowercase letter"
      // );
      return 'Password must contain at least one lowercase letter';
    }
    if (!hasDigits) {
      // showToast(
      //     txtColor: Colors.white,
      //     bgColor: Colors.red,
      //     text:"Password must contain at least one number"
      // );
      return 'Password must contain at least one number';
    }
    if (!hasSpecialCharacters) {
      // showToast(
      //     txtColor: Colors.white,
      //     bgColor: Colors.red,
      //     text:"Password must contain at least one special character"
      // );
      return 'Password must contain at least one special character';
    }

    return null;
  }

}