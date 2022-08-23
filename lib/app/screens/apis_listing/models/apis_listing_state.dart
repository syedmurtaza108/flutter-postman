import 'package:flutter_postman/app/screens/apis_listing/apis_listing.dart';

abstract class ApisListingState {}

class ApisListingLoading extends ApisListingState {}

class ApisListingError extends ApisListingState {}

class ApisListingData extends ApisListingState {
  ApisListingData(this.items);
  final List<ApiListItem> items;
}
