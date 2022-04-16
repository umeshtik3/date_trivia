// Mocks generated by Mockito 5.1.0 from annotations
// in date_trivia/test/features/date_trivia/data/repositories/date_trivia_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:date_trivia/core/platform/network_info.dart' as _i2;
import 'package:date_trivia/features/date_trivia/data/data_sources/date_trivia_local_data_source.dart'
    as _i4;
import 'package:date_trivia/features/date_trivia/data/data_sources/date_trivia_remote_data_source.dart'
    as _i3;
import 'package:date_trivia/features/date_trivia/data/models/date_trivia_model.dart'
    as _i6;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i2.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }
}

/// A class which mocks [DateTriviaRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockDateTriviaRemoteDataSourceForTest extends _i1.Mock
    implements _i3.DateTriviaRemoteDataSource {}

/// A class which mocks [DateTriviaLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockDateTriviaLocalDataSource extends _i1.Mock
    implements _i4.DateTriviaLocalDataSource {
  MockDateTriviaLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<void>? cachedDateTrivia(_i6.DateTriviaModel? triviaToCache) =>
      (super.noSuchMethod(Invocation.method(#cachedDateTrivia, [triviaToCache]),
              returnValueForMissingStub: Future<void>.value())
          as _i5.Future<void>?);
}

/// A class which mocks [DateTriviaLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockDateTriviaLocalDataSourceForTest extends _i1.Mock
    implements _i4.DateTriviaLocalDataSource {
  @override
  _i5.Future<void>? cachedDateTrivia(_i6.DateTriviaModel? triviaToCache) =>
      (super.noSuchMethod(Invocation.method(#cachedDateTrivia, [triviaToCache]),
              returnValueForMissingStub: Future<void>.value())
          as _i5.Future<void>?);
}
