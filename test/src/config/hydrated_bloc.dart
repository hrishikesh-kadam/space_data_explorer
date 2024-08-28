import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<Storage>()])
import 'hydrated_bloc.mocks.dart';

void mockHydratedBloc() {
  try {
    HydratedBloc.storage;
  } catch (_) {
    MockStorage storage = MockStorage();
    when(storage.write(any, any)).thenAnswer((_) async {});
    HydratedBloc.storage = storage;
  }
}

Future<void> setUpHydratedBloc(
  Directory storageDirectory,
) async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: storageDirectory,
  );
}

Future<void> tearDownHydratedBloc(
  Directory storageDirectory,
) async {
  await HydratedBloc.storage.clear();
  try {
    await HydratedStorage.hive.deleteFromDisk();
    storageDirectory.deleteSync(recursive: true);
  } catch (_) {}
  HydratedBloc.storage = null;
}
