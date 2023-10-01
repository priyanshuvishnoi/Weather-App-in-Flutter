part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final Position position;

  const FetchWeather(this.position);
}
