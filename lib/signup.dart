import 'package:flutter/material.dart';
import 'login.dart';
import 'userdatabase.dart';
import 'signupclass.dart';
import 'fooddetails.dart';

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  final formkey =GlobalKey<FormState>();
  final scaffoldkey =GlobalKey<ScaffoldState>();
  String email;
  String mobile;
  String password;

   void submit(){
    if(formkey.currentState.validate())
    {
        var db = Dbhelper();
        formkey.currentState.save();
        var object = Signup(email,mobile,password);
        db.savedetails(object);
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Foodinfo()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(title: Text("SIGN UP"),),
      body: Container(
        child: Form(
          key : formkey,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView(
            children: <Widget>[
              Center(child:Text("SIGN UP",style: TextStyle(fontSize: 30,color: Colors.blue,fontFamily: "Times New Roman"),)),
              Container(height:30,),
              TextFormField(
                
              decoration: InputDecoration(labelText: "Email",hintText: "enter Email",border:OutlineInputBorder(borderRadius: BorderRadius.circular(8)), ),
              validator: (val)=>!(val.contains("@"))?'Enter email':null,
              onSaved: (val)=>email=val,

              ),
               Container(height:10,),
             
              TextFormField(
                  keyboardType:TextInputType.numberWithOptions(),
                  decoration: InputDecoration(labelText:"Mobile no.",hintText: "Mobile no.",border:OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                 validator: (val)=>!(val.length==10)?'enter 10 digit number':null,
                  onSaved: (val)=>mobile=val,

              ),
               Container(height:10,),
              TextFormField(
                  decoration: InputDecoration(labelText: "password",hintText: "password",border:OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                validator: (val)=>val.length<6?'password length should be more than 6':null,
                  onSaved: (val)=>password=val,
                  obscureText:true,

              ),
              
              Container(height:20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      child:Text("SIGNUP",style: TextStyle(color: Colors.white)),
                      onPressed: (){
                        submit();

                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      
                    ),
                    RaisedButton(
                      child:Text("LOGIN",style: TextStyle(color: Colors.white),),
                      onPressed: (){
                       Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Page2()));

                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      
                    ),
                  ],
              )
            ],
          ),
                ),
        ),
      ),
    );
      
    
  }
}