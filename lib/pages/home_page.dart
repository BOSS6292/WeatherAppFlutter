import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/provider/data_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../containers/airQualityContainer.dart';
import '../containers/weatherContainer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
      duration: const Duration(milliseconds: 1000),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
    );

    return Scaffold(
      body: SafeArea(
        child: Consumer<DataProvider>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: provider.gradientColors,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          FadeTransition(
                            opacity: _animation,
                            child: const Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: 25.0,
                            ),
                          ),
                          SizedBox(width: 5.0.w),
                          provider.weatherModel != null
                              ? FadeTransition(
                                  opacity: _animation,
                                  child: Text(
                                    provider.weatherModel!.name ?? 'Loading...',
                                    style: TextStyle(
                                      fontFamily: 'SF-Pro-',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.white24,
                                  highlightColor: Colors.white60,
                                  child: Container(
                                    width: 100.w,
                                    height: 18.h,
                                    color: Colors.white,
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(height: 20.0.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          provider.weatherModel != null
                              ? FadeTransition(
                                  opacity: _animation,
                                  child: Image.asset(
                                    provider.getWeatherIcon(provider
                                        .weatherModel!.weather![0].main),
                                    width: 200.w,
                                    height: 200.h,
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.white24,
                                  highlightColor: Colors.white60,
                                  child: Container(
                                    width: 200.w,
                                    height: 200.h,
                                    color: Colors.white,
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(height: 5.0.h),
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
                                          style: TextStyle(
                                            fontFamily: 'SF-Pro-',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 74.sp,
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
                                    width: 100.w,
                                    height: 74.h,
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
                                    style: TextStyle(
                                      fontFamily: 'SF-Pro-Display-Regular',
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.white24,
                                  highlightColor: Colors.white60,
                                  child: Container(
                                    width: 200.w,
                                    height: 36.h,
                                    color: Colors.white,
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(height: 10.0.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          provider.weatherModel != null
                              ? FadeTransition(
                                  opacity: _animation,
                                  child: Container(
                                    width: 300.w,
                                    height: 47.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: const Color(0xFF003A8C),
                                    ),
                                    padding: EdgeInsets.all(10.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: 20.0.w),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              'assets/icons/windy.png',
                                              width: 14.w,
                                              height: 16.h,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                              '${provider.weatherModel!.wind!.speed} km/h',
                                              style: TextStyle(
                                                fontFamily:
                                                    'SF-Pro-Display-Regular',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 20.0.w),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              'assets/icons/temp.png',
                                              width: 14.w,
                                              height: 16.h,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                              '${provider.weatherModel!.main!.temp!.ceil()}',
                                              style: TextStyle(
                                                fontFamily:
                                                    'SF-Pro-Display-Regular',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 20.0.w),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              'assets/icons/hazzy.png',
                                              width: 14.w,
                                              height: 16.h,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 5.w),
                                            Text(
                                              '${provider.weatherModel!.main!.humidity}%',
                                              style: TextStyle(
                                                fontFamily:
                                                    'SF-Pro-Display-Regular',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.sp,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(width: 20.0.w),
                                      ],
                                    ),
                                  ),
                                )
                              : Shimmer.fromColors(
                                  baseColor: Colors.white24,
                                  highlightColor: Colors.white60,
                                  child: Container(
                                    width: 200.w,
                                    height: 36.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      color: const Color(0xFF003A8C),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(height: 10.0.h),
                      CarouselSlider(
                        items: [
                          SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: buildWeatherContainer(context, _animation),
                          ),
                          SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: buildAirContainer(context, _animation),
                          ),
                        ],
                        options: CarouselOptions(
                          height: 200.h,
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0.w),
                        child: provider.weatherModel != null &&
                                provider.weatherModel!.weather != null &&
                                provider.weatherModel!.weather!.isNotEmpty
                            ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    provider.weatherModel!.weather![0].description!
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.white,
                                      fontFamily: 'SF-Pro-Display-Regular',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ],
                            )
                            : Shimmer.fromColors(
                                baseColor: Colors.white24,
                                highlightColor: Colors.white60,
                                child: Container(
                                  width: 100.w,
                                  height: 18.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: const Color(0xFF003A8C),
                                  ),
                                ),
                              ),
                      )
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
