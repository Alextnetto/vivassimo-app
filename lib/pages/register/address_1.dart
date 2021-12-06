import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' show Placemark;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:my_app/components/button_back.dart';
import 'package:my_app/components/input_decoration.dart';
import 'package:my_app/components/loading_indicator.dart';
import 'package:my_app/components/text_style.dart';
import 'package:my_app/config/style.dart';
import 'package:location/location.dart';
import 'package:my_app/models/register/user.dart';
import 'package:my_app/services/cep_to_address.dart';
import 'package:my_app/services/location_to_address.dart';

class Address1Page extends StatefulWidget {
  const Address1Page({Key? key}) : super(key: key);

  @override
  _Address1PageState createState() => _Address1PageState();
}

class _Address1PageState extends State<Address1Page> {
  final _formKey = GlobalKey<FormState>();

  getLocation(context) async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Permissão negada pelo usuário'),
            content:
                Text('Agora somente autorizando nas configurações do celular.'),
            contentPadding: EdgeInsets.all(20),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        // if user do not authorize the app, do not continue
        return;
      }
    }

    LoadingIndicator.show(context);

    _locationData = await location.getLocation();
    Placemark address =
        await getAddress(_locationData.latitude, _locationData.longitude);
    dynamic cepAddress =
        await cepToAddress(address.postalCode?.replaceAll('-', ''));
    LoadingIndicator.hide(context);

    if (!cepAddress['valid']) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Localização falhou'),
          content: Text(
              'Não conseguimos o seu CEP através da localização, preencha manualmente'),
          contentPadding: EdgeInsets.all(20),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    var cepAddressData = cepAddress['data'];
    RegisterUser.instance.estado = cepAddressData['uf'];
    RegisterUser.instance.cidade = cepAddressData['localidade'];
    RegisterUser.instance.bairro = cepAddressData['bairro'];
    RegisterUser.instance.cep = cepAddressData['cep'];
    RegisterUser.instance.logradouro = cepAddressData['logradouro'];
    RegisterUser.instance.numero = address.subThoroughfare;

    Navigator.of(context).pushNamed('/register/estado');
  }

  bool _isValidCepAsync = true;

  var cepFormatter = MaskTextInputFormatter(
    mask: '#####-###',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
    initialText: RegisterUser.instance.cep,
  );

  validateCep() async {
    var cepData = await cepToAddress(cepFormatter.getUnmaskedText());
    setState(() {
      if (cepData['valid']) {
        _isValidCepAsync = true;
      } else {
        _isValidCepAsync = false;
      }
    });
    return cepData['data'];
  }

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
                color: VivassimoTheme.white,
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
            Center(
              child: Column(
                children: [
                  Text(
                    'Muito bem!',
                    style: customTextStyle(
                      FontWeight.w800,
                      26,
                      VivassimoTheme.purpleActive,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 324,
                    child: Text(
                      'Para oferecermos os serviços mais próximos de você, precisamos que nos informe seu endereço ou autorizar usarmos sua localização.',
                      style: customTextStyle(
                        FontWeight.w700,
                        18,
                        VivassimoTheme.purpleActive,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 324,
                    height: 60,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await getLocation(context);
                      },
                      icon: Icon(
                        Icons.room,
                        color: VivassimoTheme.purpleActive,
                        size: 32,
                      ),
                      label: Text(
                        'Usar localização',
                        style: customTextStyle(
                          FontWeight.w700,
                          23,
                          VivassimoTheme.purpleActive,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: VivassimoTheme.yellow,
                        side: BorderSide(
                          width: 2.0,
                          color: VivassimoTheme.red,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      'ou',
                      style: customTextStyle(
                        FontWeight.w700,
                        18,
                        VivassimoTheme.purpleActive,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 324,
                    height: 90,
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [cepFormatter],
                        initialValue: cepFormatter.getMaskedText(),
                        validator: (value) {
                          if (cepFormatter.getUnmaskedText().length < 8) {
                            return 'CEP incompleto';
                          }
                          if (!_isValidCepAsync) {
                            return 'CEP inválido';
                          }
                          return null;
                        },
                        decoration: customInputDecoration1('Digite aqui o CEP'),
                        textAlign: TextAlign.center,
                        style: customTextStyle(
                          FontWeight.w700,
                          18,
                          VivassimoTheme.purpleActive,
                        ),
                        onChanged: (value) async {
                          if (cepFormatter.getUnmaskedText().length == 8) {
                            // reset validator
                            _isValidCepAsync = true;

                            if (_formKey.currentState!.validate()) {
                              // validate cep
                              LoadingIndicator.show(context);
                              var cepAddress = await validateCep();
                              LoadingIndicator.hide(context);

                              // Validate again to show "CEP inválido" error if needed
                              if (_formKey.currentState!.validate()) {
                                RegisterUser.instance.cep = cepAddress['cep'];
                                RegisterUser.instance.estado = cepAddress['uf'];
                                RegisterUser.instance.cidade =
                                    cepAddress['localidade'];
                                RegisterUser.instance.bairro =
                                    cepAddress['bairro'];
                                RegisterUser.instance.logradouro =
                                    cepAddress['logradouro'];
                                Navigator.of(context)
                                    .pushNamed('/register/estado');
                              }
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}