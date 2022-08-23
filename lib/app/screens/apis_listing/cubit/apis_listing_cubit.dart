import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/apis_listing/apis_listing.dart';

class ApisListingCubit extends Cubit<ApisListingState> {
  ApisListingCubit() : super(ApisListingLoading());

  Future<void> load() async {
    final list = <ApiListItem>[];
    final ref = FirebaseFirestore.instance.collection('apis').withConverter(
          fromFirestore: ApiListItem.fromFirestore,
          toFirestore: (_, __) => {},
        );
    final docSnap = await ref.get();
    for (final doc in docSnap.docs) {
      final item = doc.data();
      list.add(item);
    }

    emit(ApisListingData(list));
  }
}
