import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String image;
  CategoryModel(this.image, this.name);
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<String> images = [
    'https://images.unsplash.com/photo-1586882829491-b81178aa622e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586871608370-4adee64d1794?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2862&q=80',
    'https://images.unsplash.com/photo-1586901533048-0e856dff2c0d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586902279476-3244d8d18285?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2850&q=80',
    'https://images.unsplash.com/photo-1586943101559-4cdcf86a6f87?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1556&q=80',
    'https://images.unsplash.com/photo-1586951144438-26d4e072b891?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
    'https://images.unsplash.com/photo-1586953983027-d7508a64f4bb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80',
  ];
  List<CategoryModel> categories = [
    CategoryModel(
      'https://img.freepik.com/free-photo/collage-portrait-with-natural-elements_23-2151907629.jpg?semt=ais_hybrid&w=740&q=80',
      'Beauty',
    ),
    CategoryModel(
      'https://img.freepik.com/free-photo/collage-portrait-with-natural-elements_23-2151907629.jpg?semt=ais_hybrid&w=740&q=80',
      'Fasion',
    ),
    CategoryModel(
      'https://img.freepik.com/free-photo/collage-portrait-with-natural-elements_23-2151907629.jpg?semt=ais_hybrid&w=740&q=80',
      'Kids',
    ),
    CategoryModel(
      'https://img.freepik.com/free-photo/collage-portrait-with-natural-elements_23-2151907629.jpg?semt=ais_hybrid&w=740&q=80',
      'Men',
    ),
    CategoryModel(
      'https://img.freepik.com/free-photo/collage-portrait-with-natural-elements_23-2151907629.jpg?semt=ais_hybrid&w=740&q=80',
      'Women',
    ),
    CategoryModel(
      'https://img.freepik.com/free-photo/collage-portrait-with-natural-elements_23-2151907629.jpg?semt=ais_hybrid&w=740&q=80',
      'Animal',
    ),
  ];
  // List categories = ['Beauty', 'Fasion', 'Kids', 'Men', 'Women', 'Animals'];
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
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final CategoryModel category = categories[index];
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(category.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // CircleAvatar(radius: 25, backgroundColor: Colors.black),
                        SizedBox(height: 10),
                        Text(category.name),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (context, index, readIdx) {
                return Container(
                  child: Center(
                    child: Image.network(images[index], fit: BoxFit.cover),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,

                aspectRatio: 2.0,
                enlargeCenterPage: false,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Deal of the Day",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.alarm, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            "22h 55m 20s remaining",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      side: BorderSide(width: 2.0, color: Colors.white),
                    ),
                    onPressed: () {},
                    label: Text(
                      "View all",
                      style: TextStyle(color: Colors.white),
                    ),
                    icon: Icon(Icons.arrow_forward, color: Colors.white),
                  ),
                ],
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
