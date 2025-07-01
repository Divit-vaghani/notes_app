import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/model/country/country.dart';
import 'package:notes_app/route_config/route_config.dart';

final List<Country> countryList = [
  Country(name: 'United States', code: 'US', dialCode: '+1', flag: '🇺🇸'),
  Country(name: 'India', code: 'IN', dialCode: '+91', flag: '🇮🇳'),
  Country(name: 'Nepal', code: 'NP', dialCode: '+977', flag: '🇳🇵'),
  Country(name: 'Netherlands', code: 'NL', dialCode: '+31', flag: '🇳🇱'),
  Country(name: 'New Zealand', code: 'NZ', dialCode: '+64', flag: '🇳🇿'),
  Country(name: 'Albania', code: 'AL', dialCode: '+355', flag: '🇦🇱'),
  Country(name: 'Algeria', code: 'DZ', dialCode: '+213', flag: '🇩🇿'),
  Country(name: 'Afghanistan', code: 'AF', dialCode: '+93', flag: '🇦🇫'),
];

Future<void> showCountryPicker({
  required BuildContext context,
  required Country selectedCountry,
  required ValueChanged<Country> onCountrySelected,
}) async {
  showModalBottomSheet(
    context: context,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
    ),
    builder: (_) => CountryPickerModal(
      selectedCountry: selectedCountry,
      onCountrySelected: onCountrySelected,
    ),
  );
}

class CountryPickerModal extends StatefulWidget {
  final Country selectedCountry;
  final ValueChanged<Country> onCountrySelected;

  const CountryPickerModal({
    super.key,
    required this.selectedCountry,
    required this.onCountrySelected,
  });

  @override
  State<CountryPickerModal> createState() => _CountryPickerModalState();
}

class _CountryPickerModalState extends State<CountryPickerModal> {
  late List<Country> filteredCountries;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCountries = List.from(countryList)
      ..sort((a, b) => a.name.compareTo(b.name));
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCountries = countryList.where((country) {
        return country.name.toLowerCase().contains(query) ||
            country.dialCode.contains(query);
      }).toList()
        ..sort((a, b) => a.name.compareTo(b.name));
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 1,
        builder: (context, scrollController) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Select Country",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => router.pop(),
                    icon: Icon(Icons.close, size: 24.sp),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _SelectedCountryTile(country: widget.selectedCountry),
              const Divider(),
              _buildSearchField(),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: filteredCountries.length,
                  itemBuilder: (_, index) {
                    final country = filteredCountries[index];
                    return ListTile(
                      onTap: () {
                        widget.onCountrySelected(country);
                        Navigator.pop(context);
                      },
                      leading: Text(country.flag,
                          style: const TextStyle(fontSize: 24)),
                      title: Text(country.name),
                      trailing: Text(country.dialCode),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return CupertinoSearchTextField(
      controller: _searchController,
      style: TextStyle(color: Colors.black, fontSize: 17.sp),
      placeholder: 'Country name',
    );
  }
}

class _SelectedCountryTile extends StatelessWidget {
  final Country country;

  const _SelectedCountryTile({required this.country});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(country.flag, style: const TextStyle(fontSize: 24)),
      title: Text(country.name, style: const TextStyle(color: Colors.teal)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(country.dialCode, style: const TextStyle(color: Colors.teal)),
          const SizedBox(width: 4),
          const Icon(Icons.check, color: Colors.teal),
        ],
      ),
    );
  }
}
