import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sekolahku/domain/student_domain.dart';
import 'package:sekolahku/domain/teacher_domain.dart';
import 'package:sekolahku/screens/detail_screen.dart';
import 'package:sekolahku/screens/form_screen.dart';
import 'package:sekolahku/service/app_service.dart';
import 'package:simple_speed_dial/simple_speed_dial.dart';

import 'detail_teacher_screen.dart';
import 'form_teacher_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  TabController _controllerTabBarHome;

  List<StudentDomain> _listStudent = <StudentDomain>[];
  List<TeacherDomain> _listTeacher = <TeacherDomain>[];
  String _valueKeyword = '';
  bool _isSearch = false;

  @override
  void initState() {
    _controllerTabBarHome = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: AppBar(
            title: _isSearch
                ? TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari...',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    autofocus: true,
                    onSubmitted: (value) {
                      setState(() {
                        _valueKeyword = value;
                      });
                    },
                  )
                : Text('Sekolahku'),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: _isSearch ? Icon(Icons.close) : Icon(Icons.search),
                  onPressed: () {
                    if (_isSearch) {
                      setState(() {
                        _valueKeyword = '';
                        _isSearch = false;
                      });
                    } else {
                      setState(() {
                        _valueKeyword = '';
                        _isSearch = true;
                      });
                    }
                  })
            ],
            flexibleSpace: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(width: 8),
                    Expanded(
                      child: DefaultTabController(
                        length: 2,
                        child: TabBar(
                          isScrollable: false,
                          controller: _controllerTabBarHome,
                          labelPadding: EdgeInsets.only(left: 14, right: 14),
                          labelColor: Color(0XFFFFFFFF),
                          labelStyle: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.75,
                            color: Color(0XFF000000),
                          ),
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                  width: 3.0, color: Color(0XFFFFFFFF)),
                              insets: EdgeInsets.symmetric(horizontal: 10.0)),
                          unselectedLabelStyle: TextStyle(
                            fontSize: 14,
                            letterSpacing: 0.75,
                            color: Color(0XFFFFFFFF),
                          ),
                          indicatorColor: Color(0XFFFFFFFF),
                          unselectedLabelColor: Color(0XFFFFFFFF),
                          tabs: [
                            Tab(child: Text('Student')),
                            Tab(child: Text('Teacher')),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  controller: _controllerTabBarHome,
                  children: [
                    FutureBuilder<List<StudentDomain>>(
                      initialData: _listStudent,
                      future: AppServices.getStudentService
                          .readStudents(_valueKeyword),
                      builder: (context, snapshot) {
                        if ((snapshot.connectionState == ConnectionState.none &&
                                snapshot.hasData == null) ||
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasData &&
                            snapshot.data.length > 0) {
                          _listStudent = snapshot.data;
                        } else if (snapshot.hasData &&
                            snapshot.data.length == 0) {
                          _listStudent = [];
                        }

                        return ListView.separated(
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      id: _listStudent[index].idStudent,
                                    ),
                                  ),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                              leading: Image.asset(
                                  _listStudent[index].gender == 'Pria'
                                      ? 'assets/images/pria.png'
                                      : 'assets/images/wanita.png'),
                              title: Text(_listStudent[index].fullName),
                              trailing: Column(
                                children: [
                                  Text(_listStudent[index].grade != null
                                      ? _listStudent[index].grade.toUpperCase()
                                      : "-"),
                                  Text(_listStudent[index].mobilePhone)
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: Colors.grey,
                            );
                          },
                          itemCount: _listStudent.length,
                        );
                      },
                    ),
                    FutureBuilder<List<TeacherDomain>>(
                      initialData: _listTeacher,
                      future: AppServices.getTeacherService
                          .readStudents(_valueKeyword),
                      builder: (context, snapshot) {
                        if ((snapshot.connectionState == ConnectionState.none &&
                                snapshot.hasData == null) ||
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasData &&
                            snapshot.data.length > 0) {
                          _listTeacher = snapshot.data;
                        } else if (snapshot.hasData &&
                            snapshot.data.length == 0) {
                          _listTeacher = [];
                        }

                        return ListView.separated(
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailTeacherScreen(
                                      id: _listTeacher[index].idStudent,
                                    ),
                                  ),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                              leading: Image.asset(
                                  _listTeacher[index].gender == 'Pria'
                                      ? 'assets/images/pria.png'
                                      : 'assets/images/wanita.png'),
                              title: Text(_listTeacher[index].fullName),
                              trailing: Column(
                                children: [
                                  Text(_listTeacher[index].grade != null
                                      ? _listTeacher[index].grade.toUpperCase()
                                      : '-'),
                                  Text(_listTeacher[index].mobilePhone)
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: Colors.grey,
                            );
                          },
                          itemCount: _listTeacher.length,
                        );
                      },
                    ),
                  ],
                ))),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(
              right: 0.0, left: 0.0, bottom: kFloatingActionButtonMargin + 48),
          child: SpeedDial(
            child: const Icon(Icons.add),
            speedDialChildren: <SpeedDialChild>[
              SpeedDialChild(
                child: const Icon(Icons.image),
                foregroundColor: Colors.white,
                backgroundColor: Color(0XFF203878),
                label: 'Add Student',
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormScreen(
                            title: 'Tambah Data Siswa', isEdit: false),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  });
                },
              ),
              SpeedDialChild(
                child: const Icon(Icons.videocam),
                foregroundColor: Colors.white,
                backgroundColor: Color(0XFF203878),
                label: 'Add Teacher',
                onPressed: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormTeacherScreen(
                            title: 'Tambah Data Guru', isEdit: false),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  });
                },
              ),
            ],
            closedForegroundColor: Colors.black,
            openForegroundColor: Colors.white,
            closedBackgroundColor: Colors.white,
            openBackgroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
