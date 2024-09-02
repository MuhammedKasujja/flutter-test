import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class PlutoGridExample extends StatefulWidget {
  const PlutoGridExample({super.key});

  @override
  State<PlutoGridExample> createState() => _PlutoGridExampleState();
}

class Employee {
  final String name;
  final int age;

  Employee(this.name, this.age);
}

class _PlutoGridExampleState extends State<PlutoGridExample> {
  List<PlutoColumn> columns = [];
  List<PlutoRow> rows = [];

  @override
  void initState() {
    super.initState();

    columns = [
      PlutoColumn(
        title: 'ID',
        field: 'id',
        type: PlutoColumnType.text(),
        enableEditingMode: false, // Enable editing for this column
      ),
      PlutoColumn(
        title: 'Name',
        field: 'name',
        type: PlutoColumnType<Employee>.autocomplete(
            options: [
              Employee('Kato', 45),
              Employee('Kimera', 30),
              Employee('Ismail', 90),
              Employee('Kasagga', 24),
            ],
            itemBuilder: (context, option) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text('${option.name} -- [${option.age}]'),
                ),
            displayStringForOption: (item) {
              return item.name;
            }),
        enableEditingMode: true,
      ),
      PlutoColumn(
        title: 'Age',
        field: 'age',
        type: PlutoColumnType.number(),
        enableEditingMode: true, // Enable editing for this column
      ),
    ];
    rows = List<PlutoRow>.generate(
      25,
      (i) => PlutoRow(cells: {
        'id': PlutoCell(value: Text('test --> $i')),
        'name': PlutoCell(value: 'Alice'),
        'age': PlutoCell(value: 25),
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PlutoGrid Editable Example')),
      body: PlutoGrid(
        columns: columns,
        rows: rows,
        onChanged: (PlutoGridOnChangedEvent event) {
          print('Changed cell value: ${event.value}');
        },
      ),
    );
  }
}

class PlutoColumnDynamic implements PlutoColumnType {
  @override
  int compare(a, b) => 0;

  @override
  bool isValid(value) => true;

  @override
  makeCompareValue(v) {}

  @override
  dynamic defaultValue;
}
