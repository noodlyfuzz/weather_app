class WeatherConditions {
  /* Emoji Generator */

  String getWeatherCondition(int condition) {
    if (condition < 300) {
      return 'assets/images/lighting.png';
    } else if (condition < 400) {
      return 'assets/images/rain.png';
    } else if (condition < 600) {
      return 'assets/images/rain.png';
    } else if (condition < 700) {
      return 'assets/images/snow.png';
    } else if (condition < 800) {
      return 'assets/images/smog.png';
    } else if (condition == 800) {
      return 'assets/images/sunny.png';
    } else if (condition <= 804) {
      return 'assets/images/cloudy.png';
    } else {
      return 'assets/images/sunny.png';
    }
  }
}
