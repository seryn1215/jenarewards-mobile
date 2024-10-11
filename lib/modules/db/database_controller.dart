import 'package:capusle_rewards/models/project.dart';
import 'package:capusle_rewards/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DatabaseController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Collection references
  // final CollectionReference<Project> projects =
  //     FirebaseFirestore.instance.collection('projects').withConverter<Project>(
  //           fromFirestore: (snapshot, _) => Project.fromFirestore(snapshot),
  //           toFirestore: (project, _) => project.toFirestore(),
  //         );

  // final CollectionReference<User> users =
  //     FirebaseFirestore.instance.collection('users').withConverter<User>(
  //           fromFirestore: (snapshot, _) => User.fromFirestore(snapshot),
  //           toFirestore: (user, _) => user.toFirestore(),
  //         );

  // Future<void> addUser(User user) async {
  //   try {
  //     await users.doc(user.id).set(user);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Future<void> addProject(Project project) async {
  //   try {
  //     await projects.doc(project.id).set(project);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Future<void> updateProject(Project project) async {
  //   try {
  //     await projects.doc(project.id).update(project.toFirestore());
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Future<void> deleteProject(Project project) async {
  //   try {
  //     await projects.doc(project.id).delete();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Stream<List<Project>> streamProjects() {
  //   return projects.orderBy('createdAt', descending: true).snapshots().map(
  //         (QuerySnapshot<Project> snapshot) =>
  //             snapshot.docs.map((doc) => doc.data()).toList(),
  //       );
  // }

  // Stream<User> streamUser(String userId) {
  //   return users.doc(userId).snapshots().map((DocumentSnapshot<User> snapshot) {
  //     if (snapshot.exists) {
  //       return snapshot.data()!;
  //     } else {
  //       return User(id: userId, name: '', email: '');
  //     }
  //   });
  // }

  // Future<User> getUser(String userId) {
  //   return users.doc(userId).get().then((DocumentSnapshot<User> snapshot) {
  //     if (snapshot.exists) {
  //       return snapshot.data()!;
  //     } else {
  //       return User(id: userId, name: '', email: '');
  //     }
  //   });
  // }

  // Future<List<Project>> getProjectsByUser(String userId) async {
  //   //all projects where owner or is a member
  //   List<Project> projects = [];
  //   try {
  //     QuerySnapshot<Project> querySnapshot =
  //         await this.projects.where('ownerId', isEqualTo: userId).get();
  //     querySnapshot.docs.forEach((doc) {
  //       projects.add(doc.data());
  //     });
  //     QuerySnapshot<Project> querySnapshot2 =
  //         await this.projects.where('memberIds', arrayContains: userId).get();
  //     querySnapshot2.docs.forEach((doc) {
  //       projects.add(doc.data());
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //   return projects;
  // }
}
