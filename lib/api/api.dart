import 'dart:convert';
import 'package:crime_report/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class CallApi{
    // final String _url = 'http://192.168.1.3:8000/api/';
    // final String _url1 = 'http://192.168.1.3:8000/uploads/';
    // final String _url = 'http://api.cirms.xyz/api/';
    // final String _url1 = 'http://api.cirms.xyz/public/uploads/';
    final String _url = 'http://crimeapi.letsruncode.com/api/';
    final String _url1 = 'http://crimeapi.letsruncode.com/public/uploads/';

    getURL(){
      var url = _url1;
      return url;
    }
    postData(data, apiUrl) async {
        var fullUrl = _url + apiUrl; 
        return await http.post(
            fullUrl, 
            body: jsonEncode(data), 
            headers: _setHeaders()
        );
    }
    getData(apiUrl) async {
       var fullUrl = _url + apiUrl; 
       return await http.get(
         fullUrl, 
         headers: _setHeaders()
       );
    }

    _setHeaders() => {
        'Content-type' : 'application/json',
        'Accept' : 'application/json',
    };

    _getToken() async {
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        var user = localStorage.getString('user');
        return "$user[id]";
    }
}