import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // For date formatting

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,  // Center the icon in the AppBar
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,  // Align column elements to the start
        children: [
          _buildGreetingRow(),  // Build the greeting row
          _buildDateText(),  // Build the actual current date
          _buildDateSelectionRow(),  // Build the date selection row
          _buildDateFrameRow(),  // Build the frames (boxes) below date buttons
          Expanded(
            child: _buildGrid(),  // Build the info grid
          ),
        ],
      ),
    );
  }

  Widget _buildGreetingRow() {
    return Padding(
      padding: const EdgeInsets.all(4.0),  // Further reduced padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Hi User',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            'Welcome Back',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // This method will display the current date
  Widget _buildDateText() {
    String formattedDate = DateFormat('MMMM dd, yyyy').format(DateTime.now()); // Format the date

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),  // Minimized vertical padding
      child: Text(
        formattedDate,  // Display the formatted date
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  // This method builds the date selection row (Today, Tomorrow, The next two days)
  Widget _buildDateSelectionRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),  // Reduced padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Make the buttons evenly spaced
        children: [
          _buildDateButton('Today'),
          _buildDateButton('Tomorrow'),
          _buildDateButton('The next two days'),
        ],
      ),
    );
  }

  // Helper method to create a date button
  Widget _buildDateButton(String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0),  // Slightly reduced padding
        color: Colors.grey[300],
        child: Center(
          child: FittedBox(  // This will shrink the text if it's too large to fit in the container
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  // This method builds the frames under the date buttons
  Widget _buildDateFrameRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),  // Minimized padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDateFrame(),
          _buildDateFrame(),
          _buildDateFrame(),
        ],
      ),
    );
  }

  // Helper method to create a date frame (empty container)
  Widget _buildDateFrame() {
    return Expanded(
      child: Container(
        height: 85,  // Further reduced height to move content upwards
        margin: const EdgeInsets.all(2.0),  // Reduced margin for less space around the frame
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            'Placeholder',  // Replace this with dynamic content as needed
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),  // Reduced padding around the grid
      child: GridView.count(
        crossAxisCount: 2,  // Display two cards per row
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          _buildInfoCard('Heart Rate'),
          _buildInfoCard('Blood Type'),
          _buildInfoCard('Allergens/Restriction'),
          _buildInfoCard('Make Appointment'),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title) {
    return Card(
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
