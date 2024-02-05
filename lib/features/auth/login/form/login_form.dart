import 'dart:io';

import 'package:reactive_forms/reactive_forms.dart';
import 'package:universal_platform/universal_platform.dart';

FormGroup get loginForm => FormGroup({
      'username': FormControl<String>(
        value: '',
        validators: [
          Validators.required,
          Validators.minLength(4),
        ],
        disabled: true,
      ),
      'id': FormControl<String>(value: '', validators: [
        // Validators.email,
        Validators.required,
      ]),
      'password': FormControl<String>(
        value: '',
        validators: [
          Validators.required,
          Validators.minLength(4),
        ],
      ),
      if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) ...{
        'photo': FormControl<File>(),
      },
    });

FormGroup get signUpForm => FormGroup({
      'username': FormControl<String>(
        value: '',
        validators: [
          Validators.required,
          Validators.minLength(4),
        ],
      ),
      'id': FormControl<String>(value: '', validators: [
        // Validators.email,
        Validators.required,
      ]),
      'tel': FormControl<String>(value: '', validators: [
        // Validators.email,
        Validators.number,
        Validators.required,
      ]),
      'birth': FormControl<String>(
        value: '',
        validators: [
          // Validators.email,
          Validators.required,
        ],
      ),
      'password': FormControl<String>(
        value: '',
        validators: [
          Validators.required,
          Validators.minLength(4),
        ],
      ),
      'password_check': FormControl<String>(
        value: '',
        validators: [
          Validators.required,
          Validators.minLength(4),
        ],
      ),
      if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) ...{
        'photo': FormControl<File>(),
      },
    });
