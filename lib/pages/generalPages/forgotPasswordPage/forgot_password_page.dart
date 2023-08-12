part of 'forgot_password_controller.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  ForgotPasswordPage({super.key});

  @override
  final controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColorsExt.backgroundColor,
      appBar: AppBar(
        title: const Text("Forgot your password"),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextBody1Widget()
                .setText("Receive an email to reset your password")
                .setMaxLines(2)
                .setTextOverFlow(TextOverflow.ellipsis)
                .build(context),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: AppTextFormFieldWidget()
                  .setController(controller.emailController)
                  .setHintText("Email")
                  .setPrefixIcon(const Icon(Icons.email))
                  .build(context),
            ),
            MaterialButton(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                elevation: 5.0,
                height: 40,
                onPressed: () async {
                  controller.resetPassword(context);
                },
                color: AppColorsExt.buttonColor,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.email),
                    const SizedBox(
                      width: 10,
                    ),
                    AppTextBody1Widget()
                        .setText("Reset password")
                        .build(context)
                  ],
                )),
          ],
        ),
      ),
    ));
  }
}
