import 'package:flutter/material.dart';
import 'package:notes_app/model/country/country.dart';
import 'package:notes_app/widget/country_picker.dart';
import 'package:notes_app/widget/notes_text_field.dart';

class MobileField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(Country value)? onSelectCountry;

  const MobileField({
    super.key,
    required this.controller,
    this.onSelectCountry,
  });

  @override
  State<MobileField> createState() => _MobileFieldState();
}

class _MobileFieldState extends State<MobileField> {
  Country selectedCountry = Country(
    name: 'India',
    code: 'IN',
    dialCode: '+91',
    flag: '🇮🇳',
  );

  @override
  Widget build(BuildContext context) {
    return NotesTextField(
      label: 'Mobile Number',
      controller: widget.controller,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your mobile number';
        }
        if (value.length < 10) {
          return 'Please enter a valid mobile number';
        }
        return null;
      },
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 8.0),
        child: GestureDetector(
          onTap: () {
            showCountryPicker(
              context: context,
              selectedCountry: selectedCountry,
              onCountrySelected: (Country c) {
                setState(() => selectedCountry = c);
              },
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                selectedCountry.flag,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                selectedCountry.dialCode,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      hintText: '1234567890',
    );
  }
}
