import 'package:flutter/material.dart';
import 'package:works/app/parse_initialize.dart';
import 'package:works/app/repositories/cep_repository.dart';
import 'package:works/app/setup_locators.dart';
import 'app/app_widget.dart';

void main() async {
  ParseInitialize parseInitialize = ParseInitialize();
  Setuplocators setuplocators = Setuplocators();

  WidgetsFlutterBinding.ensureInitialized();
  await parseInitialize.initializeParse();
  setuplocators.setupLocators();
  runApp(AppWidget());
}
