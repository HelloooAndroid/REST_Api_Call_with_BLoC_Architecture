import 'dart:convert';

import 'package:interviewquestions/api/Api.dart';
import 'package:interviewquestions/models/CoursesModel.dart';

class CoursesRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<CoursesModel> fetchCoursesList() async {
    final response = await _helper.get("courses");
    return CoursesModel.fromJson(response);
  }
}