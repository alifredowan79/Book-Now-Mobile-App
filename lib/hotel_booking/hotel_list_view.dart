import 'package:flutter/material.dart';

class HotelListView extends StatelessWidget {
  final dynamic hotelData;
  final AnimationController animationController;
  final Animation<double> animation;
  final VoidCallback callback;

  const HotelListView({
    Key? key,
    required this.hotelData,
    required this.animationController,
    required this.animation,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: InkWell(
        onTap: callback,
        child: hotelCard(hotelData),
      ),
    );
  }

  Widget hotelCard(dynamic hotelData) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hotel Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(
              hotelData.imagePath ?? '',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
            ),
          ),

          // Hotel info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        hotelData.titleTxt ?? '',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "\$${hotelData.perNight ?? 0}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Subtitle and distance
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.teal),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "${hotelData.subTxt ?? ''} • ${hotelData.dist} km",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Rating and reviews
                Row(
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        index < (hotelData.rating?.round() ?? 0)
                            ? Icons.star
                            : Icons.star_border,
                        size: 16,
                        color: Colors.teal,
                      );
                    }),
                    const SizedBox(width: 6),
                    Text(
                      "${hotelData.reviews ?? 0} Reviews",
                      style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
