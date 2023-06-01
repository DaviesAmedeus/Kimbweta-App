import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/login_model.dart';

class APIService{

  ///Login API only

  Future<LoginResponseModel> login(LoginRequestModel requestModel)async{

    var url = Uri.parse("https://reqres.in/api/login");
    final response = await http.post(url,
      body: requestModel.toJson()
    );

    if(response.statusCode == 200 || response.statusCode == 400){
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else{
      throw Exception('Fail to load data');
    }

  }
}