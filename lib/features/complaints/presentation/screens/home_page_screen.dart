import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:complaints_sys/core/constants/app_routes.dart';
import 'package:complaints_sys/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:complaints_sys/features/complaints/presentation/provider/get_complaints_provider.dart';
import 'package:complaints_sys/features/complaints/presentation/widgets/filtter_wedget.dart';
import 'package:complaints_sys/features/complaints/presentation/widgets/complaints_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ComplaintsProvider>().loadComplaints();
    });
  }

  @override
  Widget build(BuildContext context) {
    final complaintsProvider = context.watch<ComplaintsProvider>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: IconButton(
        //       icon: const Icon(
        //         size: 40,
        //         Icons.circle_notifications_sharp,
        //         color: AppColors.primary500,
        //       ),
        //       onPressed: () {
        //         context.push(AppRoutes.notificationScreen);
        //       },
        //     ),
        //   ),
        // ],
        title: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'مرحباً',
            style: TextStyle(color: AppColors.primary500),
          ),
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Search + Filter Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 300.w,
                  child: const CustomTextField(
                    hintText: 'ابحث هنا',
                    prefixIcon: Icons.search,
                  ),
                ),
                const FiltterWedget(),
              ],
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 20),
            child: Text(
              'الشكاوي',
              style: TextTheme.of(context).labelLarge,
            ),
          ),

          // MAIN CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child:  ComplaintsListWidget(  provider: complaintsProvider,),
            ),
          ),
        ],
      ),
    );
  }
}
 