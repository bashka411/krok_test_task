import 'package:flutter/material.dart';
import 'package:krok_test_task/blocs/app_bloc/app_bloc.dart';
import 'package:krok_test_task/pages/home_page.dart';
import 'package:krok_test_task/pages/login_page.dart';

List<Page> onGenerateAppViewPages(
  AuthStatus status,
  List<Page<dynamic>> pages,
) {
  switch (status) {
    case AuthStatus.authenticated:
      return [HomePage.page()];
    case AuthStatus.unauthenticated:
      return [LogInPage.page()];
  }
}
