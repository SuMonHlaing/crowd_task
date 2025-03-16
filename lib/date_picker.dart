import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Date Picker Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: DatePickerScreen(),
    );
  }
}

class DatePickerScreen extends StatefulWidget {
  @override
  _DatePickerScreenState createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  DateTime? _selectedDate; // Stores the selected date

  // Function to show date picker
  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(), // Default date
      firstDate: DateTime(2000), // Start date limit
      lastDate: DateTime(2100), // End date limit
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Date Picker")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display selected date
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                  width: 100,
                  height: 100,),
                SizedBox(width: 10,),
                Image.asset('assets/images/owl.jpg',width: 100,
                  height:100 ,),
              ],
            ),


            Text(
              _selectedDate == null
                  ? "No date selected"
                  : "Selected Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Pick Date Button
            ElevatedButton(
              onPressed: _pickDate,
              child: const Text("Pick Date"),
            ),
          ],
        ),
      ),
    );
  }
}
