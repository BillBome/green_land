import 'package:flutter/material.dart';
import 'package:green_land/firebase/display_item.dart';
import 'package:green_land/firebase/user_collection.dart';
import 'package:green_land/models/item_model.dart';
import 'package:green_land/models/display_item_details.dart';
import 'package:green_land/models/add_new_item.dart';
import 'package:green_land/models/display_profile_details.dart';
import 'package:green_land/models/user_model.dart';

class HomePage extends StatefulWidget {
  final UserModel user;

  HomePage({required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var height, width;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              width: width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.green, Colors.blueAccent],
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: height * 0.2,
                    width: width,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 50,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: AssetImage("assets/logo.png"),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'GREEN LAND',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  UserModel? userProfile = await EmailFetcher()
                                      .getUser(widget.user.email);
                                  print(widget.user.email);

                                  if (userProfile != null) {
                                    ProfileDetailsModal()
                                        .show(context, userProfile);
                                  } else {
                                    print('User profile not found');
                                  }
                                  ;
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: AssetImage("assets/pfp.jpg"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 3,
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      width: width,
                      constraints: BoxConstraints(
                        minHeight: height * 0.8,
                      ),
                      padding: EdgeInsets.only(
                        top: 20,
                        bottom: 45,
                        left: 15,
                        right: 15,
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  StreamBuilder<List<Item>>(
                                    stream: AllItemsStream().itemStream(''),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Text(
                                          'Inventory: Loading...',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text(
                                          'Inventory: Error loading items',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      } else {
                                        List<Item> items = snapshot.data ?? [];
                                        return Text(
                                          'Inventory: ${items.length}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                      maxWidth: width * 0.3,
                                      maxHeight: 20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: searchController,
                                            onChanged: (text) {
                                              setState(() {});
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'Search...',
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        searchController.text.isNotEmpty
                                            ? InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    searchController.clear();
                                                  });
                                                },
                                                child: Icon(Icons.clear),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          StreamBuilder<List<Item>>(
                            stream: searchController.text.isEmpty
                                ? AllItemsStream().itemStream('')
                                : FilteredItemStream()
                                    .itemStream(searchController.text),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else {
                                List<Item> items = snapshot.data ?? [];
                                return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1.1,
                                    mainAxisSpacing: 4,
                                  ),
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: items.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        DisplayItemDetails.show(
                                            context, items[index].id);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 2,
                                                    blurRadius: 5,
                                                  ),
                                                ],
                                              ),
                                              child: Image.network(
                                                items[index].image,
                                                width: 140,
                                                height: 90,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                              items[index].name,
                                              style: TextStyle(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: width / 2 - 32,
            child: Container(
              width: 65,
              height: 65,
              child: FloatingActionButton(
                onPressed: () {
                  AddNewItemModal.show(context);
                },
                child: Icon(
                  Icons.add,
                  size: 35,
                ),
                backgroundColor: Colors.yellow,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
