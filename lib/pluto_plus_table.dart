import 'package:flutter/material.dart';
import 'package:flutter_objectbox/auto_complete.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:pluto_grid_plus/pluto_grid_plus.dart';
import 'package:searchfield/searchfield.dart';
import 'package:pluto_grid/src/helper/platform_helper.dart';

class PlutoGridPlusPage extends StatefulWidget {
  const PlutoGridPlusPage({super.key});

  @override
  State<PlutoGridPlusPage> createState() => _PlutoGridPlusPageState();
}

class _PlutoGridPlusPageState extends State<PlutoGridPlusPage> {
  final List<PlutoColumn> columns = <PlutoColumn>[
    PlutoColumn(
      title: 'Id',
      field: 'id',
      type: PlutoColumnType.text(),
    ),
    // PlutoColumn(
    //     title: 'Name',
    //     field: 'name',
    //     type: PlutoColumnType.text(),
    //     renderer: (rendererContext) {
    //       return CustomAutocomplete<String>(
    //         options: const [
    //           'Apple',
    //           'Banana',
    //           'Cherry',
    //           'Date',
    //           'Elderberry',
    //           'Fig',
    //           'Grape',
    //         ],
    //         displayStringForOption: (String option) => option,
    //         decoration: const InputDecoration(
    //           labelText: 'Search for a fruit',
    //           border: OutlineInputBorder(),
    //         ),
    //         onSelected: (String selection) {
    //           rendererContext.stateManager.changeCellValue(
    //             rendererContext.cell,
    //             selection,
    //           );
    //         },
    //       );
    //     }),
    PlutoColumn(
        title: 'NIN',
        field: 'nin',
        type: PlutoColumnType.text(),
        renderer: (rendererContext) {
          return TypeAheadField<String>(
            suggestionsCallback: (pattern) => [
              'Apple',
              'Banana',
              'Cherry',
              'Date',
              'Elderberry',
              'Fig',
              'Grape',
            ]
                .where((item) =>
                    item.toLowerCase().contains(pattern.toLowerCase()))
                .toList(),
            builder: (context, controller, focusNode) {
              return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Search',
                  ));
            },
            itemBuilder: (context, item) {
              return ListTile(
                title: Text(item),
              );
            },
            onSelected: (selection) {
              rendererContext.stateManager.changeCellValue(
                rendererContext.cell,
                selection,
              );
            },
          );
          return CustomAutocomplete<String>(
            options: const [
              'Apple',
              'Banana',
              'Cherry',
              'Date',
              'Elderberry',
              'Fig',
              'Grape',
            ],
            displayStringForOption: (String option) => option,
            decoration: const InputDecoration(
              labelText: 'Search for a fruit',
              border: OutlineInputBorder(),
            ),
            onSelected: (String selection) {
              rendererContext.stateManager.changeCellValue(
                rendererContext.cell,
                selection,
              );
            },
          );
        }),
    // PlutoColumn(
    //     title: 'Name',
    //     field: 'name',
    //     enableEditingMode: true,
    //     type: PlutoColumnType.text(),
    //     renderer: (rendererContext) {
    //       return SearchField<String>(
    //         maxSuggestionsInViewPort: 10,
    //         onSuggestionTap: (content) {
    //           rendererContext.stateManager.changeCellValue(
    //             rendererContext.cell,
    //             content.item,
    //           );
    //         },
    //         suggestions: [
    //           'Apple',
    //           'Banana',
    //           'Cherry',
    //           'Date',
    //           'Elderberry',
    //           'Fig',
    //           'Grape',
    //         ]
    //             .map(
    //               (e) => SearchFieldListItem<String>(
    //                 e,
    //                 item: e,
    //                 child: Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Text(e),
    //                 ),
    //               ),
    //             )
    //             .toList(),
    //       );
    //     }),
    PlutoColumn(
        title: 'Name',
        field: 'name',
        type: PlutoColumnType.text(),
        filterWidget: CustomAutocomplete<String>(
          options: const [
            'Apple',
            'Banana',
            'Cherry',
            'Date',
            'Elderberry',
            'Fig',
            'Grape',
          ],
          displayStringForOption: (String option) => option,
          decoration: const InputDecoration(
            labelText: 'Search for a fruit',
            border: OutlineInputBorder(),
          ),
          onSelected: (String selection) {},
        )),
    PlutoColumn(
      title: 'Age',
      field: 'age',
      type: PlutoColumnType.number(defaultValue: null),
      renderer: (rendererContext) {
        final value = rendererContext.cell.value;
        return Text(value == null || value == 0 ? '' : value.toString());
      },
      applyFormatterInEditing: true,
    ),
    PlutoColumn(
      title: 'Role',
      field: 'role',
      type: PlutoColumnType.select(<String>[
        'Programmer',
        'Designer',
        'Owner',
      ]),
    ),
    PlutoColumn(
      title: 'Role 2',
      field: 'role2',
      type: PlutoColumnType.select(
        <String>[
          'Programmer',
          'Designer',
          'Owner',
        ],
        builder: (item) {
          return Row(children: [
            Icon(item == 'Programmer' ? Icons.code : Icons.design_services),
            const SizedBox(width: 8),
            Text(item),
          ]);
        },
      ),
    ),
    PlutoColumn(
      title: 'Joined',
      field: 'joined',
      type: PlutoColumnType.date(),
    ),
    PlutoColumn(
      title: 'Working time',
      field: 'working_time',
      type: PlutoColumnType.time(),
    ),
    PlutoColumn(
      title: 'salary',
      field: 'salary',
      type: PlutoColumnType.currency(),
      footerRenderer: (rendererContext) {
        return PlutoAggregateColumnFooter(
          rendererContext: rendererContext,
          formatAsCurrency: true,
          type: PlutoAggregateColumnType.sum,
          format: '#,###',
          alignment: Alignment.center,
          titleSpanBuilder: (text) {
            return [
              const TextSpan(
                text: 'Sum',
                style: TextStyle(color: Colors.red),
              ),
              const TextSpan(text: ' : '),
              TextSpan(text: text),
            ];
          },
        );
      },
    ),
  ];

  final List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 'user1'),
        'nin': PlutoCell(value: null),
        'name': PlutoCell(value: 'Mike'),
        'age': PlutoCell(value: null),
        'role': PlutoCell(value: 'Programmer'),
        'role2': PlutoCell(value: 'Programmer'),
        'joined': PlutoCell(value: '2021-01-01'),
        'working_time': PlutoCell(value: '09:00'),
        'salary': PlutoCell(value: 300),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 'user2'),
        'nin': PlutoCell(value: null),
        'name': PlutoCell(value: 'Jack'),
        'age': PlutoCell(value: 25),
        'role': PlutoCell(value: 'Designer'),
        'role2': PlutoCell(value: 'Designer'),
        'joined': PlutoCell(value: '2021-02-01'),
        'working_time': PlutoCell(value: '10:00'),
        'salary': PlutoCell(value: 400),
      },
    ),
    PlutoRow(
      cells: {
        'id': PlutoCell(value: 'user3'),
        'nin': PlutoCell(value: null),
        'name': PlutoCell(value: 'Suzi'),
        'age': PlutoCell(value: 40),
        'role': PlutoCell(value: 'Owner'),
        'role2': PlutoCell(value: 'Owner'),
        'joined': PlutoCell(value: '2021-03-01'),
        'working_time': PlutoCell(value: '11:00'),
        'salary': PlutoCell(value: 700),
      },
    ),
  ];

  /// columnGroups that can group columns can be omitted.
  final List<PlutoColumnGroup> columnGroups = [
    PlutoColumnGroup(title: 'Id', fields: ['id'], expandedColumn: true),
    PlutoColumnGroup(title: 'User information', fields: ['name', 'age']),
    PlutoColumnGroup(title: 'Status', children: [
      PlutoColumnGroup(title: 'A', fields: ['role'], expandedColumn: true),
      PlutoColumnGroup(
          title: 'Etc.', fields: ['joined', 'working_time', 'role2']),
    ]),
  ];

  /// [PlutoGridStateManager] has many methods and properties to dynamically manipulate the grid.
  /// You can manipulate the grid dynamically at runtime by passing this through the [onLoaded] callback.
  late final PlutoGridStateManager stateManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlutoGrid(
        columns: columns,
        rows: rows,
        columnGroups: columnGroups,
        onLoaded: (PlutoGridOnLoadedEvent event) {
          stateManager = event.stateManager;
          stateManager.setShowColumnFilter(true);
        },
        onChanged: (PlutoGridOnChangedEvent event) {
          print(event);
        },
        configuration: const PlutoGridConfiguration(),
        // selectDateCallback: (PlutoCell cell, PlutoColumn column) async {
        //   return showDatePicker(
        //       context: context,
        //       initialDate: PlutoDateTimeHelper.parseOrNullWithFormat(
        //         cell.value,
        //         column.type.date.format,
        //       ) ?? DateTime.now(),
        //       firstDate: column.type.date.startDate ?? DateTime(0),
        //       lastDate: column.type.date.endDate ?? DateTime(9999)
        //   );
        // }
      ),
    );
  }
}
