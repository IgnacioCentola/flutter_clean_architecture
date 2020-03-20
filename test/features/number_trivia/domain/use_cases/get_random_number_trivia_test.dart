import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_tdd/core/use_cases/use_case.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRespository {}

void main() {
  GetRandomNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  
  final tNumberTrivia = NumberTrivia(number: 1, text: 'test');
  test(
    'should get random trivia from the repository',
    () async {
      //arrange
      when(mockNumberTriviaRepository.getRandomNumberTrivia())
          .thenAnswer((_) async => Right(tNumberTrivia));
      //act
      // Al bautizar el método en el Use Case "call()", desde el unit test no necesitamos llamarlo por su nombre:
      // usecase.call();, sino que podemos usar la variable del tipo del Use Case y pasarle un parámetro
      // y va a reconocerlo, ésto se debe a que Dart soporte los llamados Callables
      final result = await usecase(NoParams());
      //assert
      expect(result, Right(tNumberTrivia));
      verify(mockNumberTriviaRepository.getRandomNumberTrivia());
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
