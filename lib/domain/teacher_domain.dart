import 'package:sekolahku/utils/capitalize.dart';

class TeacherDomain {
  int idStudent;
  String firstName;
  String lastName;
  String mobilePhone;   
  String gender;
  String grade;
  String address;
  List<String> hobbies;

  String get fullName{
    return "${capitalize(firstName)} ${capitalize(lastName)}";
  }
  static const genders = ["Pria", "Wanita"];
  static const grades = ["SMP", "SMK", "SMA", "S1", "S2", "S3"];
  static const hoobyList = ["membaca", "menulis", "menggambar", "Lainnya"];

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'mobile_phone': mobilePhone,
      'gender': gender,
      'grade': grade,
      'address': address,
      'hobbies': hobbies.join(', '),
    };
  }

  void fromMap(Map<String, dynamic> value){
    idStudent = value['id_teacher'];
    firstName = value['first_name'];
    lastName = value['last_name'];
    mobilePhone = value['mobile_phone'];
    gender = value['gender'];
    grade = value['grade'];
    address = value['address'];
    hobbies = value['hobbies'] is String ? value['hobbies'].split(', ') : [];
  }
}
