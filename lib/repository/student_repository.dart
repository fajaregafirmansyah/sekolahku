import 'package:sekolahku/domain/student_domain.dart';
import 'package:sekolahku/model/student_model_provider.dart';
import 'package:sekolahku/seed/seed.dart';

class StudentRepository{
  final StudentModelProvider _studentModelProvider;
  StudentRepository(this._studentModelProvider);

  Future<int> create(StudentDomain studentDomain){
    return _studentModelProvider.getDatabase().then((value) => value.insert('siswa', studentDomain.toMap()));
  }

  Future<void> delete(int idSiswa){
    return _studentModelProvider.getDatabase().then((value) => value.delete('siswa', where: 'id_siswa = $idSiswa'));
  }

  Future<List<StudentDomain>> readStudents(String keyword){
    var sqlRaw = "SELECT * FROM siswa";

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

      List<StudentDomain> students = [];
      for(int i=0; i<data.length; i++){
        StudentDomain studentDomain = StudentDomain();
        studentDomain.fromMap(data[i]);
        students.add(studentDomain);
      }

      return students;
    });
  }

 Future<StudentDomain> studentById(int idSiswa){
   var sqlRaw = "SELECT * FROM siswa WHERE id_siswa = $idSiswa";
   return _studentModelProvider.getDatabase().then((value) => value.rawQuery(sqlRaw)).then((data){
     if(data.length == 1){

       StudentDomain studentDomain = StudentDomain();
       studentDomain.fromMap(data[0]);
       return studentDomain;
     }

     return null;
   });
 }

 Future<int> updateStudent(int idSiswa, StudentDomain dataSiswa){
    return _studentModelProvider.getDatabase().then((value){
      return value.update('siswa', dataSiswa.toMap(), where: 'id_siswa = $idSiswa');
    });
 }

}