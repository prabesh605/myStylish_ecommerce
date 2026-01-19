import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String image;
  CategoryModel(this.image, this.name);
}

class ProductModel {
  final String imageUrl;
  final String name;
  final String description;
  final double price;
  final double initialPrice;
  final double rating;

  ProductModel(
    this.imageUrl,
    this.name,
    this.description,
    this.price,
    this.initialPrice,
    this.rating,
  );
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
  List<ProductModel> products = [
    ProductModel(
      'https://plus.unsplash.com/premium_photo-1668319915433-7a35eefa1fad?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      "Women Printed Kurt",

      "Women Printed Kurt Women Printed  Printed KurtWomen Printed Kurt Women Printed Kurt",
      1500,
      2499,
      4,
    ),
    ProductModel(
      'https://images.unsplash.com/photo-1619208382871-96f4d45bc840?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      "Men clothes",

      "Men clothesMen clothesMen clothesMen clothesMen clothesMen clothesMen clothesMen clothes",
      1600,
      4099,
      4.5,
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              DealWidget(
                name: 'Deal of the Day',
                dateOrTime: '22h 55m 20s remaining',
                icon: Icons.alarm,
                color: Colors.blue,
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 600,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ItemContainerWidget(
                      visibleDescription: true,
                      imageUrl: product.imageUrl,
                      name: product.name,
                      description: product.description,
                      price: product.price,
                      initialPrice: product.initialPrice,
                      rating: product.rating,
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              DealWidget(
                name: 'Trending Products',
                dateOrTime: 'Last Date 29/02/22',
                icon: Icons.alarm,
                color: Color(0xffFD6E87),
              ),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return ItemContainerWidget(
                      visibleDescription: false,
                      imageUrl: product.imageUrl,
                      name: product.name,
                      description: product.description,
                      price: product.price,
                      initialPrice: product.initialPrice,
                      rating: product.rating,
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(12),
                    child: Image.asset(
                      'assets/images/newImage.png',
                      height: 100,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text('New Arrivals'),
                          Text("Summer'25 COllections"),
                        ],
                      ),
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          backgroundColor: Color(0xffF83758),
                          side: BorderSide(
                            width: 2.0,
                            color: Color(0xffF83758),
                          ),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DealWidget extends StatelessWidget {
  const DealWidget({
    super.key,
    required this.name,
    required this.dateOrTime,
    required this.icon,
    required this.color,
  });
  final String name;
  final String dateOrTime;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(color: Colors.white)),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(icon, color: Colors.white),
                  SizedBox(width: 4),
                  Text(dateOrTime, style: TextStyle(color: Colors.white)),
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
            label: Text("View all", style: TextStyle(color: Colors.white)),
            icon: Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class ItemContainerWidget extends StatelessWidget {
  const ItemContainerWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.price,
    required this.initialPrice,
    required this.rating,
    required this.visibleDescription,
  });
  final String imageUrl;
  final String name;
  final String description;
  final double price;
  final double initialPrice;
  final double rating;
  final bool visibleDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      // padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12),
            child: Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Visibility(
                  visible: visibleDescription,
                  child: Text(
                    description,
                    maxLines: 4,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                SizedBox(height: 10),
                Text("Rs. $price"),
                SizedBox(height: 10),
                RichText(
                  selectionColor: Colors.black,

                  text: TextSpan(
                    text: "Rs. $initialPrice",
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: " 40% Off",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                RatingBar.builder(
                  itemSize: 20,
                  initialRating: rating,

                  itemBuilder: (context, _) =>
                      Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
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
