import 'package:flutter_test/flutter_test.dart';
import 'package:forrus/funcs/getAPI.dart';


void main(){
  test("Проверка получение новостей", ()  async{

    var list = await fetchNews(true);

    print(list);

  });
}