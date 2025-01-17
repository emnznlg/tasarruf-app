import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_range_provider.g.dart';

@riverpod
class DateRangeNotifier extends _$DateRangeNotifier {
  @override
  DateTimeRange? build() => null;

  void setDateRange(DateTimeRange? range) {
    state = range;
  }
}
