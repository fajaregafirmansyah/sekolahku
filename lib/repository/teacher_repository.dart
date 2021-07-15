import 'package:sekolahku/domain/teacher_domain.dart';
import 'package:sekolahku/model/teacher_model_provider.dart';
import 'package:sekolahku/seed/seed.dart';

class TeacherRepository{
  final TeacherModelProvider _studentModelProvider;
  TeacherRepository(this._studentModelProvider);

  Future<int> create(TeacherDomain studentDomain){
    return _studentModelProvider.getDatabase().then((value) => value.insert('teacher', studentDomain.toMap()));
  }

  Future<void> delete(int idSiswa){
    return _studentModelProvider.getDatabase().then((value) => value.delete('teacher', where: 'id_teacher = $idSiswa'));
  }

  Future<List<TeacherDomain>> readStudents(String keyword){
    var sqlRaw = "SELECT * FROM teacher";

    if(keyword.isNotEmpty){
      var pattern = '%$keyword%';
      sqlRaw += '''
        WHERE first_name LIKE '$pattern' OR
        last_name LIKE '$pattern' OR
        mobile_phone LIKE '$pattern' OR
        gender LIKE '$pattern' OR
        grade LIKE '$pattern'
      ''';
    }

    return _studentModelProvider.getDatabase().then((value) => value.rawQuery(sqlRaw)).then((data){
      if(data.length == 0){
        return [];
      }

      List<TeacherDomain> students = [];
      for(int i=0; i<data.length; i++){
        TeacherDomain studentDomain = TeacherDomain();
        studentDomain.fromMap(data[i]);
        students.add(studentDomain);
      }

      return students;
    });
  }

 Future<TeacherDomain> studentById(int idTeacher){
   var sqlRaw = "SELECT * FROM teacher WHERE id_teacher = $idTeacher";
   return _studentModelProvider.getDatabase().then((value) => value.rawQuery(sqlRaw)).then((data){
     if(data.length == 1){

       TeacherDomain studentDomain = TeacherDomain();
       studentDomain.fromMap(data[0]);
       return studentDomain;
     }

     return null;
   });
 }

 Future<int> updateStudent(int idSiswa, TeacherDomain dataSiswa){
    return _studentModelProvider.getDatabase().then((value){
      return value.update('teacher', dataSiswa.toMap(), where: 'id_teacher = $idSiswa');
    });
 }

}