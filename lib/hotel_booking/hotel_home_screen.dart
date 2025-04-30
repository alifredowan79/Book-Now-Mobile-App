
import 'package:flutter/material.dart';
import 'hotel_list_view.dart';
import 'hotel_app_theme.dart';
import 'model/hotel_list_data.dart';
import 'model/hotel_api_service.dart';
import 'custom_header_delegate.dart';


class HotelHomeScreen extends StatefulWidget {
  @override
  _HotelHomeScreenState createState() => _HotelHomeScreenState();
}

class _HotelHomeScreenState extends State<HotelHomeScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  List<HotelListData> hotelList = [];
  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final fetchedHotels = await HotelApiService.fetchHotels();
      setState(() {
        hotelList = fetchedHotels;
      });
    } catch (e) {
      print('Error fetching hotel data: \$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                children: <Widget>[
                  getAppBarUI(),
                  Expanded(
                    child: hotelList.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : NestedScrollView(
                            controller: _scrollController,
                            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                              return <Widget>[
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                      return Column(
                                        children: <Widget>[
                                          getSearchBarUI(),
                                          getTimeDateUI(),
                                        ],
                                      );
                                    },
                                    childCount: 1,
                                  ),
                                ),
                                SliverPersistentHeader(
                                  pinned: true,
                                  floating: true,
                                  delegate: ContestTabHeader(
                                    getFilterBarUI(),
                                  ),
                                ),
                              ];
                            },
                            body: Container(
                              color: HotelAppTheme.buildLightTheme().colorScheme.background,
                              child: ListView.builder(
                                itemCount: hotelList.length,
                                padding: const EdgeInsets.only(top: 8),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (BuildContext context, int index) {
                                  final int count = hotelList.length > 10 ? 10 : hotelList.length;
                                  final Animation<double> animation = Tween<double>(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                      parent: animationController!,
                                      curve: Interval(
                                        (1 / count) * index, 1.0,
                                        curve: Curves.fastOutSlowIn,
                                      ),
                                    ),
                                  );
                                  animationController?.forward();
                                  return HotelListView(
                                    callback: () {},
                                    hotelData: hotelList[index],
                                    animation: animation,
                                    animationController: animationController!,
                                  );
                                },
                              ),
                            ),
                          ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return AppBar(
      title: const Text('Hotel List (API Data)'),
      backgroundColor: Colors.blue,
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search hotels...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Start: \${startDate.day}/\${startDate.month}/\${startDate.year}'),
          Text('End: \${endDate.day}/\${endDate.month}/\${endDate.year}'),
        ],
      ),
    );
  }

  Widget getFilterBarUI() {
    return Container(
      height: 60,
      color: Colors.white,
      alignment: Alignment.center,
      child: const Text(
        'Filter Bar',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
}
