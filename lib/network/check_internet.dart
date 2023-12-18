


import 'package:http/http.dart' as http;

class CheckInternet{

static Future<bool> checkInternetStatus() async {
  try {
    final url = Uri.https('google.com');
    // await http
    //     .get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}


}



