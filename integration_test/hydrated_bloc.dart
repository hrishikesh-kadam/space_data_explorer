import 'package:flutter/material.dart';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'hydrated_bloc.mocks.dart';

@GenerateNiceMocks([MockSpec<Storage>()])
void mockHydratedBloc() {
  MockStorage storage = MockStorage();
  when(storage.write(any, any)).thenAnswer((_) async {});
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = storage;
}
