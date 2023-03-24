 import 'package:flutter/material.dart';
import 'package:kellyex2/Comm/comHelper.dart';
import 'package:kellyex2/Comm/genLoginSignupHeader.dart';
import 'package:kellyex2/DatabaseHandler/DbHelper.dart';
import 'package:kellyex2/Models/UserModel.dart';
import 'package:kellyex2/Screens/LoginForm.dart';
import 'package:toast/toast.dart';

import '../Comm/genTextFormField.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({Key? key}) : super(key: key);

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  var dbHelper;

  @override
  void initState(){
    super.initState();
    dbHelper = DbHelper();
  }



  SignUp() async {

    String uid = _conUserId.text;
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String cpasswd = _conCPassword.text;

    if (_formKey.currentState!.validate()){
      if (passwd != cpasswd){
        alertDialog(context, 'Password Mismatch');
      }else{
         _formKey.currentState!.save();
         UserModel uModel = UserModel(uid, uname, email, passwd);
        await dbHelper.saveData(uModel).then((userData){
           alertDialog(context, "Successfully Saved");

           Navigator.push(context,
               MaterialPageRoute(builder: (_) => LoginForm()));



         }).catchError((error){
           print(error);
           alertDialog(context, "Error: Data Save Fail");
         });

      }

    }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Signup'),
      ),
      body: Form(
        key : _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  genLoginSignupHeader('Signup'),
                  getTextFormField(controller: _conUserId,
                    icon: Icons.person,
                    hintName: 'User Id', ),
                  SizedBox(height: 5),
                  getTextFormField(controller: _conUserName,
                    icon: Icons.person_outline,
                    inputType: TextInputType.name,
                    hintName: 'User Name', ),
                  SizedBox(height: 5),
                  getTextFormField(controller: _conEmail,
                    icon: Icons.mail,
                    inputType: TextInputType.emailAddress,
                    hintName: 'Email', ),
                  SizedBox(height: 5),
                  getTextFormField(controller: _conPassword,
                    icon: Icons.password,
                    hintName: 'Password',
                    isObscueText: true,),
                  SizedBox(height: 5),
                  getTextFormField(controller: _conCPassword,
                    icon: Icons.lock,
                    hintName: 'Confirm Password',
                    isObscueText: true,),


                  Container(
                    margin: EdgeInsets.all(12),
                    width: 265,
                    child: ElevatedButton(
                      child: Text(
                        'Signup',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: SignUp,
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
                        Text('Does you have account?'),
                        ElevatedButton(
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: (){
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (_) => LoginForm()),
                                (Route<dynamic> route) => false);
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
      ),
    );
  }
}
