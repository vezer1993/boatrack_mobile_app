import 'package:boatrack_mobile_app/models/check_segment.dart';

class ExpandableItem {
  ExpandableItem({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
    required this.segment,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
  CheckSegment segment;
}