import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:forrus/models/ticket_model.dart';


Future<void> createTicket(TicketModel ticket) async{

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