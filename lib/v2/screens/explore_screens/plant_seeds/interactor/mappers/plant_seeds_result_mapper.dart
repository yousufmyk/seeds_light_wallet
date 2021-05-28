import 'package:seeds/v2/domain-shared/page_state.dart';
import 'package:seeds/v2/domain-shared/result_to_state_mapper.dart';
import 'package:seeds/v2/screens/explore_screens/plant_seeds/interactor/viewmodels/plant_seeds_state.dart';

class PlantSeedsResultMapper extends StateMapper {
  PlantSeedsState mapResultToState(PlantSeedsState currentState, Result result) {
    if (result.isError) {
      // Transaction fail show snackbar fail
      print('Error transaction hash not retrieved');
      return currentState.copyWith(
        pageState: PageState.success,
        pageCommand: ShowTransactionFailSnackBar(),
        isPlantSeedsButtonEnabled: false,
      );
    } else {
      // Transaction success show plant seeds success dialog
      return currentState.copyWith(pageState: PageState.success, pageCommand: ShowPlantSeedsSuccessDialog());
    }
  }
}