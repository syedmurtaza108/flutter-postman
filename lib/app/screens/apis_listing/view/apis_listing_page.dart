import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_postman/app/screens/apis_listing/apis_listing.dart';

class ApisListing extends StatefulWidget {
  const ApisListing({super.key});

  @override
  State<ApisListing> createState() => _ApisListingState();
}

class _ApisListingState extends State<ApisListing> {
  late final cubit = context.read<ApisListingCubit>();
  @override
  void initState() {
    super.initState();
    cubit.load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApisListingCubit, ApisListingState>(
      builder: (context, state) {
        if (state is ApisListingLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ApisListingError) {
          return const Center(child: Text("DAta error"));
        }
        final items = (state as ApisListingData).items;
        return DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          columns: const [
            DataColumn2(
              label: Text('Column A'),
              size: ColumnSize.L,
            ),
            DataColumn(
              label: Text('Column B'),
            ),
            DataColumn(
              label: Text('Column C'),
            ),
            DataColumn(
              label: Text('Column D'),
            ),
            DataColumn(
              label: Text('Column NUMBERS'),
              numeric: true,
            ),
          ],
          rows: List<DataRow>.generate(
            items.length,
            (index) => DataRow(
              cells: [
                DataCell(Text('A' * (10 - index % 10))),
                DataCell(Text('B' * (10 - (index + 5) % 10))),
                DataCell(Text('C' * (15 - (index + 5) % 10))),
                DataCell(Text('D' * (15 - (index + 10) % 10))),
                DataCell(Text(((index + 0.1) * 25.4).toString()))
              ],
            ),
          ),
        );
      },
    );
  }
}
