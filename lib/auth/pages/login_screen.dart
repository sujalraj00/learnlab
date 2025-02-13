import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:learnlab/auth/controller/login_controller.dart';
import 'package:learnlab/auth/pages/on_boarding_page.dart';
import 'package:learnlab/auth/pages/signup_screen.dart';
import 'package:learnlab/features/widgets/auth_social_buttons.dart';
import 'package:learnlab/features/widgets/formdivider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 56, left: 24, right: 24, bottom: 24),
          child: Column(
            children: [
              // logo, title, subtitle
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(
                      height: 150,
                      image: AssetImage("assets/splash_icon/nur_bg.png")),
                  Text(
                    'Welcome Back',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Discover Limitless Choices and Unmatched Convenience.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Form(
                      key: controller.loginFormKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            // email
                            TextFormField(
                              controller: controller.email,
                              validator: (value) =>
                                  TValidator.validateEmail(value),
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Iconsax.direct_right),
                                  labelText: 'E-mail'),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Obx(
                              () => TextFormField(
                                controller: controller.password,
                                validator: (value) =>
                                    TValidator.validatePassword(value),
                                obscureText: controller.hidePassword.value,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(Iconsax.password_check),
                                    suffixIcon: IconButton(
                                        onPressed: () =>
                                            controller.hidePassword.value =
                                                !controller.hidePassword.value,
                                        icon: Icon(controller.hidePassword.value
                                            ? Iconsax.eye_slash
                                            : Iconsax.eye)),
                                    labelText: 'Password'),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),

                            // remember me and forget password
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Obx(() => Checkbox(
                                        value: controller.rememberMe.value,
                                        onChanged: (value) =>
                                            controller.rememberMe.value =
                                                !controller.rememberMe.value)),
                                    const Text('remember me'),
                                  ],
                                ),
                                // forget pass
                                TextButton(
                                    onPressed: () {},
                                    child: const Text('forget password'))
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            // sign in button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () =>
                                      controller.emailAndPasswordSignIn(),
                                  child: const Text('login')),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                  onPressed: () =>
                                      Get.to(() => const SignUpScreen()),
                                  child: const Text('Create Account')),
                            ),
                            const SizedBox(height: 24),
                            const FormDivider(),
                            const SizedBox(
                              height: 24,
                            ),
                            const SocialButtons()
                          ],
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
