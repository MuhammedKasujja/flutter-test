import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

class PlutoGridExample extends StatefulWidget {
  const PlutoGridExample({super.key});

  @override
  State<PlutoGridExample> createState() => _PlutoGridExampleState();
}

class _PlutoGridExampleState extends State<PlutoGridExample> {
  List<PlutoColumn> columns = [];
  List<PlutoRow> rows = [];

  @override
  void initState() {
    super.initState();

    columns = [
      PlutoColumn(
        title: 'Name',
        field: 'name',
        type: PlutoColumnType.text(),
        enableEditingMode: false, // Enable editing for this column
      ),
      PlutoColumn(
        title: 'Age',
        field: 'age',
        type: PlutoColumnType.number(),
        enableEditingMode: true, // Enable editing for this column
      ),
      PlutoColumn(
        title: 'Role',
        field: 'role',
        type: PlutoColumnDynamic(),
        renderer: (rendererContext) => rendererContext.cell.value as Widget,
        enableEditingMode: true, // Enable editing for this column
      ),
    ];
    rows = List<PlutoRow>.generate(
      1000,
      (i) => PlutoRow(cells: {
        'name': PlutoCell(value: 'Alice'),
        'age': PlutoCell(value: 25),
        'role': PlutoCell(value: Text('test --> $i')),
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


