import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaState extends Equatable {
  const NumberTriviaState();
}

class EmptyState extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class LoadingState extends NumberTriviaState {
  @override
  List<Object> get props => [];
}

class LoadedState extends NumberTriviaState {
  final NumberTrivia trivia;

  LoadedState({@required this.trivia});
  @override
  List<Object> get props => [trivia];
}

class Error extends NumberTriviaState {
  final String message;

  Error({@required this.message});
  @override
  List<Object> get props => [message];
}
