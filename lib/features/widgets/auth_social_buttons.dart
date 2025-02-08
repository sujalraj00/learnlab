import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learnlab/auth/controller/login_controller.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(100)),
            child: IconButton(
              onPressed: () => controller.googleSignIn(),
              icon: const Image(
                width: 24,
                height: 24,
                image: AssetImage("assets/splash_icon/google-icon.png"),
              ),
            )),
        const SizedBox(
          width: 16,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: 24,
              height: 24,
              image: AssetImage("assets/splash_icon/facebook-icon.png"),
            ),
          ),
        ),
      ],
    );
  }
}
