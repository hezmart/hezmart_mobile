part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryloadinggState extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryfailiureState extends CategoryState {
  String error;


  CategoryfailiureState(this.error);

  @override
  List<Object> get props => [error];
}

class CategorySuccessState extends CategoryState {
  AllCategoryResponse response;

  CategorySuccessState(this.response);

  @override
  List<Object> get props => [response];
}
class SubCategorySuccessState extends CategoryState {
  SubCategoryItemsResponse response;

  SubCategorySuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class SimilarproductSuccess extends CategoryState {
  SimilarProductResponse response;

  SimilarproductSuccess(this.response);

  @override
  List<Object> get props => [response];
}
