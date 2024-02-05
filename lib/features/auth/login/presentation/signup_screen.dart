import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/custom_alert_modal.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/custom_textfield.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/default_appbar.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/primary_button.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/utils/keyboard_dismisser.dart';
import 'package:modney_flutter_boilerplate/features/auth/login/form/login_form.dart';
import 'package:modney_flutter_boilerplate/features/auth/login/presentation/widgets/agreement.dart';
import 'package:modney_flutter_boilerplate/features/auth/login/presentation/widgets/wrappedTextField.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/router.gr.dart';
import 'package:reactive_forms/reactive_forms.dart';

@RoutePage()
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late FormGroup _form;
  @override
  void initState() {
    // TODO: implement initState
    _form = signUpForm;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisserWidget(
      child: ReactiveForm(
        formGroup: _form,
        child: Scaffold(
          appBar: DefaultAppbar(context: context, title: '회원가입'),
          body: Padding(
            padding: EdgeInsets.all($constants.insets.xs),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                WrappedTextField(name: 'username', label: '이름을'),
                WrappedTextField(name: 'birth', label: '생년월일을'),
                WrappedTextField(name: 'tel', label: '휴대전화번호를'),
                WrappedTextField(name: 'id', label: '아이디를'),
                WrappedTextField(name: 'password', label: '비밀번호를'),
                WrappedTextField(name: 'password_check', label: '비밀번호를 다시'),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Agreement(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: $constants.insets.lg),
                        width: double.maxFinite,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                              height: 42.h,
                              // width: double.infinity,
                              child: PrimaryButton(
                                text: '동의하고 가입하기',
                                onPressed: () => CustomAlertModal.showAlert(
                                  context,
                                  text: '회원가입이 완료되었습니다.',
                                  onPressed: () {
                                    AutoRouter.of(context)
                                        .replaceAll([const MainMapRoute()]);
                                  },
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
