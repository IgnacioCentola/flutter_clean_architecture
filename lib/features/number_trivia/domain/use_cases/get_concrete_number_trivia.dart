import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRespository repository;

  GetConcreteNumberTrivia(this.repository);

  // Al bautizar el método "call()", desde el unit test no necesitamos llamarlo por su nombre:
  // usecase.call();, sino que podemos usar la variable del tipo del Use Case y pasarle un parámetro
  // y va a reconocerlo, ésto se debe a que Dart soporte los llamados Callables
  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({@required this.number});

  @override
  List<Object> get props => [number];
}
