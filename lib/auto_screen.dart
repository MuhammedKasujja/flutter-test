import 'package:flutter/material.dart';
import 'package:flutter_objectbox/auto_complete.dart';

class AutoScreens extends StatelessWidget {
  const AutoScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CustomAutocomplete<String>(
            options: const [
              'Apple',
              'Banana',
              'Cherry',
              'Date',
              'Elderberry',
              'Fig',
              'Grape',
            ],
            displayStringForOption: (String option) => option,
            decoration: const InputDecoration(
              labelText: 'Search for a fruit',
              border: OutlineInputBorder(),
            ),
            onSelected: (String selection) {},
          ),
          const SizedBox(height: 16,),
          CustomAutocomplete<String>(
            options: const [
              'Apple',
              'Banana',
              'Cherry',
              'Date',
              'Elderberry',
              'Fig',
              'Grape',
            ],
            displayStringForOption: (String option) => option,
            decoration: const InputDecoration(
              labelText: 'Search for a fruit',
              border: OutlineInputBorder(),
            ),
            onSelected: (String selection) {},
          ),
          const SizedBox(height: 16,),
          CustomAutocomplete<String>(
            options: const [
              'Apple',
              'Banana',
              'Cherry',
              'Date',
              'Elderberry',
              'Fig',
              'Grape',
            ],
            displayStringForOption: (String option) => option,
            decoration: const InputDecoration(
              labelText: 'Search for a fruit',
              border: OutlineInputBorder(),
            ),
            onSelected: (String selection) {},
          )
        ],
      ),
    );
  }
}
