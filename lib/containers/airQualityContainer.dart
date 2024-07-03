import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/data_provider.dart';

Widget buildAirContainer(BuildContext context, Animation<double> animation) {
  final provider = Provider.of<DataProvider>(context);

  return Container(
    height: 185.h,
    width: 300.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.r),
      color: Colors.transparent,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.05),
                ],
              ),
            ),
          ),
          provider.airQualityModel != null
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
                        width: 14.w,
                        height: 16.h,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'AIR QUALITY',
                        style: TextStyle(
                          fontFamily: 'SF-Pro-Display-Regular',
                          fontWeight: FontWeight.normal,
                          fontSize: 15.sp,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 130.h,
                    width: 300.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${provider.airQualityModel!.list![0].main!.aqi}',
                              style: TextStyle(
                                fontSize: 80.sp,
                                color: Colors.white,
                                fontFamily: 'SF-Pro-Display-Regular',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.getAirQualityInfo(provider.airQualityModel!.list![0].main!.aqi.toString()).message,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.white,
                                    fontFamily: 'SF-Pro-Display-Regular',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  provider.getAirQualityInfo(provider.airQualityModel!.list![0].main!.aqi.toString()).recommendation,
                                  style: TextStyle(
                                    fontSize: 15.sp,
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
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
