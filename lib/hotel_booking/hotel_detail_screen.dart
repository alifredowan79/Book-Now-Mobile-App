import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'booking_confirmation_screen.dart';

class HotelDetailScreen extends StatefulWidget {
  final dynamic hotelData;

  const HotelDetailScreen({Key? key, required this.hotelData}) : super(key: key);

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  bool isFavorite = false;
  DateTime? checkInDate;
  DateTime? checkOutDate;
  int roomCount = 1;
  String roomQuality = 'Standard';

  final List<String> roomQualities = ['Standard', 'Deluxe', 'Executive', 'Suite'];

  Future<void> _pickDateRange() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        checkInDate = picked.start;
        checkOutDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hotel = widget.hotelData;
    final dateText = (checkInDate != null && checkOutDate != null)
        ? '${DateFormat('dd MMM').format(checkInDate!)} - ${DateFormat('dd MMM').format(checkOutDate!)}'
        : 'Select Dates';

    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.titleTxt ?? 'Hotel Details'),
        backgroundColor: const Color(0xFF29C4B6), // Updated Primary Color
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            color: isFavorite ? Colors.red : Colors.white,
            onPressed: () => setState(() => isFavorite = !isFavorite),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              hotel.imagePath ?? '',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(hotel.titleTxt ?? '', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.teal),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "${hotel.subTxt ?? ''} • ${hotel.dist} km",
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text("৳${hotel.perNight}/night", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),

                  //  Room Count Dropdown
                  DropdownButtonFormField<int>(
                    value: roomCount,
                    items: List.generate(5, (i) => DropdownMenuItem(value: i + 1, child: Text('${i + 1} Room(s)'))),
                    onChanged: (value) => setState(() => roomCount = value ?? 1),
                    decoration: const InputDecoration(labelText: 'Number of Rooms'),
                  ),
                  const SizedBox(height: 16),

                  // Room Quality Dropdown
                  DropdownButtonFormField<String>(
                    value: roomQuality,
                    items: roomQualities.map((q) => DropdownMenuItem(value: q, child: Text(q))).toList(),
                    onChanged: (value) => setState(() => roomQuality = value ?? 'Standard'),
                    decoration: const InputDecoration(labelText: 'Room Quality'),
                  ),
                  const SizedBox(height: 16),

                  //  Date Range
                  ListTile(
                    title: const Text('Booking Dates'),
                    subtitle: Text(dateText),
                    trailing: const Icon(Icons.date_range),
                    onTap: _pickDateRange,
                  ),

                  const SizedBox(height: 20),
                  const Text(
                    "This is a luxurious hotel located in a prime area with top-class service, great ambiance, and excellent customer reviews.",
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1DB9A6), // Deep teal for better contrast
            foregroundColor: Colors.white, // Text color
            elevation: 4,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {
            if (checkInDate == null || checkOutDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please select booking dates.")),
              );
              return;
            }

            final nights = checkOutDate!.difference(checkInDate!).inDays;
            final price = (hotel.perNight ?? 0) * nights * roomCount;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingConfirmationScreen(
                  hotelName: hotel.titleTxt ?? '',
                  dateRange: dateText,
                  price: price,
                ),
              ),
            );
          },
          child: const Text(
            "Book Now",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
