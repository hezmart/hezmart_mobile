part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}


class AllCategoryEvent extends CategoryEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SubCategoryEvent extends CategoryEvent {
  String catId;
  String subcatId;


  SubCategoryEvent(this.catId, this.subcatId);

  @override
  // TODO: implement props
  List<Object?> get props => [catId,subcatId];
}
class GetSimilarProductEvent extends CategoryEvent {
  String catId;
  GetSimilarProductEvent(this.catId, );
  @override
  // TODO: implement props
  List<Object?> get props => [catId];
}
