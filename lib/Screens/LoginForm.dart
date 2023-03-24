import 'package:flutter/material.dart';
import 'package:kellyex2/Comm/genLoginSignupHeader.dart';
import 'package:kellyex2/Comm/genTextFormField.dart';

import '../Comm/comHelper.dart';
import '../DatabaseHandler/DbHelper.dart';
import 'HomeForm.dart';
import 'SignupForm.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = new GlobalKey<FormState>();
  final _conUserId = TextEditingController();
  final _conPassword = TextEditingController();
  var dbHelper;

  @override
  void initState(){
    super.initState();
    dbHelper = DbHelper();
  }

  Login() async {
    String uid = _conUserId.text;
    String passwd = _conPassword.text;

    if (uid.isEmpty){
      alertDialog(context, "Please Enter User Id");
    }else if(passwd.isEmpty){
      alertDialog(context, "Please Enter Password");
    }else{
      await dbHelper.getLoginUser(uid,passwd).then((userData){
        if(userData != null) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => HomeForm()),
                  (Route<dynamic> route) => false);
        }else{
          alertDialog(context, "Error: User not Found");
        }
        
      }).catchError((error){
        print(error);
        alertDialog(context, "Error: Login Fail");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Signup'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                genLoginSignupHeader('Login'),
                getTextFormField(controller: _conUserId,
                  icon: Icons.person,
                  hintName: 'User Id', ),
                SizedBox(height: 5),
                getTextFormField(controller: _conPassword,
                  icon: Icons.lock,
                  hintName: 'Password',
                isObscueText: true,),

                Container(
                  margin: EdgeInsets.all(12),
                  width: 265,
                  child: ElevatedButton(
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: Login,
                  ),
                   decoration: BoxDecoration(
                     color: Colors.teal,
                     borderRadius: BorderRadius.circular(10)
                   ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Does not have account?'),
                  ElevatedButton(
                  child: Text(
                  'SignUp',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignupForm()));
                  },
                ),



                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}
