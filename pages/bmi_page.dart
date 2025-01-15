// Importing required libraries
import 'dart:math'; // Provides mathematical operations such as pow() for calculating BMI.
import 'package:shared_preferences/shared_preferences.dart'; // Allows saving data locally.
import 'package:flutter/cupertino.dart'; // Provides iOS-style widgets for Flutter.
import 'package:flutter/material.dart'; // Provides material design widgets for Flutter.
import 'package:flutter_application_1/Widgets/info_cards.dart'; // Custom widget for displaying information cards.

// BmiPage class extends StatefulWidget to maintain state across its lifecycle.
class BmiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BMIPageState(); // Initializes state for the widget.
  }
}

// The private _BMIPageState class manages the BMI page's state.
class _BMIPageState extends State<BmiPage> {
  double? _deviceHeight,
      _deviceWidth; // To store device height and width for responsive design.
  int _age = 25,
      _weight = 160,
      _height = 70,
      _gender = 0; // Variables to store age, weight, height, and gender.

  @override
  Widget build(BuildContext context) {
    // Fetching device dimensions for responsive layout.
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      child: Center(
        child: Container(
            height: _deviceHeight! *
                0.85, // Container takes 85% of the screen height
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // A row for age and weight selection containers.
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _ageselectContainer(),
                    _weightselectContainer(),
                  ],
                ),
                _heightselectcontainer(),
                _genderselectContainer(),
                _calculatebmibutton(),
              ],
            )),
      ),
    );
  }

  // Widget for selecting age. It includes plus and minus buttons to adjust the age.
  Widget _ageselectContainer() {
    return InfoCards(
      height: _deviceHeight! * 0.20, // Height of the card container.
      width: _deviceWidth! * 0.45, // Width of the card container.
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Age yr',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            _age.toString(), // Displaying current age.
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      _age--; // Decreases age when minus button is clicked.
                    });
                  },
                  child: const Text(
                    '-',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    _age++; // Increases age when plus button is clicked.
                  },
                  child: const Text(
                    '+',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // Widget for selecting weight.
  Widget _weightselectContainer() {
    return InfoCards(
      height: _deviceHeight! * 0.20,
      width: _deviceWidth! * 0.45,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Weight lbs',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            _weight.toString(),
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      _weight--; // Decreases weight when minus button is clicked.
                    });
                  },
                  child: const Text(
                    '-',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    _weight++; // Increases weight when plus button is clicked.
                  },
                  child: const Text(
                    '+',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  // Widget for selecting height using a Cupertino slider.
  Widget _heightselectcontainer() {
    return InfoCards(
      height: _deviceHeight! * 0.15,
      width: _deviceWidth! * 0.90,
      child: Column(
        children: [
          Text(
            'Height in ',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            _height.toString(),
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: _deviceWidth! * 0.80,
            child: CupertinoSlider(
                min: 0,
                max: 97,
                divisions: 97,
                value: _height.toDouble(),
                onChanged: (_value) {
                  setState(() {
                    _height =
                        _value.toInt(); // Sets height based on slider value.
                  });
                }),
          ),
        ],
      ),
    );
  }

  // Widget for gender selection using a CupertinoSlidingSegmentedControl.
  Widget _genderselectContainer() {
    return InfoCards(
      height: _deviceHeight! * 0.11,
      width: _deviceWidth! * 0.90,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Gender',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          CupertinoSlidingSegmentedControl(
            groupValue: _gender,
            children: const {
              0: Text("Male"),
              1: Text("Female"),
            },
            onValueChanged: (_value) {
              setState(() {
                _gender = _value as int; // Updates gender when changed.
              });
            },
          )
        ],
      ),
    );
  }

  // Widget for the "Calculate BMI" button.
  Widget _calculatebmibutton() {
    return Container(
      height: _deviceHeight! * 0.07,
      child: CupertinoButton.filled(
        child: Text("Calculate BMI"),
        onPressed: () {
          if (_height > 0 && _weight > 0 && _age > 0) {
            // Calculates BMI if height, weight, and age are valid.
            double _bmi = 700 * (_weight / pow(_height, 2));
            _showbmialertdialog(_bmi);
          }
        },
      ),
    );
  }

  // Displays a dialog with the calculated BMI and health status.
  void _showbmialertdialog(double _bmi) {
    String? _status;
    if (_bmi < 18.5) {
      _status = "Underweight";
    } else if (_bmi >= 18.5 && _bmi < 25) {
      _status = "Normal";
    } else if (_bmi >= 25 && _bmi < 30) {
      _status = "Overweight";
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext _context) {
        return CupertinoAlertDialog(
          title: Text(_status!),
          content: Text(
            _bmi.toStringAsFixed(2), // Displays the calculated BMI.
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                _saveResult(
                  _bmi.toString(),
                  _status!,
                );
                Navigator.pop(_context);
              },
            ),
          ],
        );
      },
    );
  }

  // Saves the BMI result and status to shared preferences.
  void _saveResult(String _bmi, String _status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      '_bmi_date',
      DateTime.now().toString(), // Stores the date of the BMI result.
    );
    await prefs.setStringList(
      "bmi_list",
      <String>[_bmi, _status], // Stores the BMI value and status.
    );
  }
}
