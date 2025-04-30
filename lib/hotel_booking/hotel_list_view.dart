
import 'package:flutter/material.dart';
import 'model/hotel_list_data.dart';

class HotelListView extends StatelessWidget {
  final VoidCallback callback;
  final HotelListData hotelData;
  final AnimationController animationController;
  final Animation<double> animation;

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
        splashColor: Colors.transparent,
        onTap: callback,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Icon(Icons.hotel, size: 40, color: Colors.blue),
            title: Text(hotelData.titleTxt ?? 'Hotel Name'),
            subtitle: Text(hotelData.subTxt ?? 'Hotel Subtitle'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        ),
      ),
    );
  }
}
