import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/provider/data_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // Adjust duration as needed
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        titleTextStyle: const TextStyle(
          fontFamily: 'SF-Pro-',
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 18,
        ),
        backgroundColor: const Color(0xFF003A8C),
      ),
      body: SafeArea(
        child: Consumer<DataProvider>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF08244F),
                        Color(0xFF134CB5),
                        Color(0xFF0B42AB)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          FadeTransition(
                            opacity: _animation,
                            child: const Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: 25.0,
                            ),
                          ),
                          const SizedBox(width: 5.0),
                          provider.weatherModel != null
                              ? FadeTransition(
                                  opacity: _animation,
                                  child: Text(
                                    provider.weatherModel!.name ?? 'Loading...',
                                    style: const TextStyle(
                                      fontFamily: 'SF-Pro-',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.white24,
                                  highlightColor: Colors.white60,
                                  child: Container(
                                    width: 100,
                                    height: 18,
                                    color: Colors.white,
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          provider.weatherModel != null
                              ? FadeTransition(
                                  opacity: _animation,
                                  child: Image.asset(
                                    provider.getWeatherIcon(provider
                                        .weatherModel!.weather![0].main),
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.white24,
                                  highlightColor: Colors.white60,
                                  child: Container(
                                    width: 200,
                                    height: 200,
                                    color: Colors.white,
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          provider.weatherModel != null
                              ? FadeTransition(
                                  opacity: _animation,
                                  child: Stack(
                                    children: [
                                      FadeTransition(
                                        opacity: _animation,
                                        child: Text(
                                          '${provider.weatherModel!.main!.temp!.ceil()}°',
                                          style: const TextStyle(
                                            fontFamily: 'SF-Pro-',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 74,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.white24,
                                  highlightColor: Colors.white60,
                                  child: Container(
                                    width: 100,
                                    height: 74,
                                    color: Colors.white,
                                  ),
                                ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          provider.weatherModel != null
                              ? FadeTransition(
                                  opacity: _animation,
                                  child: Text(
                                    'Max.: ${provider.weatherModel!.main!.tempMax!.ceil()}°  Min.: ${provider.weatherModel!.main!.tempMin!.ceil()}°',
                                    style: const TextStyle(
                                      fontFamily: 'SF-Pro-Display-Regular',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.white24,
                                  highlightColor: Colors.white60,
                                  child: Container(
                                    width: 200,
                                    height: 36,
                                    color: Colors.white,
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          provider.weatherModel != null
                              ? FadeTransition(
                                  opacity: _animation,
                                  child: Container(
                                    width: 300,
                                    height: 47,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: const Color(0xFF003A8C),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(width: 20.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              'assets/icons/windy.png',
                                              width: 14,
                                              height: 16,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '${provider.weatherModel!.wind!.speed} km/h',
                                              style: const TextStyle(
                                                fontFamily:
                                                    'SF-Pro-Display-Regular',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 20.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              'assets/icons/temp.png',
                                              width: 14,
                                              height: 16,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '${provider.weatherModel!.main!.temp!.ceil()}',
                                              style: const TextStyle(
                                                fontFamily:
                                                    'SF-Pro-Display-Regular',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 20.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              'assets/icons/hazzy.png',
                                              width: 14,
                                              height: 16,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '${provider.weatherModel!.main!.humidity}%',
                                              style: const TextStyle(
                                                fontFamily:
                                                    'SF-Pro-Display-Regular',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(width: 20.0),
                                      ],
                                    ),
                                  ),
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.white24,
                                  highlightColor: Colors.white60,
                                  child: Container(
                                    width: 200,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white24,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      //Today Forecast
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        height: 185,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF003A8C),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            provider.forecastModel != null
                                ? FadeTransition(
                                    opacity: _animation,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Today',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              provider.getCurrentMonthAndTime(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        // Adding some space between the row and the list
                                        SizedBox(
                                          height: 100,
                                          // Define the height of the ListView.builder
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: provider
                                                .forecastModel!.list!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final tempData = provider
                                                  .forecastModel!
                                                  .list![index]!
                                                  .main!
                                                  .temp!
                                                  .ceil();
                                              final timeData = provider.printForecastItems(provider.forecastModel!.list![index]!.dtTxt!);
                                              return Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Container(
                                                  height: 21,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.blue),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    color: const Color(0xFF2566A3),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                          '${tempData.toString()}°',
                                                          style: const TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)),
                                                      Text(timeData ?? 'NA',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .grey)),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Shimmer.fromColors(
                                    baseColor: Colors.white24,
                                    highlightColor: Colors.white60,
                                    child: Container(
                                      width: 300,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white24,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
