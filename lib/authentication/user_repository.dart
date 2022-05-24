import 'dart:async';
import 'dart:convert';
import 'package:diplom/api/branch.dart';
import 'package:diplom/api/courses.dart';
import 'package:diplom/api/logs.dart';
import 'package:diplom/api/tests.dart';
import 'package:diplom/api/users.dart';
import 'package:diplom/models/auth_user.dart';
import 'package:diplom/models/branch.dart';
import 'package:diplom/models/course.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/models/mark.dart';
import 'package:diplom/models/test.dart';
import 'package:diplom/models/user.dart';
import 'package:diplom/models/users_logs_by_course.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  AuthUser? _user;

  Future<AuthUser?> getUser(login, password) async {
    final response = await http.post(
      Uri.parse('http://semantic-portal.net/api/user/check/$login/$password'),
    );

    if(jsonDecode(response.body)["login"] == true) {
      return Future.delayed(
        const Duration(milliseconds: 300),
            () => _user = AuthUser(login: "${jsonDecode(response.body)['login']}", role: "-"),
      );
    }
  }

  Future<User> getUserById(id) async {
    return fetchUserDetailsById(id);
  }

  Future<List<UserInfo>>  getAllUsers() async {
    return fetchAllUsers();
  }

  Future<List<UserLog>> getUserLogsById(id) async {
    return fetchUserLogsById(id);
  }

  Future<List<UserLog>> getAllUsersLogs() async {
    return fetchAllLogs();
  }

  Future<List<UserLog>> getUserLogsFromTime(id, time) async {
    return fetchUserLogsFromTime(id, time);
  }

  Future<List<Test>> getUserTestsResult(id) async {
    return fetchTestsByUserId(id);
  }

  Future<Course> getCourse(course) async {
    return fetchCoursesByName(course);
  }

  Future<List<ShortCourse>> getAllCourses() async {
    return fetchAllCourses();
  }

  Future<List<Test>> getCourseTests(course) async {
    return fetchTestsFromCourse(course);
  }

  Future<List<Test>> getAllUsersTestsResult() async {
    return fetchAllTests();
  }

  Future<Mark> getUserBestMark(id, course) async {
    return fetchUserBestCourseMarkById(id, course);
  }

  Future<List<UsersLogsByCourse>> getUsersLogsByCoursesFromTime(users){
    return fetchUsersLogsByCourseFromTime(users);
  }

  Future<List<UserInfo>> getCourseUsers(users){
    return fetchUsersByCourse(users);
  }

  Future<Page> getPageByBranch(branch) async {
    return fetchPageByBranch(branch);
  }

  Future<List<Page>> getPageChildrenByBranch(branch) async {
    return fetchPageChildrenByBranch(branch);
  }
}