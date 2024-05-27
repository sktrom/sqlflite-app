import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite_app/app_router.dart';
import 'package:sqflite_app/edit_user_info.dart';
import 'package:sqflite_app/servises/sql_helper_servises.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SQLHelperService sqlHelperService = SQLHelperService();
  bool isLoading = true;

  List userInfo = [];
  Future readData() async {
    // => when i use short function
    //  List<Map> response =
    //         await sqlHelperService.read( 'userinfo');

    List<Map> response =
        await sqlHelperService.readOrGetData("SELECT * FROM 'userinfo'");
    userInfo.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future deletAllDataBase() async {
    var response = await sqlHelperService.deleteAllDatabase();
    userInfo.clear();
    setState(() {});
  }

  EditUserInfo editUserInfo = const EditUserInfo();

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SQL',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              // await deletAllDataBase();
            },
            child: const Text('Delete all database(Restart).'),
          ),
        ],
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: ListView(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: userInfo.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            'Title : ${userInfo[index]['title']}',
                          ),
                          subtitle: Text(
                            'Description : ${userInfo[index]['description']}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  GoRouter.of(context).push(
                                    AppRouter.keditUserInfoNotes,
                                    extra: {
                                      editUserInfo.id: userInfo[index]['id'],
                                      editUserInfo.title: userInfo[index]
                                          ['title'],
                                      editUserInfo.description: userInfo[index]
                                          ['description'],
                                    },
                                  );

                                  //  Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //     builder: (context) => EditUserInfo(
                                  //       id: userInfo[index]['id'],
                                  //       title: userInfo[index]['title'],
                                  //       description: userInfo[index]
                                  //           ['description'],
                                  //     ),
                                  //   ),
                                  // );
                                },
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () async {
                                  int response = await sqlHelperService.deletData(
                                      "DELETE FROM 'userinfo' WHERE id = ${userInfo[index]['id']}");

                                  // // when i use  a short function
                                  // int response = await sqlHelperService.delet(
                                  //   'userinfo',
                                  //   'id = ${userInfo[index]['id']}',
                                  // );

                                  if (response > 0) {
                                    userInfo.removeWhere((element) =>
                                        element['id'] == userInfo[index]['id']);
                                    setState(() {});
                                  }
                                  log(response.toString());
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).pushReplacement(AppRouter.kaddUserInfoNotes);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
