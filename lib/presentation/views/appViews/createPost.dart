import 'package:amazon_sale_app/navigation/navigation_helper.dart';
import 'package:amazon_sale_app/navigation/route_constants.dart';
import 'package:amazon_sale_app/presentation/elements/appBar.dart';
import 'package:amazon_sale_app/presentation/elements/appDrawer.dart';
import 'package:amazon_sale_app/presentation/elements/app_button.dart';
import 'package:amazon_sale_app/presentation/elements/auth_text_field.dart';
import 'package:amazon_sale_app/presentation/elements/headerEarningRow.dart';
import 'package:amazon_sale_app/presentation/elements/heigh_sized_box.dart';
import 'package:amazon_sale_app/presentation/elements/textFieldLable.dart';
import 'package:flutter/material.dart';

List<TeacherModel> _list = [
  TeacherModel(uid: "1", name: "XYZ"),
  TeacherModel(uid: "2", name: "ASD"),
  TeacherModel(uid: "3", name: "DFG"),
];

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController _controller = TextEditingController();

  TeacherModel _selectedTeacher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "Home"),
      drawer: AppDrawer(),
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    return Column(
      children: [
        HeaderEarningRow(),
        VerticalSpace(10),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldLabel("Image", isRequireLessPadding: true),
                VerticalSpace(10),
                _getAttachmentContainer(context, label: "Upload Image"),
                VerticalSpace(10),
                TextFieldLabel("Keyword", isRequireLessPadding: true),
                VerticalSpace(10),
                AuthTextField(
                  label: "Muhammad Arif",
                  controller: _controller,
                  validator: (val) {},
                  isRequireLessPadding: true,
                ),
                VerticalSpace(10),
                TextFieldLabel("Category", isRequireLessPadding: true),
                VerticalSpace(10),
                _getSupervisorsDropwDown(hintText: "Category"),
                VerticalSpace(10),
                TextFieldLabel("Country", isRequireLessPadding: true),
                VerticalSpace(10),
                _getSupervisorsDropwDown(hintText: "Pakistan"),
                VerticalSpace(10),
                TextFieldLabel("Price", isRequireLessPadding: true),
                VerticalSpace(10),
                AuthTextField(
                  label: "\$20",
                  controller: _controller,
                  validator: (val) {},
                  isRequireLessPadding: true,
                ),
                VerticalSpace(10),
                TextFieldLabel("Store", isRequireLessPadding: true),
                VerticalSpace(10),
                AuthTextField(
                  label: "Alhamrah",
                  controller: _controller,
                  validator: (val) {},
                  isRequireLessPadding: true,
                ),
                VerticalSpace(10),
                TextFieldLabel("Link(optional)", isRequireLessPadding: true),
                VerticalSpace(10),
                AuthTextField(
                  label: "https://www.google.com",
                  controller: _controller,
                  validator: (val) {},
                  isRequireLessPadding: true,
                ),
                VerticalSpace(10),
                TextFieldLabel("Select Review Type",
                    isRequireLessPadding: true),
                VerticalSpace(10),
                _getSupervisorsDropwDown(hintText: "Feedback"),
                VerticalSpace(10),
                TextFieldLabel("Total Reviews", isRequireLessPadding: true),
                VerticalSpace(10),
                AuthTextField(
                  label: "12",
                  controller: _controller,
                  validator: (val) {},
                  isRequireLessPadding: true,
                ),
                VerticalSpace(10),
                TextFieldLabel("Review needed on day:",
                    isRequireLessPadding: true),
                VerticalSpace(10),
                AuthTextField(
                  label: "Monday, Tuesday",
                  controller: _controller,
                  validator: (val) {},
                  isRequireLessPadding: true,
                ),
                VerticalSpace(20),
                AppButton(
                    text: "Create Post",
                    onPressed: () {
                      NavigationHelper.pushReplacementName(
                          context, Routes.MY_PRODUCTS_ROUTE, "");
                    }),
                VerticalSpace(30),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _getAttachmentContainer(BuildContext context,
      {String label, VoidCallback onTap}) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
        child: Container(
          height: 57,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      label,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.upload_outlined,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {})
                  ]),
            ),
          ),
        ));
  }

  Widget _getSupervisorsDropwDown({String hintText}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: DropdownButton<TeacherModel>(
            value: _selectedTeacher,
            items: _list.map((value) {
              return DropdownMenuItem<TeacherModel>(
                child: Text(value.name),
                value: value,
              );
            }).toList(),
            onChanged: (item) {
              _selectedTeacher = item;
              setState(() {});
            },
            underline: SizedBox(),
            hint: Text(
              hintText,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            isExpanded: true,
          ),
        ),
      ),
    );
  }
}

class TeacherModel {
  final String uid;
  final String name;

  TeacherModel({this.uid, this.name});
}
