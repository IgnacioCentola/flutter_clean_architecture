import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/number_trivia_bloc.dart';
import '../bloc/number_trivia_event.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({
    Key key,
  }) : super(key: key);

  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  String inputString;
  final _form = GlobalKey<FormState>();
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // TextField
        Form(
          key: _form,
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Number cannot be empty';
              }
              return null;
            },
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Type a number',
              suffixIcon: const Icon(Icons.search),
              // hintText: 'Type number',
            ),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              inputString = value;
            },
            onFieldSubmitted: (_) {
              dispatchConcrete();
            },
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: const Text('Search'),
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                onPressed: dispatchConcrete,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: RaisedButton(
                child: const Text('Get random trivia'),
                onPressed: dispatchRandom,
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(inputString));
  }

  void dispatchRandom() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomNumber());
  }
}
