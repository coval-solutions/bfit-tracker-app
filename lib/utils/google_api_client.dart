import 'dart:convert';
import 'dart:io';

import 'package:bfit_tracker/blocs/authentication/authentication_bloc.dart';
import 'package:bfit_tracker/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class GoogleApiClient extends http.BaseClient {
  final BuildContext context;
  Map<String, String> defaultHeaders;
  http.Client _httpClient = new http.Client();

  GoogleApiClient._create(this.context);

  static Future<GoogleApiClient> create(BuildContext context,
      {defaultHeaders, useAccessToken = false}) async {
    var client = GoogleApiClient._create(context);
    if (defaultHeaders == null) {
      String token = "";
      if (useAccessToken) {
        token =
            await BlocProvider.of<AuthenticationBloc>(context).getAccessToken();
      } else {
        token = await UserRepository.getIdToken();
      }

      client.defaultHeaders = {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      };
    }

    return client;
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(defaultHeaders);
    return _httpClient.send(request);
  }

  @override
  Future<Response> get(url, {Map<String, String> headers}) {
    headers.addAll(defaultHeaders);
    return _httpClient.get(url, headers: headers);
  }

  @override
  Future<Response> post(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    headers.addAll(defaultHeaders);
    return _httpClient.post(url, headers: headers, encoding: encoding);
  }

  @override
  Future<Response> patch(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    headers.addAll(defaultHeaders);
    return _httpClient.patch(url, headers: headers, encoding: encoding);
  }

  @override
  Future<Response> put(url,
      {Map<String, String> headers, body, Encoding encoding}) {
    headers.addAll(defaultHeaders);
    return _httpClient.put(url,
        headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<Response> head(url, {Map<String, String> headers}) {
    headers.addAll(defaultHeaders);
    return _httpClient.head(url, headers: headers);
  }

  @override
  Future<Response> delete(url, {Map<String, String> headers}) {
    headers.addAll(defaultHeaders);
    return _httpClient.delete(url, headers: headers);
  }
}
