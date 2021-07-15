import 'package:faker/faker.dart';
import 'package:sekolahku/domain/student_domain.dart';
import 'package:sekolahku/utils/random.dart';

class Seed{
  var faker = Faker();

  StudentDomain getStudentFaker(){
    var studentDomain = StudentDomain();

    studentDomain.firstName = faker.person.firstName();
    studentDomain.lastName = faker.person.lastName();
    studentDomain.mobilePhone = '087732743408';
    studentDomain.grade = StudentDomain.grades[getRandom(4)];
    studentDomain.gender = StudentDomain.genders[getRandom(2)];
    studentDomain.hobbies = StudentDomain.hoobyList;
    
    return studentDomain;
    }

    List<StudentDomain> getDummyData([int maxData = 10]){
      List<StudentDomain> listStudent = <StudentDomain>[];

      for (int i = 0; i < maxData; i++){
        listStudent.add(getStudentFaker());
      }

      return listStudent;
    }
}