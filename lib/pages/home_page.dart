import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/data_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    Provider.of<DataProvider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherInfo'),
      ),
      body: Consumer<DataProvider>(
        builder: (context, provider, child) => provider.hasDataLoaded
            ? provider.weatherModel!.name!.isEmpty
            ? const Center(
          child: Text('No Name!'),
        )
            : Center(
          child: Text(
            '${provider.weatherModel!.name}',
            style: const TextStyle(fontSize: 24),
          ),
        )
            : const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
