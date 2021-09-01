import 'package:seeds/blocs/rates/viewmodels/rates_state.dart';
import 'package:seeds/datasource/local/settings_storage.dart';
import 'package:seeds/domain-shared/result_to_state_mapper.dart';
import 'package:seeds/screens/explore_screens/plant_seeds/interactor/viewmodels/plant_seeds_state.dart';
import 'package:seeds/utils/rate_states_extensions.dart';
import 'package:seeds/utils/double_extension.dart';

class SeedsAmountChangeMapper extends StateMapper {
  PlantSeedsState mapResultToState(PlantSeedsState currentState, RatesState rateState, String quantity) {
    final double parsedQuantity = double.tryParse(quantity) ?? 0;
    final double currentAvailable = currentState.availableBalance?.amount ?? 0;
    final String selectedFiat = settingsStorage.selectedFiatCurrency;

    return currentState.copyWith(
      fiatAmount: rateState.fromSeedsToFiat(parsedQuantity, selectedFiat).fiatFormatted,
      isPlantSeedsButtonEnabled: parsedQuantity > 0 && parsedQuantity < currentAvailable,
      quantity: parsedQuantity,
      showAlert: parsedQuantity > currentAvailable,
    );
  }
}