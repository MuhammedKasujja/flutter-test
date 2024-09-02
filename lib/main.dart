import 'package:flutter/material.dart';
import 'package:flutter_objectbox/auto_screen.dart';
import 'package:flutter_objectbox/db/utils.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';

import 'auto_complete.dart';
import 'data_grid.dart';
import 'db/objectbox.dart';
import 'invoice.dart';
import 'models/customer.dart';
import 'package:cron/cron.dart';

import 'models/person_employee.dart';
import 'pluto_grid_table.dart';
import 'pluto_plus_table.dart';
import 'syncfusion_grid.dart';
import 'text_context_menu.dart';
import 'text_focus_field.dart';
import 'text_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await ObjectBox.create();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Objectbox',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: PlutoGridExample(),
      // home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final box = ObjectBox.instance.store.box<Manager>();

  void runCron() {
    final cron = Cron();

    // Schedule a task to run after 30 seconds
    cron.schedule(Schedule.parse('*/1 * * * *'), () async {
      print('Task executed after 30 seconds');
      // Place your task code here

      // Cancel the cron job after the task has been executed
      // cron.close();
    });
  }

  DateTime? currentDate;

  getTime() async {
    try {
      DateTime startDate = await NTP.now();
      print('NTP DateTime: ${startDate}');
      setState(() {
        currentDate = startDate;
      });
    } catch (e) {
      print("Date error ${e.toString()}");
    }
  }

  @override
  void initState() {
    // runCron();
    getTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ObjectBox Example'),
      ),
      body: FutureBuilder(
        future: box.getAllAsync(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final manager = snapshot.data?.elementAt(index);
                return Column(
                  children: [
                    ListTile(
                      title: Text(manager?.name ?? 'No name'),
                      subtitle: Text(convertTimestampToDateString(
                          manager?.createdAt?.millisecondsSinceEpoch)),
                      trailing: Text(manager?.updatedAt?.millisecondsSinceEpoch
                              .toString() ??
                          'Updated at'),
                    ),
                    Text("${manager?.isDeleted}")
                  ],
                );
              },
            );
          }
          return const Text('No data found');
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.amber[200],
        width: double.infinity,
        height: kTextTabBarHeight,
        child: Text("${currentDate?.toLocal()}"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addPerson,
        child: const Icon(Icons.add),
      ),
    );
  }

  void addPerson() async {
    final manager = Manager(name: "Kato kimera");
    manager.createdAt = DateTime.now();

    var deletedModel = manager.save();
    print("deletedModel == ${deletedModel.isDeleted}");
    deletedModel = manager.delete();
    print("deletedModel == ${deletedModel.isDeleted} [[]]");
    setState(() {});
    // var order = ShopOrder(
    //   price: 89000,
    //   createdAt: DateTime.now(),
    //   amount: 1000,
    //   details: "This is not working",
    // );
    // order = saveEntity(order);
    // print({"order data": order.id});
    // setState(() {});
    // runCron();
    getTime();
  }
}

DateTime convertTimestampToDate(int? timestamp) =>
    DateTime.fromMillisecondsSinceEpoch((timestamp ?? 0), isUtc: false);

String convertTimestampToDateString(int? timestamp) => (timestamp ?? 0) == 0
    ? ''
    : convertTimestampToDate(timestamp).toIso8601String();

String dateStr(int timestamp) {
  return DateFormat('dd/MM/yyyy h:mm a')
      .format(convertTimestampToDate(timestamp));
}
