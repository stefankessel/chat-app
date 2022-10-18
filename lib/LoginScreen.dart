import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  final Uri _url = Uri.parse('https://flutter.dev');

  login(BuildContext context) {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      print(_usernameController.text);
      print(_passwordController.text);

      Navigator.of(context).pushReplacementNamed('/ChatScreen',
          arguments: _usernameController.text);
    } else {
      print('Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                "Let's log in in \nWelcome back!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            ),
            Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 10,
              child: Container(
                height: 200,
                //width: 200,
                //padding: const EdgeInsets.all(10),
                //margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/chat.png')),
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value != null &&
                          value.isNotEmpty &&
                          value.length < 5) {
                        return "Username must have at least 5 Characters";
                      } else if (value != null && value.isEmpty) {
                        return "Username required";
                      }
                      return null;
                    },
                    controller: _usernameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter your Username",
                        hintStyle: TextStyle(color: Colors.blueGrey)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter your Password",
                        hintStyle: TextStyle(color: Colors.blueGrey)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () => login(context),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 25),
                  ),
                )),
            GestureDetector(
              onTap: () async {
                if (!await launchUrl(_url)) {
                  throw 'Could not launch $_url';
                }
              },
              child: Column(
                children: const [
                  Text('Visit us at'),
                  Text('website'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
