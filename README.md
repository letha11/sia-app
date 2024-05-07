<a name="readme-top"></a>

<br />
<div align="center">
  <a href="https://github.com/github_username/repo_name">
    <img src="assets/images/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">Unofficial SIA Mercubuana App</h3>

  <p align="center">
    An Unofficial SIA app for Mercubuana University students
  </p>
</div>

## About The Project

![SIA Mercubuana][product-screenshot]

I've got some minor issues with the [SIA Mercubuana University](https://sia.mercubuana.ac.id) website which are:
- You need to log in every 30 minutes or so 
- The website sometime having an issue with the server so you cannot access it
- No mobile application

And so i decided to build the application with an extra feature that fix those issues that i've listed above. Since SIA of Mercubuana University doesn't provide any API, so i need to scrape the data in order to built this application [sia-mercu-scraping](https://github.com/letha11/sia-mercu-scraping) that also fix the issues that i've already mentioned above.

### Built With

#### Frontend
[![Flutter][Flutter.dev]][Flutter-url]
[![Dart][Dart.dev]][Dart-url]
#### Backend
[![Python][Python.org]][Python-url]
[![Postgresql][Postgresql.org]][Postgresql-url]
[![Flask][Flask.com]][Flask-url]


<!-- GETTING STARTED -->
## Getting Started
### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/letha11/sia-app
   ```
2. Install all dependencies
   ```sh
   flutter pub get
   ```
3. Make sure you are connected with emulator or android devices. Keep in mind that this application support 2 type of environment, which are `DEV` and `PROD`. You can define those environment by specifying `APP_ENV` with `--dart-define`.
   ```sh
   # DEV Environment
   flutter run --dart-define=APP_ENV=DEV

   # PROD Environment
   flutter run --dart-define=APP_ENV=PROD
   ```


## Troubles I've stumbled upon when buidling this app
### Assertion Error with http_mock_adapter package
Since this is my first time testing a `Dio` package so im kinda confused on how to make things testable using Dio package. With a quick google search, i've read that i should use `http_mock_adapter` package to emulate a response from Dio. And so i used it.

but then when i try to mock my request with a post method to a `/login` endpoint of my backend, it throws an error like this:
```bash
  DioException [unknown]: null
  Error: Assertion failed: "Could not find mocked route matching request for POST /login { data: {dummy: dummy}, query parameters: {}, headers: {content-type: application/json, content-length: 17} }"
  package:dio/src/dio_mixin.dart 509:7  DioMixin.fetch
```
> Could not find mocked route matching request for POST /login { data: {dummy: dummy}, query parameters: {}, headers: {content-type: application/json, content-length: 17} }

This happend because when i initialize my `DioAdapter` from the `http_mock_adapter` package, i didn't specify the `matcher`, by default if `matcher` arguments are not specified it will be filled with an `FullHttpRequestMatcher()`.
```dart
// [FullHttpRequestMatcher] is a default matcher class
// (which actually means you haven't to pass it manually) that matches entire URL.
//
// Use [UrlRequestMatcher] for matching request based on the path of the URL.
//
// Or create your own http-request matcher via extending your class from  [HttpRequestMatcher].
// See -> issue:[124] & pr:[125]
```
Because of that when i'm trying to stub my request:
```dart
  dioAdapter.onPost(
	  "/login", (server) => server.reply(200, {'token': 'asd'}, delay: const Duration(seconds: 1)));
```
It will throw an assertion failed error,  because the matchers are `FullHttpRequestMatcher()` so it will try to match the whole request, be it the data passed and other things, and also my implementation of the request to `/login` endpoint are like this:
```dart
try {
  final response = await _dioClient.dio.post(
	'/login',
	data: {
	  username: username,
	  password: password,
	},
  );

  if(response.statusCode == 400) return Left(InvalidInput());
  if(response.statusCode == 401) return Left(InvalidCredentials());

  final String token = response.data['token'];

  return Right(token);
} catch (e) {
  return Left(Failure());
}
```
So it makes sense that it throws an error, because the stubbed post method are not actually the same with the implementations such as no data stubbed.
#### Solution
I think you can copy 1 to 1 and match the stubbed method with your implementation, but I'm too lazy to do that, so there are others way such as **using `UrlRequestMatcher`** so that the only things that the adapter look up for asserting are only the **url**.
```dart
dioAdapter = DioAdapter(dio: dio, matcher: const UrlRequestMatcher());
```


<!-- MARKDOWN LINKS & IMAGES -->
[product-screenshot]: screenshots/preview.png
[Dart.dev]: https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white
[Dart-url]: https://dart.dev/
[Flutter.dev]: https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white
[Flutter-url]: https://flutter.dev
[Flask.com]: https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white
[Flask-url]: https://flask.palletsprojects.com/
[Python.org]: https://img.shields.io/badge/Python-14354C?style=for-the-badge&logo=python&logoColor=white
[Python-url]: https://www.python.org
[Postgresql.org]: https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white
[Postgresql-url]: https://www.postgresql.org/
