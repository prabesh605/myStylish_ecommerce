import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/stylish.png', height: 35),
        actions: [
          CircleAvatar(radius: 20, backgroundColor: Colors.blue),
          SizedBox(width: 10),
        ],
      ),

      drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                hint: Text("Search any Product"),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  "All Featured",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Spacer(),
                SortWidget(name: 'Sort', icon: Icon(Icons.unfold_more_sharp)),
                SizedBox(width: 10),
                SortWidget(
                  name: 'Filter',
                  icon: Icon(Icons.filter_alt_outlined),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SortWidget extends StatelessWidget {
  const SortWidget({super.key, required this.name, required this.icon});
  final String name;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // border: Border.all(width: 0),
      ),
      padding: EdgeInsets.all(4),
      child: Row(children: [Text(name), icon]),
    );
  }
}

// Icon(Icons.unfold_more_sharp)
