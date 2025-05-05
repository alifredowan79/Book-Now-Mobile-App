import 'package:flutter/material.dart';
import 'booking_confirmation_screen.dart';

class HotelDetailScreen extends StatefulWidget {
  final dynamic hotelData;

  const HotelDetailScreen({Key? key, required this.hotelData}) : super(key: key);

  @override
  State<HotelDetailScreen> createState() => _HotelDetailScreenState();
}

class _HotelDetailScreenState extends State<HotelDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final hotel = widget.hotelData;

    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.titleTxt ?? 'Hotel Details'),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hotel Image
            Image.network(
              hotel.imagePath ?? '',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotel.titleTxt ?? '',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
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

                  Text(
                    "৳${hotel.perNight}/night",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),

                  // Rating
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          index < (hotel.rating?.round() ?? 0)
                              ? Icons.star
                              : Icons.star_border,
                          size: 20,
                          color: Colors.teal,
                        );
                      }),
                      const SizedBox(width: 8),
                      Text(
                        "${hotel.rating} (${hotel.reviews} Reviews)",
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    "This is a luxurious hotel located in a prime area with top-class service, great ambiance, and excellent customer reviews.",
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 80), // Space for button
                ],
              ),
            ),
          ],
        ),
      ),

      // Book Now Button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingConfirmationScreen(),
              ),
            );
          },
          child: const Text(
            "Book Now",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
