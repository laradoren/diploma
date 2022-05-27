import 'dart:math';

import 'package:diplom/models/chart_data.dart';
import 'package:diplom/models/course.dart';
import 'package:diplom/models/data.dart';
import 'package:diplom/models/log.dart';
import 'package:diplom/models/mark.dart';
import 'package:diplom/models/test.dart';
import 'package:diplom/models/user.dart';
import 'package:diplom/models/users_logs_by_course.dart';
import 'package:intl/intl.dart';

class Calculator {
  /// Counts progress for course
  int countActiveUsers(users) {
    return users.length;
  }

  int calculateAverageTestResult(users, courseTests, course) {
    int allCoursePercentage = 0;
    int testsLength = 0;

    for (Test test in courseTests) {
      if (course.branches.contains(test.branchId) || (test.courseId != null && test.courseId!.contains(course.course.course))) {
        allCoursePercentage = allCoursePercentage + int.parse(test.percentage);
        for(CourseUser user in users) {
          if(user.userId == test.userId) {
            testsLength++;
          }
        }
      }
    }
    return (allCoursePercentage/testsLength).round();
  }

  List<UserInfo> getCourseUsers(users, course) {
    List<UserInfo> courseUsers = [];

    for(UserInfo user in users) {
      for(CourseUser userInCourse in course.users) {
          if(user.id == userInCourse.userId) {
            courseUsers.add(user);
          }
      }
    }
    return courseUsers;
  }

  String calculateAverageSpendTime(usersLogs, course) {
    int allSpendTime = 0;
    int userLogsLength = 0;

    final splittedCourse = course.course.course.split('-')[0];

    for (UserLog userLog in usersLogs) {
      if ((userLog.contentId != null && userLog.contentId!.contains(course.course.course)) || (userLog.contentId != null && userLog.contentId!.contains(splittedCourse))) {
        allSpendTime += int.parse(userLog.seconds.toString());
        userLogsLength++;
      }
    }

    int averageSpendTime = (allSpendTime/userLogsLength).round();

    int spendHours = 0;
    int spendMinutes = 0;
    int spendSeconds = 0;

    var averageTimeString = "";

    if(averageSpendTime < 3600) {
      if(averageSpendTime < 60) {
        spendSeconds = (averageSpendTime % 60).round();
      } else {
        spendMinutes = (averageSpendTime / 60).round();
        spendSeconds = (averageSpendTime % 60).round();
      }
    } else {
      spendHours = (averageSpendTime / 3600).round();
      spendMinutes = (averageSpendTime / 60).round();
      spendSeconds = (averageSpendTime % 60).round();
    }

    if(spendHours > 0) {
      averageTimeString = '$averageTimeString $spendHours h';
    }

    if(spendMinutes > 0) {
      averageTimeString = '$averageTimeString $spendMinutes m';
    }

    if(spendSeconds > 0) {
      averageTimeString = '$averageTimeString $spendSeconds s';
    }

    return averageTimeString.toString();
  }

  int countProgress(userLogs, branches, numberOfBranchesChildren) {
    int courseToCompleteTime = 0;
    int progress = 0;
    int index = 0;
    double time = 0;
    int numberOfPages = 0;

    print("HERE1");
    for(var pages in numberOfBranchesChildren) {
      if(pages.length > 0) {
        numberOfPages += int.parse(pages.length.toString());
      }
      numberOfPages += 1;
    }

    print("HERE2");

    courseToCompleteTime = numberOfPages * 600;

    for (String branch in branches) {
      double branchTime = 0;
      List<String> childrenName = [];

      if(numberOfBranchesChildren[index].length > 0) {
        for(var item in numberOfBranchesChildren[index]) {
          childrenName.add(item.view);
        }
      }

      for (UserLog userLog in userLogs) {
        if (userLog.contentId!.contains(branch) || childrenName.contains(userLog.contentId)) {
          branchTime += int.parse(userLog.seconds.toString());
        }
      }

      if (branchTime > courseToCompleteTime / branches.length) {
        branchTime = courseToCompleteTime / branches.length;
      }

      index++;
      time += branchTime;
    }

    print("HERE3");

    progress = (time / (courseToCompleteTime / 100)).round();

    if (progress > 100) {
      progress = 100;
    }

    return progress;
  }


  /// Counts time spent on course
  double countTime(userLogs, course) {
    double time = 0;
    final splittedCourse = course.split('-')[0];

    for (UserLog userLog in userLogs) {
      if (userLog.contentId!.contains(course) || userLog.contentId!.contains(splittedCourse)) {
        time += int.parse(userLog.seconds.toString());
      }
    }

    return double.parse(time.toStringAsPrecision(1));
  }

  /// Counts time spent on course
  double countPercentage(tests, course) {
    double percentage = 0.0;
    final splittedCourse = course.split('-')[0];

    for (Test test in tests) {
      if ((test.branchId != null && test.branchId!.contains(course)) || (test.branchId != null && test.branchId!.contains(splittedCourse))) {
        percentage += double.parse(test.percentage);
      }
    }

    return percentage;
  }

  /// Counts daily activity
  double countDailyProgress(logs) {
    double progress = 0;

    for (UserLog userLog in logs) {
      progress += int.parse(userLog.seconds.toString());
    }

    if(progress > 100) {
      progress = 100;
    }

    return progress.roundToDouble();
  }

  String getDailyProgressMessage(progress) {
    if(progress == 100) {
      return 'You did a great work today. Be proud!';
    } else if(progress >= 75) {
      return 'You made decent work today!';
    } else if(progress >= 50) {
      return "Half way passed! Don't stop!";
    } else if(progress >= 25) {
      return 'Good start. Keep it up!';
    } else {
      return 'Lets learn something new today';
    }

  }

  /// Counts number of completed and inProgress courses
  List<int> countCompletedCourses(courses, userLogs) {
    int completedCourses = 0;
    int inProgressCourses = 0;
    int progress = 0;
    int time = 0;

    for (var course in courses) {
      for (UserLog userLog in userLogs) {
        if (userLog.contentId!.contains(course['course'])) {
          time += int.parse(userLog.seconds.toString());
        }
      }

      progress = (time / 30).round();

      if (progress >= 100) {
        completedCourses += 1;
      } else {
        inProgressCourses += 1;
      }

      time = 0;
    }

    return [completedCourses, inProgressCourses];
  }

  /// check which global achievements are completed
  List<int> getGlobalAchievements(courses, userLogs, userTests) {
    List<int> achievements = [];
    String bestMark = '0';

    if (courses.length > 0) {
      achievements.add(1);
    }

    if (countCompletedCourses(courses, userLogs)[0] > 0) {
      achievements.add(2);
    }

    if (userTests.length > 0) {
      achievements.add(3);
    }

    for (var userTest in userTests) {
      if (userTest.percentage == '100') {
        bestMark = '100';
      }
    }

    if (bestMark == '100') {
      achievements.add(4);
    }

    return achievements;
  }

  /// check which course achievements are completed
  List<int> getCourseAchievements(Mark bestMark, course, userLogs) {
    List<int> achievements = [];

    if(countTime(userLogs, course.toLowerCase()) > 0) {
      achievements.add(1);
    }

    if(bestMark.mark != null) {
      if(int.parse(bestMark.mark!) > 80) {
        achievements.add(2);
      }
    }


    return achievements;
  }

  List<String> getUsersIdByCourse(courses) {
    List<String> _usersIdInCourses = [];
    for(Course course in courses) {
      final users = course.users;
      for(final user in users) {
        if(!_usersIdInCourses.contains(user.userId)) {
          _usersIdInCourses.add(user.userId.toString());
        }
      }
    }
    return _usersIdInCourses;
  }

  List<UserLog> getUsersLogByWeek(usersLog, courses) {
    List<UserLog> _usersLogsByWeek = <UserLog>[];
    List<String> _weekData = [];
    List<String> _usersIdInCourses = getUsersIdByCourse(courses);

    for (int i = 0; i < 7; i++) {
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 6 - i)));
      _weekData.add(currentDate);
    }

    for(final log in usersLog) {
      if(_usersIdInCourses.contains(log.userId)) {
        final time = log.time.split(" ")[0];
        if(_weekData.contains(time)) {
          _usersLogsByWeek.add(log);
        }
      }
    }

    return _usersLogsByWeek;
  }

  /// calculates time spent every day on course through last 7 days
  List<ChartData> getTimeChartData(userWeekLogs, courses) {
    List<ChartData> chartData = <ChartData>[];
    double time = 0.0;

    for (int i = 0; i < 7; i++) {
      String currentDay = DateFormat('EEEE').format(DateTime.now().subtract(Duration(days: 6 - i)));
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 6 - i)));
      List<UserLog> currentDayLogs = [];
      currentDayLogs.addAll(userWeekLogs);
      currentDayLogs.retainWhere((UserLog userLog) => userLog.time!.contains(currentDate));

      for(Course course in courses) {
        time = countTime(currentDayLogs, course.course.course.toLowerCase()) + time;
      }
        chartData.add(ChartData(
            '${currentDay[0]}${currentDay[1]}${currentDay[2]}', time));

    }

    return chartData;
  }
  /// calculates time spent every day on course through last 7 days
  List<ChartData> getTestChartData(userTests, courses) {
    List<ChartData> chartData = <ChartData>[];
    double percentage = 0.0;

    for (int i = 0; i < 7; i++) {
      String currentDay = DateFormat('EEEE').format(DateTime.now().subtract(Duration(days: 6 - i)));
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 6 - i)));
      List<Test> currentDayTest = [];
      currentDayTest.addAll(userTests);
      currentDayTest.retainWhere((Test test) => test.timeStart!.contains(currentDate));
      for(Course course in courses) {
        percentage = countPercentage(currentDayTest, course.course.course.toLowerCase()) + percentage;
      }
      final value;
      if(percentage == 0 && currentDayTest.isEmpty) {
        value = 0;
      } else {
        value = percentage/currentDayTest.length;
      }
      chartData.add(ChartData(
            '${currentDay[0]}${currentDay[1]}${currentDay[2]}', value/60));
    }
    return chartData;
  }

  /// calculates time spent every day on course through last 7 days
  List<Data> calculateBestTestResult(userTests, courses, users) {
    List<Data> chartData = <Data>[];
    List<Test> weeklyTests = [];
    List <String> usersId = [];

    for (int i = 0; i < 7; i++) {
      String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 6 - i)));
      List<Test> currentDayTest = [];
      currentDayTest.addAll(userTests);
      currentDayTest.retainWhere((Test test) => test.timeStart!.contains(currentDate));
      weeklyTests.addAll(currentDayTest);
    }
    for(Test test in weeklyTests) {
      if(double.parse(test.percentage) > 66.0) {
        for(final user in users) {
          if(test.userId == user.id) {
            chartData.add(Data(key: '${user.name} ${user.surname}', value: test.percentage + " %"));
          }
        }
      }
    }

    return chartData;
  }

  /// calculates time spent every day on course through last 7 days
  List<Data> calculateMostActiveUsers(weekLogs, courses, users) {
    List<Data> chartData = <Data>[];
    double time = 0.0;
    double allTimeForWeek = 0.0;
    List<String> _usersIdInCourses = getUsersIdByCourse(courses);
    for(Course course in courses) {
      allTimeForWeek = countTime(weekLogs, course.course.course) + allTimeForWeek;
    }

    for(final id in _usersIdInCourses) {
      time = 0.0;
      for(UserLog log in weekLogs) {
        if(id == log.userId) {
          time = time + double.parse(log.seconds);
        }
      }

      if(time > allTimeForWeek/3*2) {
        for(UserInfo user in users) {
          if(id == user.id) {
            chartData.add(Data(key: '${user.name} ${user.surname}', value: time.toString() + " seconds"));
          }
        }
      }
    }

    return chartData;
  }
  /// calculates time spent every day on course through last 7 days
  double calculateSpentTimeByWeek(usersLogs, courses, currentDate) {
    double usersTime = 0.0;
    List<String> branches = <String>[];

    branches.addAll(courses.branches);

    for(final userLog in usersLogs) {
      for(final branch in branches) {
        if(userLog.contentId.contains(branch) && userLog.time!.contains(currentDate)) {
          usersTime = usersTime + userLog.seconds;
        }
      }
    }

    return usersTime;
  }

  List<List<ChartData>> countTimeForLast7Days(usersLogs, course, branches) {
    List<List<ChartData>> weekTime = [];

    for (int i = 0; i < 7; i++) {
      DateTime date = DateTime.now().subtract(Duration(days: 6 - i));
      String dateFormat = DateFormat('yyyy-MM-dd').format(date);
      List<ChartData> dayTime = <ChartData>[];
      int index = 0;

      for (var branch in branches) {
        double branchTime = 0;

        for (UserLog userLog in usersLogs) {
          if (userLog.contentId!.contains(branch) &&
              userLog.time!.contains(dateFormat)) {
            branchTime += double.parse(userLog.seconds.toString());
          }
        }

        branchTime /= 60;
        index++;

        dayTime.add(ChartData(index.toString(), branchTime));
      }

      weekTime.add(dayTime);
    }

    return weekTime;
  }

  double getAverageTestsResult(data) {
    double averageMark = 0;
    int counter = 0;

    for(var elem in data) {
      averageMark += int.parse(elem.percentage.toString());
      counter++;
    }

    averageMark /= counter;

    return averageMark.roundToDouble();
  }

  List filterUsersTestsByResult(tests) {
    int counterForLow = 0;
    int counterForAverage = 0;
    int counterForHigh = 0;

    for(final test in tests) {
      if(int.parse(test.percentage) <= 33) {
        counterForLow++;
      } else {
        if(int.parse(test.percentage) >= 66) {
          counterForHigh++;
        } else {
          counterForAverage++;
        }
      }
    }

    return [counterForLow, counterForAverage, counterForHigh];
  }

  List filterUsersTimesByResult(courseLog) {
    int counterForTime = 0;
    List usersTime = [];
    int counterForLow = 0;
    int counterForAverage = 0;
    int counterForHigh = 0;

    for(final log in courseLog) {
      counterForTime = 0;
      for(final userLog in log.logs) {
        counterForTime = int.parse(userLog.seconds) + counterForTime;
      }
      usersTime.add(counterForTime);
    }

    for(final time in usersTime) {
      final convertedTime = time/60;
      if(convertedTime < 20) {
        counterForLow++;
      } else {
        if(convertedTime > 40) {
          counterForHigh++;
        } else {
          counterForAverage++;
        }
      }
    }

    return [counterForLow, counterForAverage, counterForHigh];
  }

  List<ChartData> calculateTestsGapsChartData(courseTests) {
    List<ChartData> chartData = <ChartData>[];

    List courseTestResult = filterUsersTestsByResult(courseTests);
    chartData.add(ChartData('Low', courseTestResult[0]));
    chartData.add(ChartData('Average', courseTestResult[1]));
    chartData.add(ChartData('High', courseTestResult[2]));

    return chartData;
  }

  List<Data> calculateTestsStatistics(courseTests, users) {
    List<Data> testsData = <Data>[];
    var user;

    for(final test in courseTests) {
      if(int.parse(test.percentage) > 75) {
        user = findUserById(users, test.userId);
        if(!userInData(testsData, user)) {
          testsData.add(Data(key: '${user.name} ${user.surname}', value: test.percentage));
        }
      }
    }

    return testsData;
  }

  UserInfo findUserById(users, id) {
    UserInfo foundUser = const UserInfo(id: "0", name: "Name", surname: "Surname", login: "Login");
    for(final user in users) {
      if(user.id == id) {
        foundUser = user;
      }
    }

    return foundUser;
  }

  bool userInData(tests, user) {
    var isUserAlreadyStore = false;
    for(final test in tests) {
      if(test.key == '${user.name} ${user.surname}') {
        isUserAlreadyStore = true;
      }
    }

    return isUserAlreadyStore;
  }

  List<ChartData> calculateTimeGapsChartData(List <UserLog> logs) {
    List<ChartData> timeData = <ChartData>[];
    List courseTestResult = filterUsersTimesByResult(logs);
    timeData.add(ChartData('0 - 20 m', courseTestResult[0]));
    timeData.add(ChartData('20 - 40 m', courseTestResult[1]));
    timeData.add(ChartData('40 - 60 m', courseTestResult[2]));

    return timeData;
  }

  List<ChartData> calculateTimeBranchGapsChartData(List <UserLog> logs, List branches) {
    List<ChartData> timeBranchData = <ChartData>[];
    double timeOnBranch = 0;

    for(final branch in branches) {
      timeOnBranch = 0;
      for(final userLog in logs) {
        if(userLog.contentId!.contains(branch)) {
          timeOnBranch = timeOnBranch + double.parse(userLog.seconds);
        }
      }
      timeBranchData.add(ChartData(branch, timeOnBranch/60));
    }

    return timeBranchData;
  }
  List<ChartData> calculateTestBranchGapsChartData(List <Test> tests, List branches) {
    List<ChartData> testsBranchData = <ChartData>[];
    double allTestsResultsOnBranch = 0;
    double testsLength = 0;

    for(final branch in branches) {
      allTestsResultsOnBranch = 0;
      testsLength = 0;
      for(final test in tests) {

        if(test.branchId == branch) {
          allTestsResultsOnBranch = allTestsResultsOnBranch + double.parse(test.percentage);
          testsLength++;
        }
      }
      testsBranchData.add(ChartData(branch, allTestsResultsOnBranch/testsLength));
    }

    return testsBranchData;
  }

  int calculateHeightOfChart(chartData) {
    int height = 0;

    for(final data in chartData) {
      if(data.y > height) {
        height = data.y.round();
      }
    }

    return height + 5;
  }

  double calculateActiveUsers(course, users) {
    double activeUsersCount = 0;
    List courseUsersId = [];
    for(final user in course.users) {
      if(user.active == "1") {
        courseUsersId.add(user.userId);
      }
    }
    for(final user in users) {
      if(courseUsersId.contains(user.id)) {
        activeUsersCount++;
      }
    }
    return activeUsersCount;
  }

  double calculateAllSpentTimeOnCourse(course, usersLogs) {
    double timeOnBranch = 0;

    for(final userLog in usersLogs) {
        if (userLog.contentId != null && userLog.contentId!.contains(course)) {
          timeOnBranch = timeOnBranch + double.parse(userLog.seconds);
        }
      }

    return timeOnBranch/3600;
  }

  List<ChartData> calculateStatisticsInBranches(List<String> branches, List<UserLog> usersLogs) {
    List<ChartData> statisticsBranches = [];
    ChartData mostPopBranch = ChartData("initial", 0);
    ChartData lessPopBranch = ChartData("initial", 100000);
    double timeOnBranch;
    double countOfLog;
    for(final branch in branches) {
      timeOnBranch  = 0;
      countOfLog  = 0;
      for(final log in usersLogs) {
        if (log.contentId != null && log.contentId!.contains(branch)) {
          timeOnBranch = timeOnBranch + double.parse(log.seconds);
          countOfLog++;
        }
      }
      if(timeOnBranch > double.parse(mostPopBranch.y.toString())) {
        mostPopBranch = ChartData(branch, timeOnBranch/countOfLog);
      }
      if(timeOnBranch < double.parse(lessPopBranch.y.toString())) {
        lessPopBranch = ChartData(branch, timeOnBranch/countOfLog);
      }
    }

    statisticsBranches.add(mostPopBranch);
    statisticsBranches.add(lessPopBranch);

    return statisticsBranches;
  }
}
