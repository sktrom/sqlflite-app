import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sqflite_app/app_router.dart';
import 'package:sqflite_app/servises/sql_helper_servises.dart';

class EditUserInfo extends StatefulWidget {
  final id;
  final title;
  final description;
  const EditUserInfo({super.key, this.id, this.title, this.description});

  @override
  State<EditUserInfo> createState() => _EditUserInfoState();
}

class _EditUserInfoState extends State<EditUserInfo> {
  SQLHelperService sqlHelperService = SQLHelperService();

  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    titleController.text = widget.title;
    descriptionController.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Notes'),
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
                        hintText: 'Edit Title',
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
                        hintText: 'Edit Description',
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
                int response = await sqlHelperService.updateData("""
                  UPDATE 'userinfo' SET title = '${titleController.text}' ,
                  description = '${descriptionController.text}'
                  WHERE id =${widget.id}
                  """);

                // => when i use the short function
                // int response = await sqlHelperService.update(
                //   'userinfo',
                //   {
                //     'title': titleController.text,
                //     'description': descriptionController.text,
                //   },
                //   'id = ${widget.id}',
                // );

                if (response > 0) {
                  GoRouter.of(context).pushReplacement(AppRouter.khomePage);
                }
                log(response.toString());
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
