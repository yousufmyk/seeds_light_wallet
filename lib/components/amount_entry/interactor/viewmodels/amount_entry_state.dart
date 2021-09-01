import 'package:equatable/equatable.dart';
import 'package:seeds/blocs/rates/viewmodels/rates_state.dart';
import 'package:seeds/datasource/local/models/fiat_data_model.dart';
import 'package:seeds/datasource/local/models/token_data_model.dart';
import 'package:seeds/datasource/local/settings_storage.dart';
import 'package:seeds/domain-shared/page_command.dart';
import 'package:seeds/utils/rate_states_extensions.dart';

enum CurrencyInput { fiat, token }

class AmountEntryState extends Equatable {
  final CurrencyInput currentCurrencyInput;
  final RatesState ratesState;
  final PageCommand? pageCommand;
  final String enteringCurrencyName;
  final TokenDataModel tokenAmount;
  final FiatDataModel? fiatAmount;
  final String textInput;

  bool get switchCurrencyEnabled => fiatAmount != null;

  const AmountEntryState({
    required this.currentCurrencyInput,
    required this.ratesState,
    required this.enteringCurrencyName,
    required this.tokenAmount,
    this.pageCommand,
    required this.fiatAmount,
    required this.textInput,
  });

  @override
  List<Object?> get props => [
        currentCurrencyInput,
        ratesState,
        tokenAmount,
        pageCommand,
        fiatAmount,
        textInput,
        enteringCurrencyName,
      ];

  AmountEntryState copyWith({
    CurrencyInput? currentCurrencyInput,
    RatesState? ratesState,
    String? enteringCurrencyName,
    TokenDataModel? tokenAmount,
    PageCommand? pageCommand,
    FiatDataModel? fiatAmount,
    String? textInput,
  }) {
    return AmountEntryState(
      currentCurrencyInput: currentCurrencyInput ?? this.currentCurrencyInput,
      ratesState: ratesState ?? this.ratesState,
      tokenAmount: tokenAmount ?? this.tokenAmount,
      enteringCurrencyName: enteringCurrencyName ?? this.enteringCurrencyName,
      pageCommand: pageCommand,
      fiatAmount: fiatAmount ?? this.fiatAmount,
      textInput: textInput ?? this.textInput,
    );
  }

  factory AmountEntryState.initial(RatesState ratesState) {
    final tokenData = TokenDataModel(0, token: settingsStorage.selectedToken);
    final fiatData = ratesState.tokenToFiat(tokenData, settingsStorage.selectedFiatCurrency);
    return AmountEntryState(
        currentCurrencyInput: CurrencyInput.token,
        ratesState: ratesState,
        enteringCurrencyName: settingsStorage.selectedToken.symbol,
        tokenAmount: tokenData,
        fiatAmount: fiatData,
        textInput: "0");
  }
}