import 'package:flutter/material.dart';

class FiltersToolbar extends StatelessWidget {
  const FiltersToolbar({
    super.key,
    this.searchHint = 'Search…',
    required this.onSearch,
    this.right = const SizedBox.shrink(),
  });

  final String searchHint;
  final void Function(String) onSearch;
  final Widget right;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffe6e6e6), width: 2),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                isDense: true,
                labelText: searchHint,
              ),
              onChanged: onSearch,
            ),
          ),
          const SizedBox(width: 12),
          right,
        ],
      ),
    );
  }
}
