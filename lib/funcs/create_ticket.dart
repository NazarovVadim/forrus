import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:forrus/models/ticket_error.dart';
import 'package:forrus/models/ticket_model.dart';


Future<void> createTicket(TicketModel ticket) async{

  if(ticket.files != null && ticket.files!.isNotEmpty){
    int bytes = 0;

    for(var file in ticket.files!){
      bytes += await file.length();
    }

    print(bytes);

    if(bytes/1024/1024 > 10){
      throw TicketError(message: 'Выбранный файлы слишком большого размера\nОбщий размер файлов не должен превышать 10 мб');
    }
  }


  Map<String, dynamic> data = ticket.toJson();
  data.addAll({
    "RESPONSIBLE_ID" : 240,
    "SLA" : 24,
  });


  var response = await Dio().post('https://1os.su/helpdesk/createTicket.php',
      options: Options(
        headers: {
          'Content-Type' : 'multipart/form-data'
        }
      ),
      queryParameters: {
        "domain" : 'portal.vkorpe.ru'
      },
      data: FormData.fromMap(data)

  );
  print(jsonDecode(response.data));

  var error = '';

  try{
     error = jsonDecode(response.data)['error'];

  }catch(e){
    error = '';
  }
  if(error == 'ERROR_CORE'){
    throw "Что-то пошло не так";
  }

}