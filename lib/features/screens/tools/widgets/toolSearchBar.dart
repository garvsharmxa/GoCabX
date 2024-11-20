import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Toolsearchbar extends StatefulWidget {
  const Toolsearchbar({super.key});

  @override
  _ToolSearchBarState createState() => _ToolSearchBarState();
}

class _ToolSearchBarState extends State<Toolsearchbar> {
  final TextEditingController _searchController = TextEditingController();
  List<String> _filteredSuggestions = [];
  final List<String> _dummySuggestions = [
    'Machine 1',
    'Machine 2',
    'Machine 3',
    'Machine 4',
    'Machine 5',
    'Machine 6',
    'Machine 7',
  ];

  @override
  void initState() {
    super.initState();
    _filteredSuggestions = _dummySuggestions;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _filteredSuggestions = _dummySuggestions
          .where((suggestion) => suggestion
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: TextFormField(
            controller: _searchController,
            decoration: const InputDecoration(
              focusedBorder: InputBorder.none, // Remove focus border
              enabledBorder: InputBorder.none,
              prefixIcon: Icon(
                Iconsax.search_normal,
                color: Colors.grey,
              ),

              hintText: 'Search here',
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
          ),
        ),
        if (_searchController.text.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SizedBox(
              height: 200, // Adjust the height as needed
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8.0),
                itemCount: _filteredSuggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_filteredSuggestions[index]),
                    onTap: () {
                      // Set the selected item to the search controller
                      _searchController.text = _filteredSuggestions[index];
                      _onSearchChanged(); // Refresh the filtered suggestions
                    },
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
