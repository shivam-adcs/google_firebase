import 'package:flutter/material.dart';
import 'package:login_google/google_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_google/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    debugShowCheckedModeBanner: false,
    );
    
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 ValueNotifier user=ValueNotifier('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: () async {
              user.value=await GoogleService().signInWithGoogle();
                print(user.value.user);
              if(user!=null){
                // final user_email=await user.value.user!.email;
                // final user_data=await GoogleService().getUserInformation(email:user_email);
                // print("THis is the userData ${user_data}");

                final is_save_user_data=await GoogleService().setUserInformation(name: user.value.user!.displayName, email: user.value.user!.email, phone_number: user.value.user!.phoneNumber??"0", photo_URL: user.value.user!.photoURL);
                if(is_save_user_data){
                  final user_data_home=(name: user.value.user!.displayName, email: user.value.user!.email, phone_number: user.value.user!.phoneNumber??"0", photo_URL: user.value.user!.photoURL);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>Home(user_data:user_data_home)));
                }
              }
            }, child: Text("Google Sign-In")),

            ElevatedButton(onPressed: () async {
              user.value=await GoogleService().signOutGoogle();
              if(user!=null){
                print("\n\n\nUser sign out successfully\n\n\n");
              }
            }, child: Text("Google Sign-Out"))
          ],
        ),
      );
  }
}
