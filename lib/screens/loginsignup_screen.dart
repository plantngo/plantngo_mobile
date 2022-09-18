import 'package:flutter/material.dart';


class LoginSignUpScreen extends StatelessWidget {
  const LoginSignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
               colorSchemeSeed: const Color(0xff00aa58), useMaterial3: true,),
      title: 'Button Types',
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage('assets/icon/Plant&Go.png')),
            LoginSignUpButtons(),
          ],
        ),
      ),
    );
  }
}

class LoginSignUpButtons extends StatelessWidget {
  const LoginSignUpButtons({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(

        children: [
          SizedBox(
            width: 300,
            child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                    onPressed: () {},
                    child: const Text('Sign Up'),
                  ),
          ),
          SizedBox(
            width: 300,
            child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      side: BorderSide(color: Theme.of(context).colorScheme.primary)
                    ),
                    onPressed: () {},
                    child: const Text('Log In'),
                  ),
          ),
        ],
      ),
            
    );
  }
}

