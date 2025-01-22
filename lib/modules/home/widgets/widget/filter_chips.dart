import 'package:flutter/material.dart';

class FilterChips extends StatelessWidget {
  final String searchQuery;
  final String? selectedDesignation;
  final VoidCallback onClearName;
  final VoidCallback onClearDesignation;

  const FilterChips({
    Key? key,
    required this.searchQuery,
    this.selectedDesignation,
    required this.onClearName,
    required this.onClearDesignation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: [
        if (searchQuery.isNotEmpty)
          Chip(
            label: Text('Name: $searchQuery'),
            onDeleted: onClearName,
          ),
        if (selectedDesignation != null)
          Chip(
            label: Text('Designation: $selectedDesignation'),
            onDeleted: onClearDesignation,
          ),
      ],
    );
  }
}
