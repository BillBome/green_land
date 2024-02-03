import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:green_land/models/user_model.dart';

class UserAdder {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<void> addUser(UserModel user) async {
    try {
      await usersCollection.doc(user.email).set(user.toJson());
      print("User added successfully.");
    } catch (error) {
      print('Failed to add user: $error');
      throw Exception('Failed to add user: $error');
    }
  }
}

abstract class UserFetcher {
  Future<UserModel?> getUser(String user);
}

class UserNameFetcher implements UserFetcher {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  @override
  Future<UserModel?> getUser(String name) async {
    try {
      QuerySnapshot querySnapshot =
          await usersCollection.where('Name', isEqualTo: name).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> data =
            querySnapshot.docs.first.data() as Map<String, dynamic>;

        UserModel user = UserModel(
          email: data['Email'],
          name: data['Name'],
          password: data['Password'],
        );

        return user;
      } else {
        return null; // User not found
      }
    } catch (error) {
      print('Error fetching user by name: $error');
      throw Exception('Error fetching user by name: $error');
    }
  }
}

class EmailFetcher implements UserFetcher {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  @override
  Future<UserModel?> getUser(String email) async {
    try {
      QuerySnapshot querySnapshot =
          await usersCollection.where('Email', isEqualTo: email).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> data =
            querySnapshot.docs.first.data() as Map<String, dynamic>;

        UserModel user = UserModel(
          email: data['Email'],
          name: data['Name'],
          password: data['Password'],
        );

        return user;
      } else {
        return null; // User not found
      }
    } catch (error) {
      print('Error fetching user by email: $error');
      throw Exception('Error fetching user by email: $error');
    }
  }
}
