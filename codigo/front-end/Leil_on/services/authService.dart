import 'package:dio/dio.dart'

class AuthService{
  Dio dio = new Dio();
  login(email, password)async{
    try{
      return await dio.post(
        'https://leil-on.herokuapp.com/authenticate', 
        data: {  "email": email,"password": password},
        options: Options(contentType: Heades.formUrlEncodedContentType));
    } on DioError catch(e){
      Fluttertoast.showToast(msg: e.response.data['msg'],
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
      );
    };
  }
}