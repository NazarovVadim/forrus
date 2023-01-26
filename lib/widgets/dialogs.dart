import 'package:flutter/material.dart';
import 'package:forrus/styles/style_library.dart';

Future showSuccessDialog(BuildContext context, String text){
  return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text(text),
          actions: [
            ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text('Ок'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: StyleLibrary.color.primary,
                ),
            ),
          ],
        );
      }
  );
}

Future showErrorDialog(BuildContext context, String error){
  return showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          content: Text(error),
          actions: [
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text('Ок'),
              style: ElevatedButton.styleFrom(
                backgroundColor: StyleLibrary.color.primary,
              ),
            ),
          ],
        );
      }
  );
}