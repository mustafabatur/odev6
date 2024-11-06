import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kullanıcı Formu'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: UserForm(),
        ),
      ),
    );
  }
}

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final GlobalKey<FormState> _userFormKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();

  // Gelişmiş e-posta doğrulaması için regex
  String emailPattern =
      r'^[a-zA-Z0-9._%+-]+(?:[.-][a-zA-Z0-9]+)*@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _userFormKey,
      child: Column(
        children: [
          // İsim Alanı
          TextFormField(
            controller: _fullNameController,
            decoration: InputDecoration(
              labelText: 'İsim',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'İsim boş olamaz';
              }
              return null;
            },
          ),

          // E-posta Alanı
          TextFormField(
            controller: _userEmailController,
            decoration: InputDecoration(
              labelText: 'E-posta',
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'E-posta boş olamaz';
              }
              // Gelişmiş Regex ile format kontrolü
              RegExp regExp = RegExp(emailPattern);
              if (!regExp.hasMatch(value)) {
                return 'Geçerli bir e-posta adresi girin';
              }
              return null;
            },
          ),

          // Şifre Alanı
          TextFormField(
            controller: _userPasswordController,
            decoration: InputDecoration(
              labelText: 'Şifre',
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Şifre boş olamaz';
              }
              if (value.length < 6) {
                return 'Şifre en az 6 karakter olmalı';
              }
              return null;
            },
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_userFormKey.currentState!.validate()) {
                  // Formun doğru şekilde gönderildiğini belirten mesaj
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Form başarıyla gönderildi!')),
                  );
                }
              },
              child: Text('Gönder'),
            ),
          ),
        ],
      ),
    );
  }
}
