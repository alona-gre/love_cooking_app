import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:love_cooking_app/src/features/filters/domain/filter_item.dart';

/// Model class representing the user's filtering settings.

class Filtering {
  /// All the filters, where:
  /// - key: String which means a filter name
  /// - value: bool for on/off
  final Map<String, bool> filters;

  const Filtering([this.filters = const {}]);

  Map<String, dynamic> toMap() {
    return {
      'filters': filters,
    };
  }

  factory Filtering.fromMap(Map<String, dynamic> map) {
    return Filtering(
      Map<String, bool>.from(map['filters']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Filtering.fromJson(String source) =>
      Filtering.fromMap(json.decode(source));

  @override
  String toString() => 'Filtering(filters: $filters)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Filtering && mapEquals(other.filters, filters);
  }

  @override
  int get hashCode => filters.hashCode;
}

extension FilterItems on Filtering {
  List<FilterItem> toItemsList() {
    return filters.entries.map((entry) {
      return FilterItem(
        filterName: entry.key,
        isEnabled: entry.value,
      );
    }).toList();
  }
}
