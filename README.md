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
