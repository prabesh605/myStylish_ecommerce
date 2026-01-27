import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_ecommerce/bloc/category/category_bloc.dart';
import 'package:stylish_ecommerce/bloc/category/category_event.dart';
import 'package:stylish_ecommerce/bloc/category/category_state.dart';
import 'package:stylish_ecommerce/bloc/product/product_bloc.dart';
import 'package:stylish_ecommerce/bloc/product/product_event.dart';
import 'package:stylish_ecommerce/bloc/product/product_state.dart';
import 'package:stylish_ecommerce/constant/Strings.dart';
import 'package:stylish_ecommerce/models/category_model.dart';
import 'package:stylish_ecommerce/screens/login_screen.dart';
import 'package:stylish_ecommerce/screens/user_module/product_list_screen.dart';
import 'package:stylish_ecommerce/screens/user_module/profile_screen.dart';
import 'package:stylish_ecommerce/screens/user_module/product_detail.dart';
import 'package:stylish_ecommerce/widgets/item_container_widget.dart';
import 'package:stylish_ecommerce/widgets/sort_widget.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetCategories());
    context.read<ProductBloc>().add(GetProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/stylish.png', height: 35),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),

      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(child: Container()),
            ListTile(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              leading: Icon(Icons.logout),
              title: Text("Logout"),
            ),
          ],
        ),
      ),
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
                height: MediaQuery.of(context).size.height * 0.14,
                // height: 120,
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    if (state is CategoryLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is CategoryError) {
                      return Center(child: Text(state.error));
                    } else if (state is CategoryLoaded) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          final CategoryModel category =
                              state.categories[index];
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
                      );
                    }
                    return SizedBox.shrink();
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

                  viewportFraction: 1,
                  enlargeCenterPage: false,
                ),
              ),
              SizedBox(height: 20),
              DealWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListScreen(),
                    ),
                  );
                },
                name: 'Deal of the Day',
                dateOrTime: '22h 55m 20s remaining',
                icon: Icons.alarm,
                color: Colors.blue,
              ),
              SizedBox(height: 20),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ProductError) {
                    return Center(child: Text("Error"));
                  } else if (state is ProductLoaded) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ItemContainerWidget(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetail(product: product),
                                ),
                              );
                            },
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
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(height: 20),
              DealWidget(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListScreen(),
                    ),
                  );
                },
                name: 'Trending Products',
                dateOrTime: 'Last Date 29/02/22',
                icon: Icons.alarm,
                color: Color(0xffFD6E87),
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ProductError) {
                    return Center(child: Text("Error"));
                  } else if (state is ProductLoaded) {
                    return SizedBox(
                      height: 400,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ItemContainerWidget(
                            visibleDescription: false,
                            imageUrl: product.imageUrl,
                            name: product.name,
                            description: product.description,
                            price: product.price,
                            initialPrice: product.initialPrice,
                            rating: product.rating,
                            onTap: () {},
                          );
                        },
                      ),
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12),
                      child: Image.asset(
                        'assets/images/newImage.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductListScreen(),
                            ),
                          );
                        },
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
    required this.onTap,
  });
  final String name;
  final String dateOrTime;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

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
            onPressed: onTap,
            label: Text("View all", style: TextStyle(color: Colors.white)),
            icon: Icon(Icons.arrow_forward, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

// Icon(Icons.unfold_more_sharp)
