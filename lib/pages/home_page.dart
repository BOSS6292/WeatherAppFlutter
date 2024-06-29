import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/data_provider.dart';
import 'package:weather_app/utils/helper_functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<DataProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.greeting,
                            style: GoogleFonts.poppins(
                              fontSize: 24.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            provider.subtitle,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: OutlinedButton.icon(
                          onPressed: () {
                            if (provider.locationAccess) {
                              showMsg(context, 'Has location access!');
                            } else {
                              showMsg(context, 'No location access');
                              provider.init();
                            }
                          },
                          icon: const Icon(
                            Icons.location_on,
                            color: Colors.lightBlueAccent,
                            size: 16,
                          ),
                          label: provider.weatherModel != null
                              ? Text(
                            '${provider.weatherModel!.name}',
                            style: GoogleFonts.poppins(
                              color: Colors.lightBlueAccent,
                              fontSize: 12,
                            ),
                          )
                              : Text(
                            'Fetching...',
                            style: GoogleFonts.poppins(
                              color: Colors.lightBlueAccent,
                              fontSize: 12,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            side: const BorderSide(color: Colors.lightBlueAccent),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueGrey,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${provider.weatherModel?.main?.temp?.ceil()}°',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${provider.weatherModel?.weather?[0].main ?? 'Weather'} / ${provider.weatherModel?.weather?[0].description ?? 'Description'}',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (provider.weatherModel != null)
                                Image.asset(
                                  provider.getWeatherIcon(provider.weatherModel!.weather![0].main),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.contain,
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
