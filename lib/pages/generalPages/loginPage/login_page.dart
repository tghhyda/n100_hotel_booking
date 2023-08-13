part of 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});

  @override
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsExt.backgroundColor,
      body: Container(
        margin: const EdgeInsets.all(12),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/defaultImage/app_logo.png',
                  height: 200,
                ),
                const Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColorsExt.textColor,
                    fontSize: 40,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppTextFormFieldWidget()
                    .setController(controller.emailController)
                    .setHintText("Email")
                    .setPrefixIcon(const Icon(Icons.email))
                    .setAutoValidateMode(
                        AutovalidateMode.onUserInteraction)
                    .setValidator((value) {
                      if (value!.isEmpty) {
                        return "Email cannot be empty";
                      }
                      if (!RegExp(
                              "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please enter a valid email");
                      } else {
                        return null;
                      }
                    })
                    .setInputType(TextInputType.emailAddress)
                    .build(context),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => AppTextFormFieldWidget()
                      .setController(controller.passwordController)
                      .setHintText("Password")
                      .setPrefixIcon(const Icon(Icons.lock))
                      .setDisplaySuffixIcon(true)
                      .setObscureText(controller.isObscure.value)
                      .setOnTapSuffixIcon(() {
                        controller.isObscure.value =
                            !controller.isObscure.value;
                      })
                      .setValidator((value) {
                        if (value!.isEmpty) {
                          return "Password cannot be empty";
                        }
                      })
                      .setAutoValidateMode(
                          AutovalidateMode.onUserInteraction)
                      .build(context),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (controller.isInvalid) const Text("Invalid account"),
                Obx(() => AppCheckBoxWidget()
                    .setValue(controller.keepLoggedIn.value)
                    .setOnChanged((value) {
                      controller.toggleKeepLoggedIn(value!);
                    })
                    .setTitle("Remember me?")
                    .build(context)),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(20.0))),
                    elevation: 5.0,
                    height: 40,
                    onPressed: () async {
                      controller.signIn(
                          context,
                          controller.emailController.text,
                          controller.passwordController.text);

                      if (controller.keepLoggedIn.value == true) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString(
                          'userEmail',
                          controller.emailController.text,
                        );
                        prefs.setString('userPassword',
                            controller.passwordController.text);
                      }
                    },
                    color: AppColorsExt.buttonColor,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: AppTextBody1Widget()
                      .setText("Forgot your password?")
                      .setColor(AppColors.of.yellowColor[6])
                      .setTextStyle(AppTextStyleExt.of.textBody1s)
                      .build(context),
                  onTap: () {
                    Get.to(() => ForgotPasswordPage());
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const DividerWidget(title: 'or continue with'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTileWidget(
                        imagePath: 'assets/defaultImage/google.png',
                        onTap: () {
                          controller.signInWithGoogle();
                        }),
                    const SizedBox(
                      width: 10,
                    ),
                    SquareTileWidget(
                        imagePath: 'assets/defaultImage/facebook.png',
                        onTap: () {})
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextBody1Widget()
                        .setText("Don't have an account?")
                        .setColor(AppColors.of.grayColor[8])
                        .build(context),
                    const SizedBox(width: 8),
                    GestureDetector(
                      child: AppTextBody1Widget()
                          .setText("Sign Up")
                          .setTextStyle(AppTextStyleExt.of.textBody1s)
                          .setColor(AppColors.of.yellowColor[6])
                          .build(context),
                      onTap: () {
                        Get.to(() => const Register());
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
