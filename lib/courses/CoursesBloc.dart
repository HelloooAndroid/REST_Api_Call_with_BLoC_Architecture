import 'dart:async';

import 'package:interviewquestions/api/ApiResponse.dart';
import 'package:interviewquestions/courses/CoursesRepository.dart';
import 'package:interviewquestions/models/CoursesModel.dart';

class CoursesBloc {
  CoursesRepository _coursesRepository;

  StreamController _coursesListController;

  StreamSink<ApiResponse<CoursesModel>> get coursesListSink =>
      _coursesListController.sink;

  Stream<ApiResponse<CoursesModel>> get coursesListStream =>
      _coursesListController.stream;

  CoursesBloc() {
    _coursesListController = StreamController<ApiResponse<CoursesModel>>();
    _coursesRepository = CoursesRepository();
    fetchCoursesList();
  }

  fetchCoursesList() async {
    coursesListSink.add(ApiResponse.loading('Fetching courses. Please wait.'));
    try {
      CoursesModel courses = await _coursesRepository.fetchCoursesList();
      coursesListSink.add(ApiResponse.completed(courses));
    } catch (e) {
      coursesListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _coursesListController?.close();
  }
}