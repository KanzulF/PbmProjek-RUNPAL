import 'package:firstpro/widgets/kotak2.dart';
import 'package:flutter/material.dart';
import 'package:firstpro/widgets/menu.dart';
import 'package:firstpro/controllers/activity.dart';
import 'package:firstpro/models/activity.dart';

class ActivityHistoryPage extends StatefulWidget {
  @override
  _ActivityHistoryPageState createState() => _ActivityHistoryPageState();
}

class _ActivityHistoryPageState extends State<ActivityHistoryPage> {
  List<Activity> activities = [];
  ActivityRepository repository = ActivityRepository();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    try {
      List<Activity> fetchedActivities = await repository.getUserActivities();
      setState(() {
        activities = fetchedActivities;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Image.asset('assets/icons/runpal.png', height: 50),
      ),
      body: activities.isNotEmpty
          ? ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(activities[index].name),
                  subtitle: Text(activities[index].description),
                  trailing: Text(activities[index].date.toString()),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
