part of 'all_sub_cat_bloc.dart';

abstract class AllSubCatState extends Equatable {
  const AllSubCatState();
}

 class AllSubCatInitial extends AllSubCatState {
  @override
  List<Object> get props => [];
}
 class AllSubCatloadingState extends AllSubCatState {
  @override
  List<Object> get props => [];
}
class AllSubCatfailuireState extends AllSubCatState {
  String error;
  AllSubCatfailuireState(this.error);
  @override
  List<Object> get props => [];
}
class AllSubCatSuccessState extends AllSubCatState {
  AllSubCategoryResspomse respomse;
  AllSubCatSuccessState(this.respomse);
  @override
  List<Object> get props => [];
}
class SearchSuccessState extends AllSubCatState {
  SearchResponse respomse;
  SearchSuccessState(this.respomse);
  @override
  List<Object> get props => [];
}
