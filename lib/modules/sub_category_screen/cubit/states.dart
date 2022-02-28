abstract class SubCatStates {}

class SubCatInitialState extends SubCatStates {}

class PickedImageSuccessState extends SubCatStates {}
class PickedImageErrorState extends SubCatStates {
  final String error;

  PickedImageErrorState(this.error);
}
class SaveImageToDbSuccessState extends SubCatStates {}
class SaveImageToDbErrorState extends SubCatStates {
  final String error;

  SaveImageToDbErrorState(this.error);
}
class ClearSuccessState extends SubCatStates {}
class OnCategoryNameChangeSuccessStte extends SubCatStates {}

class CategorySelectedState extends SubCatStates {}
class ShowAllCategoryState extends SubCatStates {}