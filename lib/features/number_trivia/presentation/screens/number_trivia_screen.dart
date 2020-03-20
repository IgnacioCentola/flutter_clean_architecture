import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/bloc.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display.dart';
import '../widgets/trivia_controls.dart';
import '../widgets/trivia_display.dart';

class NumberTriviaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: _buildBody(context),
      ),
    );
  }

  BlocProvider<NumberTriviaBloc> _buildBody(BuildContext ctx) {
    final screenHeight = MediaQuery.of(ctx).size.height;
    return BlocProvider(
      builder: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 15),
              // Top half
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is EmptyState) {
                    return MessageDisplay(
                      screenHeight: screenHeight,
                      message: 'Start searching!',
                    );
                  } else if (state is LoadingState) {
                    return LoadingWidget(
                      screenHeight: screenHeight,
                    );
                  } else if (state is LoadedState) {
                    return TriviaDisplay(
                      screenHeight: screenHeight,
                      numberTrivia: state.trivia,
                    );
                  } else if (state is Error) {
                    return MessageDisplay(
                      screenHeight: screenHeight,
                      message: state.message,
                    );
                  }
                },
              ),
              SizedBox(height: 10),
              // Bottom half
              TriviaControls(),
            ],
          ),
        ),
      ),
    );
  }
}
