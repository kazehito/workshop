import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects/blocs/userRegisterBloc/user_register_bloc.dart';
import 'package:projects/similiar/appcolors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailControl_ = TextEditingController();
  TextEditingController passwordControl_ = TextEditingController();
  TextEditingController phoneControl_ = TextEditingController();

  String  errmessage = "";

  @override
  void dispose(){
    super.dispose();
    emailControl_.dispose();
    passwordControl_.dispose();
    phoneControl_.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primary,
        body:
        BlocListener<UserRegisterBloc, UserRegisterState>(
        listener: (context, state) {
      if(state is RegisterSuccess){
        Navigator.pushNamed(context, '/startpage');
      }else if(state is RegisterFail){
        setState(() {
          errmessage = state.errmessage!;
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
                      Text("Register", style: TextStyle(color: Colors.white, fontSize: 20), ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Phone Num", style: TextStyle(color: Colors.white, fontSize: 20), ),
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
                                controller: phoneControl_,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Phone here',
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
                            context.read<UserRegisterBloc>().add(RegisterUser(
                              phone: phoneControl_.text.trim(),
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
                              child: Text("Create", style: TextStyle(fontSize: 30, color: Colors.white),),
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                ),
              ),
                      Text(errmessage)
            ],
          ),
        ),
        )
    );
  }
}
