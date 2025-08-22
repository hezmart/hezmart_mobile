part of 'all_sub_cat_bloc.dart';

abstract class AllSubCatEvent extends Equatable {
  const AllSubCatEvent();
}


class GetAllSubCatEvent extends AllSubCatEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class SearchProductEvent extends AllSubCatEvent {
  String query;

  SearchProductEvent(this.query);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
