import 'dart:convert';

import 'package:flutter_clean_architecture_tdd/core/error/exceptions.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:flutter_clean_architecture_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient mockHttpClient;
  NumberTriviaRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });


//////////////////////// Helper methods //////////////////////// //////////////////////// 

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientError404(){
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
            (_) async => http.Response('Something went wrong', 400));
  }

//////////////////////// //////////////////////// //////////////////////// //////////////////////// 
  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      '''should perform a GET request on a url with Number being the endpoint 
       and with application/json header''',
      () async {
        // arrange
        // Para pasar cualquier parámetro que sea named parameter
        // usamos anyNamed(), any común es para parámetros posicionales
        setUpMockHttpClientSuccess200();

        // act
        dataSourceImpl.getConcreteNumberTrivia(tNumber);
        // assert
        verify(mockHttpClient.get(
          'http://numbersapi.com/$tNumber',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return number trivia when the response code is 200 (success code)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSourceImpl.getConcreteNumberTrivia(tNumber);
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw ServerException when the response code is 404 or another (error code)',
      () async {
        // arrange
        setUpMockHttpClientError404();
        // act
        final call = dataSourceImpl.getConcreteNumberTrivia;
        // assert
        expect(() => call(tNumber), throwsA(isInstanceOf<ServerException>()));
      },
    );
  });

  group('getRandomNumberTrivia', () {
    
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
      '''should perform a GET request on a url with Number being the endpoint 
       and with application/json header''',
      () async {
        // arrange
        // Para pasar cualquier parámetro que sea named parameter
        // usamos anyNamed(), any común es para parámetros posicionales
        setUpMockHttpClientSuccess200();

        // act
        dataSourceImpl.getRandomNumberTrivia();
        // assert
        verify(mockHttpClient.get(
          'http://numbersapi.com/random',
          headers: {
            'Content-Type': 'application/json',
          },
        ));
      },
    );

    test(
      'should return number trivia when the response code is 200 (success code)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSourceImpl.getRandomNumberTrivia();
        // assert
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should throw ServerException when the response code is 404 or another (error code)',
      () async {
        // arrange
        setUpMockHttpClientError404();
        // act
        final call = dataSourceImpl.getRandomNumberTrivia;
        // assert
        expect(() => call(), throwsA(isInstanceOf<ServerException>()));
      },
    );
  });
}
