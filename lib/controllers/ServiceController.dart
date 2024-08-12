import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../globals.dart';
import '../model/session2_model.dart';

class ServiceController extends GetxController {
  var services = [].obs;
  var isLoading = true.obs;
  var advancedUsers = [].obs;
  var searchResults = <Service>[].obs;
  var sessions = [].obs;



  /*Future<void> searchServices(String query) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('$baseURL/api/service/searchForAdvancedUser?serviceName=$query'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body) as List;
        searchResults.value = jsonData.map((json) => Service.fromJson(json)).toList();
      } else {
        print(response.body);
      }
    } finally {
      isLoading(false);
    }
  }*/
  void fetchAdvancedUsers(int serviceId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('$baseURL/api/service/showAdvancedUsersOfService/$serviceId'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );
      if (response.statusCode == 200) {
        print('200 advanced');
        var jsonData = jsonDecode(response.body);
        advancedUsers.value = jsonData;
      } else {
        print(response.body);
      }
    } finally {
      isLoading(false);
    }
  }

  void fetchServices(String type) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('$baseURL/api/service/showByType/$type'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );
      print(type);
      print('i am in');
      if (response.statusCode == 200) {
        print('200');
        var jsonData = jsonDecode(response.body);
        services.value = jsonData;
      }else{
        print(response.body);
      }
    } finally {
      isLoading(false);
    }
  }
  Future<void> createSession(int serviceId, String sessionName, String sessionDescription, String sessionDate, String sessionStartTime, String sessionEndTime) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.post(
        Uri.parse('$baseURL/api/session/create/$serviceId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'sessionName': sessionName,
          'sessionDescription': sessionDescription,
          'sessionDate': sessionDate,
          'sessionStartTime': sessionStartTime,
          'sessionEndTime': sessionEndTime,
        }),
      );
      print('i am in');
      print(serviceId);
      if (response.statusCode == 200) {
        print('200 add');
        Get.snackbar('Success', 'Session created successfully');
      } else {
        print(response.body);
        print(response.statusCode);
        Get.snackbar('Error', 'Failed to create session');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while creating session');
    }
  }

  void fetchSessions(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('$baseURL/api/session/showAllRelated/$userId'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        sessions.value = data.map((session) => Session.fromJson(session)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch sessions');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch sessions');
    } finally {
      isLoading.value = false;
    }
  }
  void fetch_general_Sessions(int serviceId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('$baseURL/api/session/showAll/$serviceId'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        sessions.value = data.map((session) => Session.fromJson(session)).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch sessions');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch sessions');
    } finally {
      isLoading.value = false;
    }
  }

  void updateSession(Session updatedSession) {
    int index = sessions.indexWhere((session) => session.id == updatedSession.id);
    if (index != -1) {
      sessions[index] = updatedSession;
    }else{
      Get.snackbar('Error', 'Failed to edit sessions');
    }
  }
  /*Future<void> updateSession(int sessionId, String sessionName, String sessionDescription, String sessionDate, String sessionStartTime, String sessionEndTime) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    isLoading.value = true;
    try {
      var response = await http.put(
        Uri.parse('$baseURL/api/session/update/$sessionId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'sessionName': sessionName,
          'sessionDescription': sessionDescription,
          'sessionDate': sessionDate,
          'sessionStartTime': sessionStartTime,
          'sessionEndTime': sessionEndTime,
        }),
      );
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Session updated successfully');
        fetchSessions(sessionId); // تحديث الجلسات بعد التحديث
      } else {
        Get.snackbar('Error', 'Failed to update session');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while updating session');
    } finally {
      isLoading.value = false;
    }
  }*/

  Future<void> deleteSession(int sessionId,int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    isLoading.value = true;
    try {
      final response = await http.delete(
        Uri.parse('$baseURL/api/session/cancel/$sessionId'),
        headers: <String, String>{
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        //fetchSessions(); // Refresh the session list after delete
        Get.snackbar('Success', 'Session deleted successfully');
        //fetchSessions(userId);
        // fetch_general_Sessions(serviceId);
      //
      } else {
        print(response.body);
        print(response.statusCode);
        Get.snackbar('Error', 'Failed to delete session');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete session');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> startSession(int sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.put(
        Uri.parse('$baseURL/api/session/start/$sessionId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      print('hey');
      if (response.statusCode == 200) {
        print('start');
        var session = Session.fromJson(jsonDecode(response.body));
        updateSession(session);
        Get.snackbar('Success', 'Session started successfully');
      } else {
        print(response.body);
        print(response.statusCode);
        Get.snackbar('Error', 'Failed to start session');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while starting session');
    }
  }

  Future<void> closeSession(int sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    try {
      var response = await http.put(
        Uri.parse('$baseURL/api/session/close/$sessionId'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );
      print('bye');
      if (response.statusCode == 200) {
        print('close');
        var session = Session.fromJson(jsonDecode(response.body));
        updateSession(session);
        Get.snackbar('Success', 'Session closed successfully');
      } else {
        print(response.body);
        print(response.statusCode);
        Get.snackbar('Error', 'Failed to close session');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while closing session');
    }
  }

}



/*
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/service_model.dart';

class ServiceController extends GetxController {
  var services = <Service>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchServices();
    super.onInit();
  }

  Future<void> fetchServices() async {
    final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMDk4ZDQ0NGY3NGYxOGNkOTEzM2YyZjU4MTFkNDgwYjM0MDYzNWY0NjY2OTcyYjA3N2RlNDY0M2U0ZWRkMjAwMjQyOTU0M2IyZjU4ZmE1YjYiLCJpYXQiOjE3MTU4NTM2NzYuMTkyMjYzLCJuYmYiOjE3MTU4NTM2NzYuMTkyMjc2LCJleHAiOjE3NDczODk2NzYuMTgwNjc5LCJzdWIiOiIyNiIsInNjb3BlcyI6W119.G96SLA3SmU0nGFL3GoAlJoKFktDyyw-N34L6G3RwNLbWvRUijTq1e8Q3vpsUhabwvcHhUkBDU3eZWfx57dLvIbHJPFVx1eJi4xo9Ue0976GBWOSfr5BHW9RWpWtOItcz5d-doRt5tLI37lCQhOEbCtfObJfVY9tZNWGLqb3P8qYoJZBArZOT7JBMuIcw1FtyO3BtepeEL04tEdjL5MHIGK1_At3yXK4k0xpLwvxEZwKPDQ5fWxQdc1NBguV2Ir22rGX1F2eMejKHNbikaDhOh_8zZojKk5IWVkwTPw77W_OEE-_gK8A0QJMga4gNwx-hRIfnQlL1a1ncDrNqT8MvTC-c6rjsqrndPOqZrfzjZz1zY-EEI5fMxL2NxS260j5Jm78RQUREZ14tTXD_sNsCnJadxY5dI1kB_F6sEyZ55Ac0Nq4Dao0z9J3WXG7-9moYUa8FXKeQHo0HWlqSta9HSQjYO4KaDtwamgGp4Vxo0BVDnvr5HMv-tOC1wCMfA7NQmmBvATO5gJMrJAzPf9lwOPevIXMFnJkHSxC_HdqmU2fXf7fAs3xBzgLWJrAHdi6VSJ2WIn6gF3PZ1TWGT6EuOwe62ru21ljpYIJfoD03rRfK2wkxXzMlUt2xks-o9ksauZ3q3UrdLGqUTwHxZTC6ypWRQgFTym0iDdzG1sQTKHE";
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('http://192.168.137.216:8000/api/service/showByYearAndSpecialization/1'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        services.value = jsonResponse.map((data) => Service.fromJson(data)).toList();
      } else {
        Get.snackbar('Error', 'Failed to load services');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load services');
    } finally {
      isLoading(false);
    }
  }
}
*/