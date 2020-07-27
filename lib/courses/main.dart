import 'package:flutter/material.dart';
import 'package:interviewquestions/courses/CoursesBloc.dart';
import 'package:interviewquestions/models/CoursesModel.dart';

import '../api/ApiResponse.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CoursesScreen());
  }
}

class CoursesScreen extends StatefulWidget {
  @override
  _TopicsScreenState createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<CoursesScreen> {
  CoursesBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = CoursesBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Interview Questions')),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () => _bloc.fetchCoursesList(),
        child: StreamBuilder<ApiResponse<CoursesModel>>(
          stream: _bloc.coursesListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(
                    loadingMessage: snapshot.data.message,
                  );
                  break;
                case Status.COMPLETED:
                  return CoursesList(coursesList: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _bloc.fetchCoursesList(),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class CoursesList extends StatelessWidget {
  final CoursesModel coursesList;

  const CoursesList({Key key, this.coursesList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: coursesList.courses.length,
      itemBuilder: (context, index) {
        return Card(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: ListTile(
                leading: Icon(Icons.album),
                title: Text(coursesList.courses[index].course_name),
                onTap: () {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(coursesList.courses[index].course_name),
                  ));
                },
              ),
            ),

        );
      },
    );
  }
}



class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.lightGreen,
            child: Text('Retry', style: TextStyle(color: Colors.white)),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightGreen,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ],
      ),
    );
  }
}
