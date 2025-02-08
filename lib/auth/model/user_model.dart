import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';

class UserModel {
  // keep those values final which you don't want to update
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel(
      {required this.id,
      required this.username,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.profilePicture});

  // Helper function to get the full name
  String get fullName => '$firstName $lastName';

  // helper function to format phoneNumber
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

// static fun to split full name into first and last name
  static List<String> nameParts(fullName) => fullName.split(" ");

// static fun to generate a username from the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername =
        "$firstName$lastName"; // combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // add "cwt_"  prefix
    return usernameWithPrefix;
  }

// static fun to create an empty user model
  static UserModel empty() => UserModel(
      id: '',
      username: '',
      email: '',
      firstName: '',
      lastName: '',
      phoneNumber: '',
      profilePicture: '');

// convert model to json structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture
    };
  }

// factory method to create a UserModel from a firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
          id: document.id,
          username: data['UserName'] ?? '',
          email: data['Email'] ?? '',
          firstName: data['FirstName'] ?? '',
          lastName: data['LastName'] ?? '',
          phoneNumber: data['PhoneNumber'] ?? '',
          profilePicture: data['ProfilePicture'] ?? '');
    } else {
      return UserModel.empty();
    }
  }
}

class TFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber) {
    // assuming a 10 digit us phone number : (123) 4567890
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)} ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)})';
    }
    // add more custom phonenumber format if needed
    return phoneNumber;
  }

  // not fully tested
  static String internationalFormatPhoneNumber(String phoneNUmber) {
    // remove any non digit character from the phonenumber
    var digitsOnly = phoneNUmber.replaceAll(RegExp(r'\D'), '');

    //  extract the country code from the digits only
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    // add the remaining digits with proper formatting
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode) ');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+1') {
        groupLength = 3;
      }
      int end = i + groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));

      if (end < digitsOnly.length) {
        formattedNumber.write(' ');
      }
      i = end;
    }
    return formattedNumber.toString();
  }
}
