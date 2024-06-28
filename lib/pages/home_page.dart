import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/data_provider.dart';
import 'package:weather_app/utils/helper_functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*@override
  void didChangeDependencies() {
    Provider.of<DataProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<DataProvider>(
          builder: (context, provider, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0), // Adjust padding as needed
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
                              color: Colors.white, // Adjust style as needed
                            ),
                          ),
                          Text(
                            provider.subtitle,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                              color: Colors.grey, // Adjust style as needed
                            ),
                          ),
                        ],
                      ),
                      OutlinedButton.icon(
                        onPressed: () {
                          if (provider.locationAccess) {
                            showMsg(context, 'Has location Access!');
                          } else {
                            showMsg(context, 'No location Access');
                            provider.init();
                          }
                        },
                        icon: Icon(
                          Icons.location_on,
                          color: Colors.blue, // Adjust icon color as needed
                        ),
                        label: provider.weatherModel != null
                            ? Text(
                          '${provider.weatherModel!.name}',
                          style: GoogleFonts.poppins(
                            color: Colors.blue, // Adjust text color as needed
                          ),
                        )
                            : Text(
                          'Fetching...', // Show a placeholder or loading state
                          style: GoogleFonts.poppins(
                            color: Colors.blue, // Adjust text color as needed
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.blue), // Adjust border color as needed
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0), // Adjust border radius as needed
                          ),
                        ),
                      ),
                    ],
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
