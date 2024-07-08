import 'package:flutter/material.dart';
import 'package:flutter_auth_form/forms/form_item.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  AuthFormState createState() => AuthFormState();
}

class AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isSubmitted = false;

  void _submit() {
    setState(() {
      _isSubmitted = true;
    });
    if (_formKey.currentState!.validate()) {
      print('Form is VALID');
    } else {
      print('Form is INVALID');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            child: Text(
              'Sign in',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FormItem(
                  name: "Email",
                  isSubmitted: _isSubmitted,
                  rules: [
                    Rule(
                      valid: (value) => value.isNotEmpty,
                      message: 'Email is required',
                    ),
                    Rule(
                      valid: (value) =>
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value),
                      message: 'Invalid email',
                    ),
                  ],
                  child: TextFormField(),
                ),
                const SizedBox(height: 16.0),
                FormItem(
                  name: "Password",
                  isSubmitted: _isSubmitted,
                  showRules: true,
                  rules: [
                    Rule(
                      valid: (value) =>
                          value.length >= 8 && !value.contains(' '),
                      message: '8 character or more (no spaces)',
                    ),
                    Rule(
                      valid: (value) =>
                          RegExp(r'[A-Z]').hasMatch(value) &&
                          RegExp(r'[a-z]').hasMatch(value),
                      message: 'Uppercase and lowercase letters',
                    ),
                    Rule(
                      valid: (value) => RegExp(r'\d').hasMatch(value),
                      message: 'At least one digit',
                    ),
                  ],
                  child: TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                ),
                const SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                              Color(0xFF70c3ff),
                              Color(0xFF4d68ff)
                            ])),
                      )),
                      TextButton(
                          onPressed: _submit,
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 64)),
                          child: const Text('Sign in',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)))
                    ],
                  ),
                )
                // ElevatedButton(
                //   onPressed: _submit,
                //   style: ElevatedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: 32, vertical: 14),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(9999),
                //     ),
                //     textStyle: const TextStyle(
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold,
                //     ),
                //     backgroundBuilder: LinearGradient(
                //       begin: Alignment.topLeft,
                //       end: Alignment.bottomRight,
                //       colors: [
                //         const Color(0xFF70C3FF),
                //         const Color(0xFF4D68FF),
                //       ],
                //     ),
                //   ),
                //   child: const Text(
                //     'Submit',
                //     style: TextStyle(color: Colors.white),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
