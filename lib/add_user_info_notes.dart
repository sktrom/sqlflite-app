import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite_app/app_router.dart';
import 'package:sqflite_app/servises/sql_helper_servises.dart';

class AddUserInfoNotes extends StatefulWidget {
  const AddUserInfoNotes({super.key});

  @override
  State<AddUserInfoNotes> createState() => _AddUserInfoNotesState();
}

class _AddUserInfoNotesState extends State<AddUserInfoNotes> {
  SQLHelperService sqlHelperService = SQLHelperService();

  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notes'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () async {
                int response = await sqlHelperService.insertOrAddData(
                    "INSERT INTO 'userinfo' ('title', 'description') VALUES ('${titleController.text}', '${descriptionController.text}')");

                // => when i use a short function
                // int response = await sqlHelperService.insert('userinfo', {
                //   'title': titleController.text,
                //   'description': descriptionController.text,
                // });

                if (response > 0) {
                  // Fluttertoast.showToast(
                  //         msg: "Your notes has been uploade successfully",
                  //         toastLength: Toast.LENGTH_SHORT,
                  //         gravity: ToastGravity.CENTER,
                  //         timeInSecForIosWeb: 1,
                  //         backgroundColor: Colors.red,
                  //         textColor: Colors.white,
                  //         fontSize: 16.0)
                  //     .then((value) {
                  //   GoRouter.of(context).pushReplacement(AppRouter.khomePage);
                  // });

                  GoRouter.of(context).pushReplacement(AppRouter.khomePage);
                }

                log(response.toString());
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
