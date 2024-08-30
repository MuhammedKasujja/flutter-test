import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class Employee {
  Employee(this.name, this.age, this.role);

  String name;
  int age;
  String role;
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(this.employees) {
    buildDataGridRows();
  }

  List<Employee> employees = [];
  List<DataGridRow> dataGridRows = [];

  void buildDataGridRows() {
    dataGridRows = employees.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'Name', value: dataGridRow.name),
        DataGridCell<int>(columnName: 'Age', value: dataGridRow.age),
        DataGridCell<String>(columnName: 'Role', value: dataGridRow.role),
      ]);
    }).toList();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      for (var cell in row.getCells())
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(cell.value.toString()),
        ),
    ]);
  }

  // @override
  // Widget? buildEditWidget(
  //     DataGridRow row, DataGridCell cell, String columnName) {
  //   final isNumericType = cell.value.runtimeType == int;

  //   return TextField(
  //     controller: TextEditingController()..text = cell.value.toString(),
  //     keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
  //     onSubmitted: (newValue) {
  //       final index = dataGridRows.indexOf(row);
  //       if (columnName == 'Name') {
  //         employees[index].name = newValue;
  //       } else if (columnName == 'Age') {
  //         employees[index].age = int.parse(newValue);
  //       } else if (columnName == 'Role') {
  //         employees[index].role = newValue;
  //       }
  //       notifyListeners();
  //     },
  //   );
  // }
}

class SyncfusionDataGridExample extends StatelessWidget {
  final EmployeeDataSource _employeeDataSource = EmployeeDataSource([
    Employee('Alice', 25, 'Developer'),
    Employee('Bob', 30, 'Designer'),
    Employee('Charlie', 35, 'Manager'),
    Employee('Alice', 25, 'Developer'),
    Employee('Bob', 30, 'Designer'),
    Employee('Charlie', 35, 'Manager'),
    Employee('Alice', 25, 'Developer'),
    Employee('Bob', 30, 'Designer'),
    Employee('Charlie', 35, 'Manager'),
    Employee('Alice', 25, 'Developer'),
    Employee('Bob', 30, 'Designer'),
    Employee('Charlie', 35, 'Manager'),
    Employee('Alice', 25, 'Developer'),
    Employee('Bob', 30, 'Designer'),
    Employee('Charlie', 35, 'Manager'),
    Employee('Alice', 25, 'Developer'),
    Employee('Bob', 30, 'Designer'),
    Employee('Charlie', 35, 'Manager'),
    Employee('Alice', 25, 'Developer'),
    Employee('Bob', 30, 'Designer'),
    Employee('Charlie', 35, 'Manager'),
    Employee('Alice', 25, 'Developer'),
    Employee('Bob', 30, 'Designer'),
    Employee('Charlie', 35, 'Manager'),
  ]);

  SyncfusionDataGridExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Syncfusion DataGrid Example')),
      body: SfDataGrid(
        source: _employeeDataSource,
        navigationMode: GridNavigationMode.cell,
        selectionMode: SelectionMode.single,
        editingGestureType: EditingGestureType.tap,
        allowEditing: true,
        columns: <GridColumn>[
          GridColumn(
            columnName: 'Name',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Name'),
            ),
          ),
          GridColumn(
            columnName: 'Age',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Age'),
            ),
          ),
          GridColumn(
            columnName: 'Role',
            label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: const Text('Role'),
            ),
          ),
        ],
      ),
    );
  }
}
