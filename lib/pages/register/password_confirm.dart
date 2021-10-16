import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/components/button_back.dart';
import 'package:my_app/components/button_1.dart';
import 'package:my_app/components/input_decoration.dart';
import 'package:my_app/components/text_style.dart';
import 'package:my_app/config/style.dart';
import 'package:my_app/models/register/user.dart';

class PasswordConfirmPage extends StatelessWidget {
  const PasswordConfirmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: VivassimoTheme.white,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Hero(
              tag: 'registerAppBar',
              child: Container(
                height: 130,
                color: VivassimoTheme.blue,
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonBack(),
                        // texto
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: Text(
                            'Criar uma conta',
                            style: customTextStyle(
                              FontWeight.w700,
                              18,
                              VivassimoTheme.purpleActive,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              width: 300,
              child: Text(
                'Digite novamente a senha escolhida',
                style: GoogleFonts.manrope(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 23,
                    color: VivassimoTheme.purpleActive,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            PasswordConfirmationForm(),
          ],
        ),
      ),
    );
  }
}

class PasswordConfirmationForm extends StatefulWidget {
  const PasswordConfirmationForm({Key? key}) : super(key: key);

  @override
  PasswordConfirmationFormState createState() {
    return PasswordConfirmationFormState();
  }
}

class PasswordConfirmationFormState extends State<PasswordConfirmationForm> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            width: 324,
            height: 90,
            child: TextFormField(
              obscureText: !_passwordVisible,
              enableSuggestions: false,
              autocorrect: false,
              onSaved: (value) {
                RegisterUser.instance.password = value;
              },
              validator: (value) {
                if (value != RegisterUser.instance.password) {
                  return 'Senhas não coincidem';
                }
                return null;
              },
              decoration: customInputDecoration1(
                'Digite novamente a senha',
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColorDark,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              textAlign: TextAlign.center,
              style: customTextStyle(
                FontWeight.w700,
                18,
                VivassimoTheme.purpleActive,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: SizedBox(
              width: 324,
              height: 60,
              child: CustomButton1(
                label: 'Continuar',
                primary: VivassimoTheme.green,
                onPrimary: VivassimoTheme.white,
                borderColor: VivassimoTheme.white,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    //Navigator.of(context).pushNamed('/register/passwordConfirmation');
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
