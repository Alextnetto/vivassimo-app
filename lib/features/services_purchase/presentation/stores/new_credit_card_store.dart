import 'package:mobx/mobx.dart';
import 'package:my_app/core/utils/enums/credit_card_enum.dart';
import 'package:my_app/core/utils/patterns/app_patterns.dart';
part 'new_credit_card_store.g.dart';

class NewCreditCardStore = _NewCreditCardStoreBase with _$NewCreditCardStore;

abstract class _NewCreditCardStoreBase with Store {
  @observable
  CardBrand cardBrand = CardBrand.otherBrand;

  @action
  setCardBrand(CardBrand value) => cardBrand = value;

  @observable
  String number = '';

  @observable
  bool hasChangedNumber = false;

  @action
  setNumber(String value) {
    hasChangedNumber = true;
    detectCreditCardBrand(value);
    return number = value;
  }

  @computed
  String? get getNumberError {
    if (!hasChangedNumber) {
      return null;
    } else if (number.isEmpty) {
      return 'Este campo é obrigatório';
    } else if (number.length < 16) {
      return 'Número inválido';
    }

    return null;
  }

  @observable
  String name = '';

  @observable
  bool hasChangedName = false;

  @action
  setName(String value) {
    hasChangedName = true;
    return name = value;
  }

  @computed
  String? get getNameError {
    if (!hasChangedName) {
      return null;
    } else if (name.isEmpty) {
      return 'Este campo é obrigatório';
    } else if (name.length < 5) {
      return 'Nome inválido';
    }

    return null;
  }

  @observable
  String expireDate = '';

  @observable
  bool hasChangedExpireDate = false;

  @action
  setExpireDate(String value) {
    hasChangedExpireDate = true;
    return expireDate = value;
  }

  @computed
  String? get getExpireDateError {
    if (!hasChangedExpireDate) {
      return null;
    } else if (expireDate.isEmpty) {
      return 'Este campo é obrigatório';
    } else if (expireDate.length < 6) {
      return 'Nome inválido';
    }

    return null;
  }

  @computed
  bool get enableButton =>
      getNumberError == null &&
      getNameError == null &&
      getExpireDateError == null &&
      hasChangedNumber &&
      hasChangedName &&
      hasChangedExpireDate;

  detectCreditCardBrand(String cardNumber) {
    //Default card type is other
    CardBrand cardType = CardBrand.otherBrand;

    if (cardNumber.isEmpty) {
      setCardBrand(cardType);
      return;
    }

    AppPatterns.cardNumPatterns.forEach(
      (CardBrand type, Set<List<String>> patterns) {
        for (List<String> patternRange in patterns) {
          // Remove any spaces
          String ccPatternStr = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
          final int rangeLen = patternRange[0].length;
          // Trim the Credit Card number string to match the pattern prefix length
          if (rangeLen < cardNumber.length) {
            ccPatternStr = ccPatternStr.substring(0, rangeLen);
          }

          if (patternRange.length > 1) {
            // Convert the prefix range into numbers then make sure the
            // Credit Card num is in the pattern range.
            // Because Strings don't have '>=' type operators
            final int ccPrefixAsInt = int.parse(ccPatternStr);
            final int startPatternPrefixAsInt = int.parse(patternRange[0]);
            final int endPatternPrefixAsInt = int.parse(patternRange[1]);
            if (ccPrefixAsInt >= startPatternPrefixAsInt && ccPrefixAsInt <= endPatternPrefixAsInt) {
              // Found a match
              cardType = type;
              break;
            }
          } else {
            // Just compare the single pattern prefix with the Credit Card prefix
            if (ccPatternStr == patternRange[0]) {
              // Found a match
              cardType = type;
              break;
            }
          }
        }
      },
    );

    setCardBrand(cardType);
  }
}
