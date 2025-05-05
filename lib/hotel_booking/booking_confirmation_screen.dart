import 'package:flutter/material.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final String hotelName;
  final String dateRange;
  final int price;

  const BookingConfirmationScreen({
    Key? key,
    required this.hotelName,
    required this.dateRange,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Booking Confirmed")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              "Your booking is confirmed!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 30),
            Text("🏨 Hotel: $hotelName", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("📅 Dates: $dateRange", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("💳 Total Price: ৳$price", style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
