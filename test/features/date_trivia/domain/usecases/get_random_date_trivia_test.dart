// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:date_trivia/core/usecase/usecase.dart';
import 'package:date_trivia/features/date_trivia/domain/entities/date_trivia.dart';
import 'package:date_trivia/features/date_trivia/domain/repositories/date_trivia_repository.dart';
import 'package:date_trivia/features/date_trivia/domain/usecases/get_random_date_trivia.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDateTriviaRepository extends Mock implements DateTriviaRepository {
}

@GenerateMocks([DateTriviaRepository])
void main() {
  GetRandomDateTrivia? usecase;
  MockDateTriviaRepository? mockDateTriviaRepository;
  setUp(
    () {
      mockDateTriviaRepository = MockDateTriviaRepository();
      usecase = GetRandomDateTrivia(mockDateTriviaRepository!);
    },
  );
  
  final DateTrivia testTrivia = DateTrivia(text: '', date: '4/2');
  test('should get date from repository', () async {
    when(mockDateTriviaRepository?.getRandomDateTrivia())
        .thenAnswer((_) async => Right(testTrivia));

    final result = await usecase!(NoParams());

    expect(result, Right(testTrivia));
    verify(mockDateTriviaRepository!.getRandomDateTrivia());
    verifyNoMoreInteractions(mockDateTriviaRepository);
  });
}
