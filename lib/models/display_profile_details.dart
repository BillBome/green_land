import 'package:flutter/material.dart';
import 'package:green_land/firebase/authentication.dart';
import 'package:green_land/models/user_model.dart';
import 'package:green_land/pages/landing.dart';
import 'package:green_land/widgets/build-table-rows.dart';

class ProfileDetailsModal {
  void show(BuildContext context, UserModel user) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _buildProfileDetailsModal(context, user);
      },
    );
  }

  Widget _buildProfileDetailsModal(BuildContext context, UserModel user) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage("assets/pfp.jpg"),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            child: Table(
              columnWidths: {
                0: FixedColumnWidth(150),
                1: FlexColumnWidth(2),
              },
              children: [
                UserTableRowBuilder()
                    .buildTableRow('Username:', '${user.name}'),
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        height: 10,
                      ),
                    ),
                    TableCell(
                      child: Container(),
                    ),
                  ],
                ),
                UserTableRowBuilder().buildTableRow('Email:', '${user.email}'),
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        height: 10,
                      ),
                    ),
                    TableCell(
                      child: Container(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  SignOutService();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LandingPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 244, 235, 54),
                ),
                child: Text(
                  'Sign Out',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              // SizedBox(width: 16),
              // ElevatedButton(
              //   onPressed: () {},
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.red,
              //   ),
              //   child: Text(
              //     'Delete',
              //     style: TextStyle(
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
