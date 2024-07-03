import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/data_provider.dart';

Widget buildAirContainer(BuildContext context, Animation<double> animation) {
  final provider = Provider.of<DataProvider>(context);

  return Container(
    height: 185,
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: const Color(0xFF003A8C),
    ),
    child: provider.airQualityModel != null
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
                Image.asset(
                  'assets/icons/windy.png',
                  width: 14,
                  height: 16,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                const Text(
                  'AIR QUALITY',
                  style: TextStyle(
                    fontFamily: 'SF-Pro-Display-Regular',
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 130,
              width: 300,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${provider.airQualityModel!.list![0].main!.aqi}',
                          style: const TextStyle(
                            fontSize: 80,
                            color: Colors.white,
                            fontFamily: 'SF-Pro-Display-Regular',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.getAirQualityInfo(provider.airQualityModel!.list![0].main!.aqi.toString()).message,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'SF-Pro-Display-Regular',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              provider.getAirQualityInfo(provider.airQualityModel!.list![0].main!.aqi.toString()).recommendation,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontFamily: 'SF-Pro-Display-Regular',
                                fontWeight: FontWeight.normal,
                              ),
                              maxLines: null,
                              overflow: TextOverflow.visible,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
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
