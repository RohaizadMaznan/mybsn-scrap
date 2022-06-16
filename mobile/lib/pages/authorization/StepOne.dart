import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/classes/login_state.dart';
import 'package:provider/provider.dart';
import '../../utils/local_storage.dart';

class StepOne extends StatelessWidget {
  const StepOne({Key? key, required this.updateLoginState}) : super(key: key);
  final updateLoginState;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final usernameController = TextEditingController();
    return Consumer<LoginState>(
      builder: (context, loginState, _) {
        return Column(
          children: [
            SizedBox(
              width: 0.85 * width,
              child: Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(8),
                child: TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      hintText: "Enter your username...",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    )),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              width: 0.85 * width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    primary: Colors.cyan,
                    minimumSize: const Size.fromHeight(40)),
                onPressed: () async {
                  var username = usernameController.text;
                  await setDataExpired();
                  if (username.isNotEmpty) {
                    var dio = Dio();
                    try {
                      var BASE = dotenv.get('BASE_SERVER_URL');
                      var res = await dio.post( '$BASE/login/username',
                          data: {"username": username});

                      res.data = Map<String, dynamic>.from(res.data);
                      loginState.updateLocalUser(username: username, password: '');
                      
                      updateLoginState({"step": 2, "data": res.data});
                    } catch (e) {
                      log('step1'+e.toString());
                    }
                  }
                },
                child: const Text('Login'),
              ),
            )
          ],
        );
      }
    );
  }
}
