// Importing necessary packages.
import 'package:flutter/cupertino.dart'; // Provides iOS-style widgets for Flutter.
import 'package:flutter/material.dart'; // Provides material design widgets for Flutter.
import 'package:flutter_application_1/Widgets/info_cards.dart'; // Custom widget for displaying information cards.
import 'package:shared_preferences/shared_preferences.dart'; // Allows saving data locally.

// HistoryPage class is a StatelessWidget since the page doesn't require state maintenance.
class HistoryPage extends StatelessWidget {
  double? _deviceHeight,
      _deviceWidth; // To store device height and width for responsive layout.

  @override
  Widget build(BuildContext context) {
    // Retrieving the device height and width using MediaQuery to build a responsive UI.
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    // Returning the CupertinoPageScaffold which provides the iOS page layout.
    return CupertinoPageScaffold(
      child: Container(
        // Calling the _datacard function to display data.
        child: _datacard(),
      ),
    );
  }

  // _datacard widget is used to display the data card with retrieved SharedPreferences data.
  Widget _datacard() {
    return FutureBuilder(
      // Fetching SharedPreferences data asynchronously using a Future.
      future: SharedPreferences.getInstance(),
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.hasData) {
          // Once the data is loaded successfully from SharedPreferences, process it.
          final _prefs = _snapshot.data as SharedPreferences;
          final _date = _prefs
              .getString('bmi_date'); // Getting the date stored in preferences.
          final _data = _prefs.getStringList(
              'bmi_data'); // Getting the list containing BMI and status.

          // Returning the InfoCards widget to display the BMI and other data.
          return Center(
            child: InfoCards(
              height: _deviceHeight! *
                  0.25, // Setting the height for the InfoCard based on device height.
              width: _deviceWidth! *
                  0.75, // Setting the width for the InfoCard based on device width.
              child: Column(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, // Aligning children evenly in the column.
                crossAxisAlignment: CrossAxisAlignment
                    .center, // Centering children horizontally.
                mainAxisSize: MainAxisSize
                    .max, // Ensure the column takes up maximum vertical space.
                children: [
                  _statusText(_data![
                      1]), // Displaying the BMI status (Underweight, Normal, etc.)
                  _dateText(
                      _date!), // Displaying the date the data was recorded.
                  _bmiText(_data[
                      0]) // Displaying the BMI value formatted to two decimal points.
                ],
              ),
            ),
          );
        } else {
          // While data is loading, show an activity indicator.
          return const Center(
            child: CupertinoActivityIndicator(
              color: Colors.blue, // Set the color of the loading indicator.
            ),
          );
        }
      },
    );
  }

  // Widget for displaying the status (e.g., Underweight, Normal, Overweight).
  Widget _statusText(String _status) {
    return Text(
      _status, // Display the status.
      style: const TextStyle(
        fontSize: 30, // Setting the font size.
        fontWeight: FontWeight.w400, // Setting the font weight to regular.
      ),
    );
  }

  // Widget for displaying the date in a human-readable format.
  Widget _dateText(String _date) {
    DateTime _parseDate = DateTime.parse(
        _date); // Parsing the stored date string into a DateTime object.
    return Text(
      '${_parseDate.day}/${_parseDate.month}/${_parseDate.year}', // Displaying the formatted date.
      style: const TextStyle(
        fontSize: 15, // Smaller font for date.
        fontWeight: FontWeight.w300, // Lighter weight for the date.
      ),
    );
  }

  // Widget for displaying the BMI value with a fixed decimal format.
  Widget _bmiText(String _bmi) {
    return Text(
      double.parse(_bmi).toStringAsFixed(
          2), // Parsing the BMI value and formatting it to 2 decimal places.
      style: const TextStyle(
        fontSize: 60, // Large font size for BMI value.
        fontWeight: FontWeight.w600, // Bold font weight for BMI.
      ),
    );
  }
}
