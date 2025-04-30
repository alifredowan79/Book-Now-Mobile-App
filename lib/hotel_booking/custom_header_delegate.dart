
import 'package:flutter/material.dart';

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  final Widget child;

  ContestTabHeader(this.child);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
