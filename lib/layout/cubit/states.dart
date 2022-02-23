abstract class AppStates {}

class AppInitialState extends AppStates {}

class ScreenSelectorState extends AppStates {}

class PickedImageSuccessState extends AppStates {}
class PickedImageErrorState extends AppStates {
  final String error;

  PickedImageErrorState(this.error);
}
class SaveImageToDbSuccessState extends AppStates {}
class SaveImageToDbErrorState extends AppStates {
  final String error;

  SaveImageToDbErrorState(this.error);
}
class ClearSuccessState extends AppStates {}
