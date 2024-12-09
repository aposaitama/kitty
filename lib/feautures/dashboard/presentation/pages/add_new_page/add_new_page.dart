// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
// import 'package:kitty/core/route/app_navigation.dart';
// import 'package:kitty/feautures/dashboard/presentation/styles/colors.dart';
// import 'package:kitty/feautures/dashboard/presentation/widgets/drop_down_list_item.dart';

// class AddNewPage extends StatefulWidget {
//   const AddNewPage({super.key});

//   @override
//   State<AddNewPage> createState() => _AddNewPageState();
// }

// class _AddNewPageState extends State<AddNewPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             height: 72.0,
//             color: AppColors.lightGreyHeaderColor,
//             child: Column(
//               children: [
//                 const SizedBox(
//                   height: 38.0,
//                 ),
//                 Row(
//                   children: [
//                     const SizedBox(
//                       width: 16.0,
//                     ),
//                     GestureDetector(
//                         onTap: () => context.go('/home'),
//                         child: SvgPicture.asset(
//                             'assets/icons/arrow_back_black_24dp.svg')),
//                     const SizedBox(
//                       width: 16.0,
//                     ),
//                     const Text(
//                       'Add new',
//                       style: TextStyle(
//                         fontFamily: 'Inter',
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               children: [
//                 const DropDownListItem(
//                   text: 'Дополнительные услуги',
//                   items: ['Выкуп', 'Осмотр', 'Фото-отчет'],
//                 ),
//                 const TextField(
//                   decoration: InputDecoration(fillColor: Colors.grey),
//                 ),
//                 GestureDetector(
//                   onTap: () {},
//                   child: Container(
//                     width: 50,
//                     height: 50,
//                     child: const Center(
//                       child: Text('send'),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kitty/feautures/dashboard/domain/entity/expense.dart';
import 'package:kitty/feautures/dashboard/presentation/cubit/add_expenses/expense_cubit.dart';

class AddNewExpenseScreen extends StatelessWidget {
  const AddNewExpenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Expense')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final expenseCubit = context.read<ExpenseCubit>();
            expenseCubit.addExpense(
              Expense(
                  title: 'New Expense', amount: '100', date: DateTime.now()),
            );
            context.go('/home');
          },
          child: const Text('Add Expense'),
        ),
      ),
    );
  }
}
