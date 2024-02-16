import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rhinoapp/Utils/colors.dart/colors.dart';

import '../Screens/DashBoard/MainMenu/SiteScreen/site_viewmodel.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? value;
  final void Function(String)? onChanged;
  final Widget? icon;
  final Widget? dropdownItemBuilder;
  final Widget? selectedItemBuilder;

  CustomDropdown({
    required this.items,
    this.value,
    this.onChanged,
    this.icon,
    this.dropdownItemBuilder,
    this.selectedItemBuilder,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.items.length > 0 ? widget.items[0] : "Schedule - Selecte";
  }

  @override
  Widget build(BuildContext context) {
    final siteProvider = Provider.of<SiteViewmodel>(context);
    return Container(
      child: DropdownButton<String>(
        underline: Container(
          color: Colors.transparent,
        ),
        value: _value,
        isDense: true,
        icon: widget.icon,
        isExpanded: true,
        iconSize: 20.sp,
        elevation: 16,
        // hint: Text("Schedule - Selecte"),
        onChanged: (newValue) {
          siteProvider.changeServiceLevel(newValue!);
          setState(() {
            _value = newValue;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(newValue);
          }
        },
        items: widget.items.map((value) {
          return DropdownMenuItem<String>(
            value: value,
            child: widget.dropdownItemBuilder != null
                ? widget.dropdownItemBuilder!
                : Text(
                    value,
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontFamily: "Sofia",
                      letterSpacing: 0.5,
                      color: secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildSelectedItem() {
    return widget.selectedItemBuilder != null
        ? widget.selectedItemBuilder!
        : Text(_value!);
  }
}
