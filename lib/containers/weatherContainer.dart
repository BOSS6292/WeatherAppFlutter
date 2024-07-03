import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/data_provider.dart';

Widget buildWeatherContainer(BuildContext context, Animation<double> animation) {
  final provider = Provider.of<DataProvider>(context);

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
        opacity: animation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.today,
                  color: Colors.white,
                  size: 25.0,
                ),
                const Text(
                  'Today',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'SF-Pro-Display-Regular',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 120,),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
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
                            '$tempData°',
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
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFF003A8C),
        ),
      ),
    ),
  );
}
