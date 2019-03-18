import 'package:flutter/material.dart';
import 'fooddetails.dart';
import 'userdatabase.dart';

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body:Body(),
      
    );
  }
}

class Body extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Body> {
  String email;
  String password;  
  final formkey =GlobalKey<FormState>();
 
  bool result = false;

  Future<bool> check() async{
    
    if(formkey.currentState.validate()){
      formkey.currentState.save();
      var db = Dbhelper();
       result= await  db.logincheck(email,password);
      
    }
    return result;

  }
  @override
  Widget build(BuildContext context) {
    return  Form(
        key:formkey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
          children: <Widget>[
            Center(child:Text("Login",style: TextStyle(fontSize: 30,color: Colors.blue,fontFamily: "Times New Roman"))),
            Container(height:30,),
            TextFormField(
            decoration: InputDecoration(labelText: "Email",hintText: "enter Email",border:OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
            validator: (val)=>!(val.contains("@"))?"enter email":null,
            onSaved: (val)=>email=val,
            ),
            Container(height: 20,),
            TextFormField(
                
                decoration: InputDecoration(labelText:"Password",hintText: "Password",border:OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                obscureText: true,
                validator: (val)=>val.length<6?"enter password with 6 char":null,
                onSaved: (val)=>password=val,
            ),
             Container(height:10,),
           
            RaisedButton(
                child:Text("LOGIN",style: TextStyle(color: Colors.white)),
                onPressed: ()async {
                
                  Future<bool> res = check();
                  if(await res){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Foodinfo()));
                  }
                  else{
                    SnackBar snackBar = new SnackBar(content: Text("email or password wrong"),);
                    Scaffold.of(context).showSnackBar(snackBar);
                  }
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                
            )
          ],
        ),
              ),
      );
    
      
    
  }
}