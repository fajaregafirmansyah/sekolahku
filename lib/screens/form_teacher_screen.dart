import 'package:flutter/material.dart';
import 'package:sekolahku/domain/teacher_domain.dart';
import 'package:sekolahku/service/app_service.dart';
import 'package:sekolahku/utils/capitalize.dart';
import 'package:sekolahku/widgets/custom_checkbox.dart';
import 'package:sekolahku/widgets/custom_radio.dart';

class FormTeacherScreen extends StatefulWidget {
  final String title;
  final bool isEdit;
  final TeacherDomain studentDomain;

  const FormTeacherScreen({Key key, @required this.title, this.isEdit, this.studentDomain}) : super(key: key);

  @override
  _FormTeacherScreenState createState() => _FormTeacherScreenState();
}

class _FormTeacherScreenState extends State<FormTeacherScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController firtNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobilePhoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String gender;
  String grade;
  List<String> valueHobbies = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.isEdit){
      firtNameController.text = widget.studentDomain.firstName;
      lastNameController.text = widget.studentDomain.lastName;
      mobilePhoneController.text = widget.studentDomain.mobilePhone;
      addressController.text = widget.studentDomain.address;
      gender = widget.studentDomain.gender;
      grade = widget.studentDomain.grade;
      valueHobbies = widget.studentDomain.hobbies;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah data'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                        controller: firtNameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Nama Depan',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))))),
                SizedBox(width: 8),
                Expanded(
                    child: TextFormField(
                        controller: lastNameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Tidak boleh kosong";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Nama Belakang',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))))),
              ],
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: mobilePhoneController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Tidak boleh kosong";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  hintText: 'No Hp',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5))),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 10),
            Text(
              'Jenis Kelamin',
              style: TextStyle(color: Colors.blue),
            ),
            Row(
              children: TeacherDomain.genders
                  .map((e) => CustomRadio(
                        activeColor: Colors.amber,
                        value: e,
                        label: capitalize(e),
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            gender = value;
                          });
                        },
                      ))
                  .toList(),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              items: TeacherDomain.grades
                  .map((e) => DropdownMenuItem(child: Text(e), value: e))
                  .toList(),
              value: grade,
              onChanged: (value) {
                setState(() {
                  grade = value;
                });
              },
              isExpanded: true,
              hint: Text("Pilih Jenjang"),
            ),
            SizedBox(height: 10),
            Text('Hobi', style: TextStyle(color: Colors.blue)),
            Column(
                children: TeacherDomain.hoobyList
                    .map((e) => CustomCheckBox(
                          text: e,
                          value: valueHobbies.contains(e),
                          onChanged: (value) {
                            setState(() {
                              if (valueHobbies.contains(e)) {
                                valueHobbies.remove(e);
                              } else {
                                valueHobbies.add(e);
                              }
                            });
                          },
                        ))
                    .toList()),
            SizedBox(height: 10),
            TextFormField(
                controller: addressController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Tidak boleh kosong";
                  } else {
                    return null;
                  }
                },
                maxLines: 5,
                decoration: InputDecoration(
                    hintText: "Alamat",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if(_formKey.currentState.validate()){
            TeacherDomain studentDomain = TeacherDomain();
            studentDomain.address = addressController.text.trim();
            studentDomain.hobbies = valueHobbies;
            studentDomain.grade = grade;
            studentDomain.gender = gender;
            studentDomain.mobilePhone = mobilePhoneController.text.trim();
            studentDomain.lastName = lastNameController.text.trim();
            studentDomain.firstName = firtNameController.text.trim();

            if(widget.isEdit){
              AppServices.getTeacherService.updateStudent(widget.studentDomain.idStudent, studentDomain).then((value){
                Navigator.pop(context);
              }).catchError((error){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
              });
            }else{
              AppServices.getTeacherService.createStudents(studentDomain).then((value){
                Navigator.pop(context);
              }).catchError((error){
                print(error);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
              });
            }
          }else{
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Silahkan isi"))
            );
          }
        },
        child: Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
