import 'package:dartz/dartz.dart';
import 'package:date_trivia/core/error/failures.dart';
import 'package:date_trivia/features/date_trivia/domain/entities/date_trivia.dart';
import 'package:date_trivia/features/date_trivia/domain/repositories/date_trivia_repository.dart';
import 'package:date_trivia/features/date_trivia/domain/usecases/get_concrete_date_trivia.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDateTriviaRepository extends Mock implements DateTriviaRepository {
}

@GenerateMocks([DateTriviaRepository])
void main() {
  GetConcreteDateTrivia? usecase;
  MockDateTriviaRepository? mockDateTriviaRepository;
  setUp(
    () {
      mockDateTriviaRepository = MockDateTriviaRepository();
      usecase = GetConcreteDateTrivia(mockDateTriviaRepository!);
    },
  );
  const testDate = '4/3';
  final DateTrivia testTrivia = DateTrivia(text: '', date: testDate);
  test('should get date from repository', () async {
    when(mockDateTriviaRepository?.getConcreteDateTrivia(any))
        .thenAnswer((_) async => Right(testTrivia));

    final result = await usecase!(Params(date: testDate));

    expect(result, Right(testTrivia));
    verify(mockDateTriviaRepository!.getConcreteDateTrivia(testDate));
    verifyNoMoreInteractions(mockDateTriviaRepository);
  });
}
