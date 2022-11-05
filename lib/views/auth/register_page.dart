import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:laundry_app/model/api/auth_api.dart';
import 'package:laundry_app/views/auth/login_page.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double getSmallDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 2 / 3;

  double getBigDiameter(BuildContext context) =>
      MediaQuery.of(context).size.width * 7 / 8;
  final String blobSvg = 'assets/blob.svg';

  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String message = 'message';

  Future<void> submit() async {
    // final form = _formKey.currentState;
    final response =
        await Provider.of<AuthAPI>(context, listen: false).register(
      name: _name.text,
      email: _email.text,
      password: _password.text,
    );

    if (response['success']) {
      Navigator.pop(context);
    } else {
      message = 'Fail';
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Positioned(
              right: -getSmallDiameter(context) / 4,
              top: -getSmallDiameter(context) / 4,
              child: SizedBox(
                width: getSmallDiameter(context),
                height: getSmallDiameter(context),
                child: SvgPicture.asset(blobSvg),
              ),
            ),
            Positioned(
              left: -getBigDiameter(context) / 4,
              top: -getBigDiameter(context) / 4,
              child: Container(
                width: getBigDiameter(context),
                height: getBigDiameter(context),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFA7F0BA),
                      Color(0xFFA7F0BA),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: -getBigDiameter(context) / 2,
              bottom: -getBigDiameter(context) / 2,
              child: Container(
                width: getBigDiameter(context),
                height: getBigDiameter(context),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF3E9EE),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: const EdgeInsets.fromLTRB(20, 300, 20, 10),
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 25),
                    child: Column(
                      children: [
                        TextField(
                          controller: _name,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Color(0xFFA7F0BA),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF24A148),
                              ),
                            ),
                            labelText: 'Name :',
                            labelStyle: TextStyle(
                              color: Color(0xFF24A148),
                            ),
                          ),
                        ),
                        TextField(
                          controller: _email,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.email_rounded,
                              color: Color(0xFFA7F0BA),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF24A148),
                              ),
                            ),
                            labelText: 'Email :',
                            labelStyle: TextStyle(
                              color: Color(0xFF24A148),
                            ),
                          ),
                        ),
                        TextField(
                          controller: _password,
                          obscureText: true,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.vpn_key,
                              color: Color(0xFFA7F0BA),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF24A148),
                              ),
                            ),
                            labelText: 'Password :',
                            labelStyle: TextStyle(
                              color: Color(0xFF24A148),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF24A148),
                      ),
                      onPressed: submit,
                      child: const Text('SIGN UP'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "ALREADY HAVE ACCOUNT? ",
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'SIGN IN',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF24A148),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
