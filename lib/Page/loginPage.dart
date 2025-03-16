import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/blocs/loginBloc/login_bloc.dart';

import 'package:projects/similiar/appcolors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailControl_ = TextEditingController();
  TextEditingController passwordControl_ = TextEditingController();
  var errmessage = "";

  @override
  void dispose(){
    super.dispose();
    emailControl_.dispose();
    passwordControl_.dispose();

  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColors.primary,
        body:
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if(state is LoginSucces){
              Navigator.pushNamed(context, '/startpage');
            }else if(state is LoginFail){
              setState(() {
                errmessage = state.errMessage;
              });
            }
          },
          child:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: screenHeight/2,
                    decoration: BoxDecoration(
                        color: AppColors.bars
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.blue
                            ),
                          ),
                        ),
                        Text("Login", style: TextStyle(color: Colors.white, fontSize: 20), ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Email", style: TextStyle(color: Colors.white, fontSize: 20), ),
                            Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  controller: emailControl_,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter Email here',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Password", style: TextStyle(color: Colors.white, fontSize: 20), ),
                            Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  obscureText: true,
                                  controller: passwordControl_,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Enter Password here',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                              onTap: (){
                                context.read<LoginBloc>().add(LoginUser(
                                    password: passwordControl_.text.trim(),
                                    email: emailControl_.text.trim()
                                ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.btn2,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Login", style: TextStyle(fontSize: 30, color: Colors.white),),
                                ),
                              ),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.btn2,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Register", style: TextStyle(fontSize: 30, color: Colors.white),),
                              ),
                            ),

                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Text(errmessage, style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
        )
    );
  }
}
