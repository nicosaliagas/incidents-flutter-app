import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_app/src/features/new_incident/models/category.dart';
import 'package:my_app/src/features/settings/model/locale_model.dart';
import 'package:my_app/src/features/incidents/models/incident_model.dart';
import 'package:my_app/src/features/incidents/widgets/detail_incident.dart';

class NewIncidentForm extends StatefulWidget {
  NewIncidentForm(
      {super.key,
      required this.categories,
      this.datas = 1,
      required this.onDateTimeChanged});

  final List<Category> categories;
  final ValueChanged<int> onDateTimeChanged;
  int datas = 1;

  @override
  State<NewIncidentForm> createState() =>
      _NewIncidentFormState(selectedCategory: this.datas);
}

class _NewIncidentFormState extends State<NewIncidentForm> {
  int selectedCategory;

  _NewIncidentFormState({required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      // Initial Value
      value: selectedCategory,

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),

      // Array list of items
      items: widget.categories.map((Category category) {
        return DropdownMenuItem(
          value: category.id,
          child: Text(category.name),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (int? newValue) {
        setState(() {
          selectedCategory = newValue!;
          widget.onDateTimeChanged(selectedCategory);
        });
      },
    );
  }
}
