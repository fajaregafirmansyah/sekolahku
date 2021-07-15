import 'package:flutter/material.dart';
import 'package:sekolahku/domain/teacher_domain.dart';
import 'package:sekolahku/screens/form_screen.dart';
import 'package:sekolahku/service/app_service.dart';

import 'form_teacher_screen.dart';

class DetailTeacherScreen extends StatefulWidget {
  final int id;

  const DetailTeacherScreen({Key key, this.id}) : super(key: key);

  @override
  _DetailTeacherScreenState createState() => _DetailTeacherScreenState();
}

class _DetailTeacherScreenState extends State<DetailTeacherScreen> {
  TeacherDomain _studentDomain;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Teacher'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FormTeacherScreen(
                    title: 'Edit Data',
                    isEdit: true,
                    studentDomain: _studentDomain,
                  ),
                ),
              ).then((value) {
                setState(() {});
              });
            },
            icon: Icon(Icons.create),
          ),
          IconButton(
            onPressed: () {
              AppServices.getTeacherService
                  .deleteStudent(widget.id)
                  .then((value) {
                Navigator.pop(context);
              });
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: FutureBuilder(
        future: AppServices.getTeacherService.studentById(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.hasData == null) {
            return CircularProgressIndicator();
          }

          _studentDomain = snapshot.data;

          return ListView(
            children: [
              SizedBox(height: 20),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                      _studentDomain.gender == 'Pria'
                          ? "assets/images/pria.png"
                          : "assets/images/wanita.png",
                      height: 100,
                      width: 100),
                ],
              ),
              ListTile(
                leading: Icon(Icons.perm_contact_cal),
                title: Text(_studentDomain.fullName),
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text(_studentDomain.mobilePhone),
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.label),
                title: Text(_studentDomain.gender != null ? _studentDomain.gender : '-'),
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.stairs_outlined),
                title: Text(_studentDomain.grade != null ? _studentDomain.grade : '-'),
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text(_studentDomain.hobbies.toString()),
              )
            ],
          );
        },
      ),
    );
  }
}
