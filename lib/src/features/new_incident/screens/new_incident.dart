import 'package:flutter/material.dart';
import 'package:my_app/src/core/model/category.dart';
import 'package:my_app/src/core/repository/category_repository.dart';
import 'package:my_app/src/features/new_incident/widgets/new_incident_form.dart';

class NewIncident extends StatefulWidget {
  @override
  State<NewIncident> createState() => _IncidentsState();
}

class _IncidentsState extends State<NewIncident> {
  late Future<List<Category>> futureCategories;
  final CategoryRepository _categoryRepository = CategoryRepository();

  @override
  initState() {
    super.initState();
    futureCategories = _categoryRepository.fetchIncidentCategories();
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signaler"),
      ),
      body: Center(
        child: FutureBuilder<List<Category>>(
          future: futureCategories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return NewIncidentForm(
                  categories: snapshot.data!,
                  callbackWidget: (datas) {
                    setState(() {
                      print("Return from the widget $datas");

                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("L'incident n° $datas créé avec succès !")));
                    });
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
