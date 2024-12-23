import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/pages/report_page/cubit/categories_cubit.dart';
import 'package:kitty/pages/report_page/widgets/details_item_tile.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, Map<String, Map<String, dynamic>>>(
      builder: (context, summary) {
        if (summary.isEmpty) {
          return const Center(child: Text('No data.'));
        }

        return Expanded(
          child: ListView.builder(
            itemCount: summary.length,
            itemBuilder: (context, index) {
              final category = summary.keys.elementAt(index);
              final data = summary[category]!;

              return DetailsItemTile(
                backgroundColor: data['backgroundColor'],
                categoryName: category,
                percent: data['percentage'],
                totalSum: data['Total'],
                transactionCount: data['count'].toString(),
                iconPath: data['iconPath'],
              );
            },
          ),
        );
      },
    );
  }
}
