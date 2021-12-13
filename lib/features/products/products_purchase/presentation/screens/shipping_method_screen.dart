import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_app/core/ui/app_style.dart';
import 'package:my_app/core/ui/component_styles/text_style.dart';
import 'package:my_app/core/ui/components/linear_progress_bar.dart';
import 'package:my_app/core/ui/components/shipping_method_card.dart';
import 'package:my_app/core/ui/widgets/app_bar_default.dart';
import 'package:my_app/core/ui/widgets/button_confirm.dart';

class ShippingMethodScreen extends StatefulWidget {
  const ShippingMethodScreen({Key? key}) : super(key: key);

  @override
  _ShippingMethodScreenState createState() => _ShippingMethodScreenState();
}

class _ShippingMethodScreenState extends State<ShippingMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 131,
            padding: const EdgeInsets.only(top: 25),
            decoration: BoxDecoration(color: Color.fromRGBO(180, 216, 216, 0.2)),
            child: Column(
              children: const [
                AppBarDefaultWidget(title: 'Endereço de Entrega'),
                SizedBox(
                  height: 10,
                ),
                LinearProgressBar(textIndicator: '2/4', percentageValue: 0.50),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            width: 150,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Selecione a forma de envio',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.defaultTextStyleTitleBig800,
                  ),
                )
              ],
            ),
          ),
          ShippingMethodCard(
            deliveryTime: '2 Dias Úteis',
            iconPath: 'assets/icon/checked_icon_light.png',
            shippingValue: 'Grátis',
            title: 'PAC',
          ),
          SizedBox(height: 35),
          ShippingMethodCard(
            deliveryTime: '1 Dia Útil',
            iconPath: 'assets/icon/unchecked_icon_light.png',
            shippingValue: 'R\$ 14,00',
            title: 'PAC',
          ),
          Container(
            padding: const EdgeInsets.only(left: 30, top: 45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total', style: customTextStyle(FontWeight.w600, 18, Color(0XFF4D0351))),
                Text('R\$ 29,90', style: customTextStyle(FontWeight.w800, 30, Color(0XFF4D0351))),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        // margin: const EdgeInsets.only(top: 66),
        child: Observer(builder: (_) {
          return ButtonConfirm(
            label: 'Continuar',
            primary: VivassimoTheme.green,
            onPrimary: VivassimoTheme.white,
            borderColor: VivassimoTheme.greenBorderColor,
            onPressed: () {},
          );
        }),
      ),
    );
  }
}
