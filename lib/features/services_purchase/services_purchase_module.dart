import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_app/features/services_purchase/presentation/stores/payment_method_service_store.dart';
import 'package:my_app/features/services_purchase/presentation/stores/service_select_section_amount_store.dart';

class ServicesPurchaseModule extends Module {
  @override
  List<Bind> get binds {
    return [
      Bind.factory((i) => ServiceSelectSectionAmountStore()),
      Bind.factory((i) => PaymentMethodServiceStore()),
    ];
  }
}
