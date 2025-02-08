import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:get_storage/get_storage.dart';
import 'package:learnlab/auth/pages/on_boarding_page.dart';
import 'package:learnlab/features/widgets/terms_and_condition_checkbox.dart';

import '../../features/widgets/auth_social_buttons.dart';
import '../../features/widgets/formdivider.dart';
import '../controller/sign_up_controller.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(SignupController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title
              Text(
                'Let\'s Create Your Account',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 32,
              ),

              // form
              Form(
                  key: controller.signupFormKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: controller.firstName,
                              validator: (value) =>
                                  TValidator.validateEmptyText(
                                      'First Name', value),
                              expands: false,
                              decoration: const InputDecoration(
                                  labelText: 'First Name',
                                  prefixIcon: Icon(Iconsax.user)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: controller.lastName,
                              validator: (value) =>
                                  TValidator.validateEmptyText(
                                      'Last name', value),
                              expands: false,
                              decoration: const InputDecoration(
                                  labelText: "Last Name",
                                  prefixIcon: Icon(Iconsax.user)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // username
                      TextFormField(
                        controller: controller.username,
                        validator: (value) =>
                            TValidator.validateEmptyText('Username', value),
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Iconsax.user_edit)),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // email
                      TextFormField(
                        controller: controller.email,
                        validator: (value) => TValidator.validateEmail(value),
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: 'E-mail',
                            prefixIcon: Icon(Iconsax.direct)),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // password
                      Obx(
                        () => TextFormField(
                          controller: controller.password,
                          validator: (value) =>
                              TValidator.validatePassword(value),
                          obscureText: controller.hidePassword.value,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Iconsax.password_check),
                            suffixIcon: IconButton(
                                onPressed: () => controller.hidePassword.value =
                                    !controller.hidePassword.value,
                                icon: Icon(controller.hidePassword.value
                                    ? Iconsax.eye_slash
                                    : Iconsax.eye)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // terms and condition
                      const TermsAndConditionCheckBox(),
                      const SizedBox(
                        height: 32,
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          // onPressed: () => controller.signup(),
                          onPressed: () => controller.signup(),
                          child: const Text('Create Account'),
                        ),
                      )
                    ],
                  )),

              const SizedBox(height: 32),
              const FormDivider(),
              const SizedBox(height: 32),
              const SocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}

class TValidator {
  // username text validator
  static String? validateUserName(String? username) {
    if (username == null || username.isEmpty) {
      return 'username is required';
    }
    // define a regular exp pattern for username
    const pattern = r"^[a-zA-Z0-9_-]{3,20}$";
    ;

    // create a regular exp instance from patter
    final regex = RegExp(pattern);

    // use the hashMatch method to check if the username matches the pattern
    bool isValid = regex.hasMatch(username);

    // check if username does not start or end with - _
    if (isValid) {
      isValid = !username.startsWith('_') &&
          !username.startsWith('-') &&
          !username.endsWith('_') &&
          !username.endsWith('-');
    }

    if (!isValid) {
      return 'username is not valid';
    }
    return null;
  }

  // empty text validation
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  //validate email
  static String? validateEmail(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid Email Address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // check for minimum password length
    if (value.length < 8) {
      return 'Password must be at least 8 characters long.';
    }

    // check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    // check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }
    return null;
  }
}
