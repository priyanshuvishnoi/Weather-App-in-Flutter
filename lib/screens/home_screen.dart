import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/bloc/weather_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/1.png');
      case >= 300 && < 400:
        return Image.asset('assets/2.png');
      case >= 500 && < 600:
        return Image.asset('assets/3.png');
      case >= 600 && < 700:
        return Image.asset('assets/4.png');
      case >= 700 && < 800:
        return Image.asset('assets/5.png');
      case == 800:
        return Image.asset('assets/6.png');
      case > 800 && <= 804:
        return Image.asset('assets/7.png');
      default:
        return Image.asset('assets/7.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final dateFormat = DateFormat('EEEE d • hh:mm aa');
    final timeFormat = DateFormat('hh:mm aa');

    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherSuccess) {
              return SizedBox(
                height: screenHeight,
                child: Stack(
                  children: [
                    const AlignedContainer(alignment: 3),
                    const AlignedContainer(alignment: -3),
                    Align(
                      alignment: const AlignmentDirectional(0, -1.7),
                      child: Container(
                        height: 300,
                        width: 600,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFAB40),
                        ),
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                      child: Container(
                        color: Colors.transparent,
                      ),
                    ),
                    SizedBox(
                      width: screenWidth,
                      height: screenHeight,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '📍 ${state.weather.areaName}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Good Morning',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            getWeatherIcon(state.weather.weatherConditionCode!),
                            Center(
                              child: Text(
                                '${state.weather.temperature?.celsius?.round()} °C',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 55,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '${state.weather.weatherMain?.toUpperCase()}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Center(
                              child: Text(
                                dateFormat.format(state.weather.date!),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InfoWidget(
                                  label: 'Sunrise',
                                  data:
                                      timeFormat.format(state.weather.sunrise!),
                                  image: 'assets/11.png',
                                ),
                                InfoWidget(
                                  label: 'Sunset',
                                  data:
                                      timeFormat.format(state.weather.sunset!),
                                  image: 'assets/12.png',
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Divider(color: Colors.grey),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InfoWidget(
                                  label: 'Temp Max',
                                  data:
                                      '${state.weather.tempMax?.celsius?.round()} °C',
                                  image: 'assets/13.png',
                                ),
                                InfoWidget(
                                  label: 'Temp Min',
                                  data:
                                      '${state.weather.tempMin?.celsius?.round()} °C',
                                  image: 'assets/14.png',
                                ),
                              ],
                            ),
                          ]),
                    )
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class AlignedContainer extends StatelessWidget {
  final double alignment;
  const AlignedContainer({
    super.key,
    required this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(alignment, -0.3),
      child: Container(
        height: 300,
        width: 300,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  final String image;
  final String data;
  final String label;
  const InfoWidget({
    super.key,
    required this.image,
    required this.data,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          image,
          scale: 8,
        ),
        const SizedBox(height: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              data,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        )
      ],
    );
  }
}
