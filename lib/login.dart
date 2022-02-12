import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data_controller/login_controller.dart';
import 'home.dart';

class Login extends ConsumerWidget {


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(userFuture);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: viewModel.formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                        onTap: () {
                          exit(0);
                        },
                        child: Icon(Icons.arrow_back_outlined,
                            color: Constants.secondaryColor,
                            size: size.height * 0.035)),
                  ),
                ),
                // Text('Login',style: TextStyle(
                //     fontSize: size.height*0.025,
                //     fontWeight: FontWeight.w500,
                //     color: Constants.secondaryColor
                // ),),
                Lottie.asset('assets/images/welcome.json'),
                Container(
                  width: size.width * 0.8,
                  child: TextFormField(
                    controller: viewModel.nameController,
                    focusNode: viewModel.nameFocusNode,
                    cursorColor: Constants.secondaryColor,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontSize: size.height * 0.02,
                          color: Constants.secondaryColor),
                      hintText: 'Enter Username',
                      labelText: 'Username',
                      labelStyle: TextStyle(
                          color: viewModel.nameFocusNode.hasFocus
                              ? Constants.secondaryColor
                              : Colors.black54),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26, width: 1.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Constants.mainColor, width: 1.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      errorBorder:OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedErrorBorder:OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Constants.mainColor, width: 1.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: viewModel.nameFocusNode.hasFocus
                            ? Constants.secondaryColor
                            : Colors.black54,
                      ),
                      contentPadding: EdgeInsets.all(20),
                    ),
                    validator: (value){
if(value!.isEmpty ){
  return 'Username Required';
}
return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Container(
                  width: size.width * 0.8,
                  child: TextFormField(
                    controller: viewModel.passwordController,
                    focusNode: viewModel.passwordFocusNode,
                    cursorColor: Constants.secondaryColor,
                    obscureText: viewModel.seePassword,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                          fontSize: size.height * 0.02,
                          color: Constants.secondaryColor),
                      hintText: 'Enter Password',
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: viewModel.passwordFocusNode.hasFocus
                              ? Constants.secondaryColor
                              : Colors.black54),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black26, width: 1.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Constants.mainColor, width: 1.0),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      errorBorder:OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.red, width: 1.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedErrorBorder:OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Constants.mainColor, width: 1.0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: viewModel.passwordFocusNode.hasFocus
                            ? Constants.secondaryColor
                            : Colors.black54,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(viewModel.seePassword? Icons.visibility: Icons.visibility_off,
                          color: viewModel.passwordFocusNode.hasFocus
                              ? Constants.secondaryColor
                              : Colors.black54,),
                        onPressed: ()=>viewModel.controlSeePassword(),
                      ),
                      contentPadding: EdgeInsets.all(20),
                    ),
                    validator: (value){
                      if(value!.isEmpty ){
                        return 'Password Required';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                InkWell(
                  onTap: () {

               if(viewModel.formKey.currentState!.validate()){
                 viewModel.getData(viewModel.nameController.text,viewModel.passwordController.text).then((value) {
                   if(value){
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Home()));
                   }
                 });

               }
                  },
                  child: Container(
                    height:size.height>500? size.height * 0.07:size.width * 0.07,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                        color: Color(0xfffafafa),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: Constants.secondaryColor, width: 1.2)),
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Constants.secondaryColor,
                            fontSize:size.height>500? size.height * 0.02:size.width * 0.02),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: size.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
