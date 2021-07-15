import 'package:sekolahku/domain/teacher_domain.dart';
import 'package:sekolahku/repository/teacher_repository.dart';
import 'package:sekolahku/service/app_service.dart';

class TeacherService{
  final TeacherRepository teacherRepository;

  TeacherService(this.teacherRepository);

  Future<int> createStudents(TeacherDomain studentDomain){
      return teacherRepository.create(studentDomain);
  }

  Future<void> deleteStudent(int index){
    return teacherRepository.delete(index);
  }

  Future<List<TeacherDomain>> readStudents(String keyword){
    return teacherRepository.readStudents(keyword);
  }

  Future<TeacherDomain> studentById(int index){
    return teacherRepository.studentById(index);
  }

  Future<int> updateStudent(int id, TeacherDomain studentDomain){
    return teacherRepository.updateStudent(id, studentDomain);
  }
  
}