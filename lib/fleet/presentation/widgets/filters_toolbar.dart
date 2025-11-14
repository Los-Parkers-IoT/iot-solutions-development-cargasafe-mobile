import 'package:flutter/material.dart';

class FiltersToolbar extends StatelessWidget {
  const FiltersToolbar({
    super.key,
    this.searchHint = 'Search…',
    required this.onSearch,
    this.right, // 👈 nullable
  });

  final String searchHint;
  final void Function(String) onSearch;
  final Widget? right;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: searchHint,
                border: const OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: onSearch,
            ),
          ),
          if (right != null) ...[
            const SizedBox(width: 12),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: right!,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
