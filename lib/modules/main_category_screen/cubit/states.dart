abstract class MainCatStates {}

class MainCatInitialState extends MainCatStates {}

class PickedImageSuccessState extends MainCatStates {}

class PickedImageErrorState extends MainCatStates {
  final String error;

  PickedImageErrorState(this.error);
}

class SaveImageToDbSuccessState extends MainCatStates {}

class SaveImageToDbErrorState extends MainCatStates {
  final String error;

  SaveImageToDbErrorState(this.error);
}

class ClearSuccessState extends MainCatStates {}

class OnCategoryNameChangeSuccessStte extends MainCatStates {}

class CategorySelectedState extends MainCatStates {}

  class ShowAllCategoryState extends MainCatStates {}

class GetSubCategoryListState extends MainCatStates {}
