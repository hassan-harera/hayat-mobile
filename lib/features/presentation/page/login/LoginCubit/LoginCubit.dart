import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hayat_eg/shared/network/endPoints/endPint.dart';
import 'package:http/http.dart' as http;

import 'LoginStates.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_outlined;
  bool obscure = true;

  void changeObscure() {
    obscure = !obscure;
    suffixIcon =
        obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangeObscureState());
  }

  void loginWithApi({
    required String subject,
    required String password,
    required String? deviceToken,
  }) async {
    emit(LoginLoadingState());
    http.Response response = await http.post(
        Uri.parse('$baseUrl/api/v1/auth/login'),
        body: jsonEncode({
          "subject": subject,
          "password": password,
          "device_token": deviceToken
        }),
        headers: {'Content-Type': 'application/json'});
    var responseBode = jsonDecode(response.body);

    if (responseBode['status'] == 'UNAUTHORIZED' ||
        responseBode['status'] == 'BAD_REQUEST' ||
        responseBode['status'] == 'UNSUPPORTED_MEDIA_TYPE') {
      emit(LoginErrorState(responseBode['message']));
    } else {
      emit(LoginSuccessState(responseBode['token']));
    }
  }

  void logoutWithApi({
    required String subject,
    required String password,
    required String? deviceToken,
  }) async {
    emit(LoginLoadingState());
    http.Response response = await http.post(
        Uri.parse('$baseUrl/api/v1/auth/logout'),
        body: jsonEncode({
          "subject": subject,
          "password": password,
          "device_token": deviceToken
        }),
        headers: {'Content-Type': 'application/json'});
    var responseBode = jsonDecode(response.body);

    if (responseBode['status'] == 'UNAUTHORIZED' ||
        responseBode['status'] == 'BAD_REQUEST' ||
        responseBode['status'] == 'UNSUPPORTED_MEDIA_TYPE') {
      emit(LoginErrorState(responseBode['message']));
    } else {
      emit(LoginSuccessState(responseBode['token']));
    }
  }
}
