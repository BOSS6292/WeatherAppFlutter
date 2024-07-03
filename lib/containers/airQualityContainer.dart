import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/pages/home_page.dart';

import '../provider/data_provider.dart';

Widget buildAirContainer(BuildContext context, Animation<double> _animation) {
  final provider = Provider.of<DataProvider>(context); // Adjust as per your actual provider usage

  return Container(
    height: 185,
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: const Color(0xFF003A8C),
    ),
    child: provider.forecastModel != null
        ? Padding(
      padding: const EdgeInsets.all(16.0),
      child: FadeTransition(
        opacity: _animation, // Ensure _animation is defined and managed properly
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Today',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SF-Pro-Display-Regular',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  provider.getCurrentMonthAndTime(),
                  style: const TextStyle(
                    fontFamily: 'SF-Pro-Display-Regular',
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Adjusted to 10 pixels
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100, // Adjusted to 100 pixels
                width: 250,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.getTodaysData().length,
                  itemBuilder: (BuildContext context, int index) {
                    final todaysData =
                    context.watch<DataProvider>().getTodaysData();
                    if (index >= todaysData.length) {
                      return Container();
                    }
                    final tempData =
                    todaysData[index].main!.temp!.ceil();
                    final timeData = provider.printForecastItems(
                        todaysData[index].dtTxt!);
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 8.0),
                      width: 50,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${tempData}°',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontFamily: 'SF-Pro-Display-Regular',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            timeData ?? 'NA',
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'SF-Pro-Display-Regular',
                                color: Colors.white),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    )
        : Shimmer.fromColors(
      baseColor: Colors.white24,
      highlightColor: Colors.white60,
      child: Container(
        height: double.infinity,
        // Cover entire height of parent
        width: double.infinity,
        // Cover entire width of parent
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFF003A8C),
        ),
      ),
    ),
  );
}

