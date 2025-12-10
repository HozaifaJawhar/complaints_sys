import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:complaints_sys/core/constants/app_routes.dart';
import 'package:complaints_sys/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:complaints_sys/features/complaints/presentation/provider/get_complaints_provider.dart';
import 'package:complaints_sys/features/complaints/presentation/widgets/filtter_wedget.dart';
import 'package:complaints_sys/features/complaints/presentation/widgets/complaints_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _searchController;
  DateTime? _lastLoadTime;
String? selectedFilter;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    // Load complaints when screen is first created
    _loadComplaints();
  }

  // Removed didChangeDependencies to prevent infinite loop of reloading and resetting search query
  // when the provider notifies listeners. The provider state is preserved, and RefreshIndicator is available.

  void _loadComplaints() {
    final now = DateTime.now();
    // Prevent reloading if we just loaded less than 500ms ago
    if (_lastLoadTime != null &&
        now.difference(_lastLoadTime!).inMilliseconds < 500) {
      return;
    }
    _lastLoadTime = now;
    Future.microtask(() {
      if (mounted) {
        context.read<ComplaintsProvider>().loadComplaints();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final complaintsProvider = context.watch<ComplaintsProvider>();

    return GestureDetector(
 

      onTap: () {
           FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        //  backgroundColor: AppColors.fillColor.withOpacity(0.5),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(
                  size: 40,
                  Icons.circle_notifications_sharp,
                  color: AppColors.primary500,
                ),
                onPressed: () {
                  context.push(AppRoutes.notificationsScreen);
                },
              ),
            ),
          ],
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
                    child: CustomTextField(
                      controller: _searchController,
                      hintText: 'أدخل الرقم المرجعي للشكوى',
                      prefixIcon: Icons.search,
                      onChanged: (value) {
                        complaintsProvider.updateSearchQuery(value);
                      },
                    ),
                  ),
                  FiltterWedget(
              onFilterSelected: (status) {
  String? apiStatus = (status == "الكل" || status == null) ? null : status;

  setState(() {
    selectedFilter = apiStatus;
  });

  complaintsProvider.loadComplaints(status: apiStatus);
},
                  ),
                ],
              ),
            ),
      
            // Title
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 20),
       child: Text(
    selectedFilter == null || selectedFilter == ""
        ? 'الشكاوي (الكل)'
        : 'الشكاوي (${selectedFilter!})',
    style: Theme.of(context).textTheme.labelLarge,
  ),
            ),
      
            // MAIN CONTENT
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: ComplaintsListWidget(
                  provider: complaintsProvider,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
