import 'package:sekolahku/model/student_model_provider.dart';
import 'package:sekolahku/model/teacher_model_provider.dart';
import 'package:sekolahku/repository/student_repository.dart';
import 'package:sekolahku/repository/teacher_repository.dart';
import 'package:sekolahku/service/student_service.dart';
import 'package:sekolahku/service/teacher_service.dart';
import 'package:sqflite/sqflite.dart';

StudentRepository studentRepository = StudentRepository(StudentModelProvider.getInstance());
StudentService studentService = StudentService(studentRepository);

TeacherRepository teacherRepository = TeacherRepository(TeacherModelProvider.getInstance());
TeacherService teacherService = TeacherService(teacherRepository);

class AppServices {
  static StudentService get getStudentService {
    return studentService;
  }

  static Future<Database> openDb(){
    return StudentModelProvider.getInstance().openDb();
  }

  static Future<Database> closeDb(){
    return StudentModelProvider.getInstance().closeDb();
  }

  static TeacherService get getTeacherService {
    return teacherService;
  }

  static Future<Database> openDbTeacher(){
    return TeacherModelProvider.getInstance().openDb();
  }

  static Future<Database> closeDbTeacher(){
    return TeacherModelProvider.getInstance().closeDb();
  }
}
