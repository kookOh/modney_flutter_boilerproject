import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modney_flutter_boilerplate/features/app/models/alert_model.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/custom_alert_modal.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/custom_button.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/custom_textfield.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/customs/primary_button.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/utils/keyboard_dismisser.dart';
import 'package:modney_flutter_boilerplate/features/app/widgets/utils/material_splash_tappable.dart';
import 'package:modney_flutter_boilerplate/features/auth/login/blocs/auth_cubit.dart';
import 'package:modney_flutter_boilerplate/features/auth/login/form/login_form.dart';
import 'package:modney_flutter_boilerplate/i18n/strings.g.dart';
import 'package:modney_flutter_boilerplate/utils/constants.dart';
import 'package:modney_flutter_boilerplate/utils/helpers/bar_helper.dart';
import 'package:modney_flutter_boilerplate/utils/helpers/permission_helper.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modney_flutter_boilerplate/utils/r.dart';
import 'package:modney_flutter_boilerplate/utils/router.gr.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:universal_platform/universal_platform.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    @visibleForTesting this.cubit,
    @visibleForTesting this.form,
  });

  final AuthCubit? cubit;
  final FormGroup? form;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ImagePicker picker = ImagePicker();

  late RoundedLoadingButtonController _btnController;
  late FormGroup _form;

  @override
  void initState() {
    _btnController = RoundedLoadingButtonController();
    _form = widget.form ?? loginForm;

    super.initState();
  }

  File? get photo => _form.control('photo').value as File?;

  String get username => _form.control('username').value.toString();

  String get password => _form.control('password').value.toString();

  Future<void> checkPermission() async {
    final hasPermission = await checkPhotosPermission();

    if (hasPermission && mounted) {
      await selectPhoto();
    } else {
      BarHelper.showAlert(
        context,
        alert: AlertModel(
          message: context.t.core.file_picker.no_permission,
          type: AlertType.destructive,
        ),
      );
    }
  }

  Future<void> selectPhoto() async {
    const maxPhotoSizeInByte = 2000000;

    final photo =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

    if (photo == null) {
      return;
    }

    final size = await photo.length();

    if (!mounted) {
      return;
    }

    if (size <= maxPhotoSizeInByte) {
      // Execute the upload operation with bloc for photo. For ex.
      // Create a form data and send a post request with dio in your repo.
      // FormData formData = FormData.fromMap({
      //   "image": await MultipartFile.fromFile(photo.path),
      // });
      _form.control('photo').value = File(photo.path);
    } else {
      BarHelper.showAlert(
        context,
        alert: AlertModel(
          message: context.t.core.file_picker
              .size_warning(maxSize: maxPhotoSizeInByte / 1000000),
          type: AlertType.destructive,
        ),
      );
    }
  }

  Widget buildBody(BuildContext context) {
    return KeyboardDismisserWidget(
      child: ReactiveForm(
        formGroup: _form,
        child: Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: $constants.insets.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  R.images.main_image,
                  width: 132.w,
                  height: 195.h,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFA9A9A9)),
                        borderRadius: BorderRadius.circular(20.r),
                      )),
                  child: CustomTextField(
                    key: const Key('id'),
                    formControlName: 'id',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    labelText: '아이디',
                    hintText: '아이디를 입력하세요',
                    minLength: 4,
                    isRequired: true,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ReactiveFormConsumer(
                  builder: (context, formGroup, child) {
                    return Container(
                      decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFFA9A9A9)),
                            borderRadius: BorderRadius.circular(20.r),
                          )),
                      child: CustomTextField(
                        key: const Key('password'),
                        formControlName: 'password',
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.send,
                        obscureText: true,
                        labelText: '비밀번호',
                        hintText: '비밀번호를 입력하세요.',
                        minLength: 4,
                        isRequired: true,
                        onSubmitted: _form.valid
                            ? (_) => BlocProvider.of<AuthCubit>(context).login(
                                  username: username,
                                  password: password,
                                )
                            : null,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => CustomAlertModal.showAlert(
                        context,
                        text: '현재 지원하지 않는 기능입니다.',
                        height: 50,
                      ),
                      child: Text(
                        '아이디찾기',
                        style: getTextTheme(context).labelSmall,
                      ),
                    ),
                    Text(' | ', style: getTextTheme(context).labelSmall),
                    InkWell(
                      onTap: () => CustomAlertModal.showAlert(
                        context,
                        text: '현재 지원하지 않는 기능입니다.',
                        height: 50,
                      ),
                      child: Text(
                        '비밀번호찾기',
                        style: getTextTheme(context).labelSmall,
                      ),
                    ),
                    Text(' | ', style: getTextTheme(context).labelSmall),
                    InkWell(
                        onTap: () =>
                            AutoRouter.of(context).push(const SignupRoute()),
                        child: Text('회원가입',
                            style: getTextTheme(context).labelSmall)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ReactiveFormConsumer(
                  builder: (context, formGroup, child) => PrimaryButton(
                    width: getSize(context).width,
                    text: '로그인',
                    onPressed: _form.valid
                        ? () => BlocProvider.of<AuthCubit>(context).login(
                              username: username,
                              password: password,
                            )
                        : null,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ReactiveFormConsumer(
                  builder: (context, formGroup, child) => PrimaryButton(
                    width: getSize(context).width,
                    text: '비회원으로 이용하기',
                    primary: false,
                    onPressed: () {
                      AutoRouter.of(context).replaceAll([const MainMapRoute()]);
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        R.images.login_kakao,
                        width: 38.w,
                      ),
                    ),
                    ClipOval(
                      child: Image.asset(
                        R.images.login_apple,
                        width: 38.w,
                      ),
                    ),
                    ClipOval(
                      child: Image.asset(
                        R.images.login_google,
                        width: 38.w,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    AutoRouter.of(context).push(ConsultListRoute());
                  },
                  child: Text(
                    '약국용 화상채팅(TEST)',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      bloc: widget.cubit ?? context.read<AuthCubit>(),
      listener: (context, state) {
        state.maybeWhen(loading: () {
          _form
            ..unfocus()
            ..markAsDisabled();
          _btnController.start();
        }, failed: (alert) {
          _form.markAsEnabled();
          _btnController.reset();

          BarHelper.showAlert(
            context,
            alert: alert,
            isTest: widget.cubit != null,
          );
        }, authenticated: (_) {
          _form
            ..reset()
            ..markAsEnabled();
          _btnController.reset();

          if (widget.cubit != null) {
            BarHelper.showAlert(
              context,
              alert: AlertModel.alert(
                message: context.t.core.test.succeded,
                type: AlertType.constructive,
              ),
              isTest: true,
            );
          }
        }, orElse: () {
          _form.markAsEnabled();
          _btnController.reset();
        });
      },
      child: buildBody(context),
    );
    //   return BlocListener<AuthCubit, AuthState>(
    //     bloc: widget.cubit ?? context.read<AuthCubit>(),
    //     listener: (context, state) {
    //       state.maybeWhen(
    //         loading: () {
    //           _form
    //             ..unfocus()
    //             ..markAsDisabled();
    //           _btnController.start();
    //         },
    //         failed: (alert) {
    //           _form.markAsEnabled();
    //           _btnController.reset();

    //           BarHelper.showAlert(
    //             context,
    //             alert: alert,
    //             isTest: widget.cubit != null,
    //           );
    //         },
    //         authenticated: (_) {
    //           _form
    //             ..reset()
    //             ..markAsEnabled();
    //           _btnController.reset();

    //           if (widget.cubit != null) {
    //             BarHelper.showAlert(
    //               context,
    //               alert: AlertModel.alert(
    //                 message: context.t.core.test.succeded,
    //                 type: AlertType.constructive,
    //               ),
    //               isTest: true,
    //             );
    //           }
    //         },
    //         orElse: () {
    //           _form.markAsEnabled();
    //           _btnController.reset();
    //         },
    //       );
    //     },
    //     child: KeyboardDismisserWidget(
    //       child: ReactiveForm(
    //         formGroup: _form,
    //         child: Scaffold(
    //           body: Padding(
    //             padding: EdgeInsets.symmetric(horizontal: $constants.insets.md),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 if (UniversalPlatform.isAndroid ||
    //                     UniversalPlatform.isIOS) ...{
    //                   ReactiveFormConsumer(
    //                     builder: (context, formGroup, child) {
    //                       return MaterialSplashTappable(
    //                         radius: 50,
    //                         onTap: checkPermission,
    //                         child: CircleAvatar(
    //                           radius: 50,
    //                           backgroundColor: getCustomOnPrimaryColor(context)
    //                               .withOpacity(0.05),
    //                           backgroundImage: photo != null
    //                               ? Image.file(
    //                                   photo!,
    //                                   fit: BoxFit.cover,
    //                                 ).image
    //                               : null,
    //                           child: photo == null
    //                               ? Icon(
    //                                   MdiIcons.image,
    //                                   color: getTheme(context).onBackground,
    //                                 )
    //                               : null,
    //                         ),
    //                       );
    //                     },
    //                   ),
    //                   SizedBox(height: $constants.insets.md),
    //                 },
    // CustomTextField(
    //   key: const Key('username'),
    //   formControlName: 'username',
    //   keyboardType: TextInputType.text,
    //   textInputAction: TextInputAction.next,
    //   labelText: context.t.core.form.username.label,
    //   hintText: context.t.core.form.username.hint,
    //   minLength: 4,
    //   isRequired: true,
    // ),
    // ReactiveFormConsumer(
    //   builder: (context, formGroup, child) {
    //     return CustomTextField(
    //       key: const Key('password'),
    //       formControlName: 'password',
    //       keyboardType: TextInputType.text,
    //       textInputAction: TextInputAction.send,
    //       obscureText: true,
    //       labelText: context.t.core.form.password.label,
    //       hintText: context.t.core.form.password.hint,
    //       minLength: 4,
    //       isRequired: true,
    //       onSubmitted: _form.valid
    //           ? (_) => BlocProvider.of<AuthCubit>(context).login(
    //                 username: username,
    //                 password: password,
    //               )
    //           : null,
    //     );
    //   },
    // ),
    //                 SizedBox(height: $constants.insets.sm),
    // ReactiveFormConsumer(
    //   builder: (context, formGroup, child) => CustomButton(
    //     controller: _btnController,
    //     width: getSize(context).width,
    //     text: context.t.login.login_button,
    //     onPressed: _form.valid
    //         ? () => BlocProvider.of<AuthCubit>(context).login(
    //               username: username,
    //               password: password,
    //             )
    //         : null,
    //   ),
    // ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }
  }
}
