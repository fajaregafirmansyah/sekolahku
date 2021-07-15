import 'package:sekolahku/domain/student_domain.dart';
import 'package:sekolahku/repository/student_repository.dart';
import 'package:sekolahku/service/app_service.dart';

class StudentService{
  final StudentRepository stundentRepository;

  StudentService(this.stundentRepository);

  Future<int> createStudents(StudentDomain studentDomain){
      return stundentRepository.create(studentDomain);
  }

  Future<void> deleteStudent(int index){
    return stundentRepository.delete(index);
  }

  Future<List<StudentDomain>> readStudents(String keyword){
    return stundentRepository.readStudents(keyword);
  }

  Future<StudentDomain> studentById(int index){
    return studentRepository.studentById(index);
  }

  Future<int> updateStudent(int id, StudentDomain studentDomain){
    return stundentRepository.updateStudent(id, studentDomain);
  }
  
}