import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:complaints_sys/features/complaints/domain/entities/complaint.dart';
import 'package:complaints_sys/features/complaints/presentation/provider/add_complaint_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
//import 'package:url_launcher/url_launcher.dart';

class ComplaintDetailsScreen extends StatelessWidget {
  const ComplaintDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    @override
    final Complaint complaint = GoRouterState.of(context).extra as Complaint;

    final dropdownProvider = context.read<AddComplaintProvider>();

    // Prefer names returned from backend; fall back to local lookup by id.
    final entityName = complaint.governmentEntityName ??
        dropdownProvider.governmentEntities
            .firstWhere(
              (e) => e.id == complaint.governmentEntityId,
              orElse: () => dropdownProvider.governmentEntities.first,
            )
            .name;

    final typeName = complaint.complaintTypeName ??
        dropdownProvider.complaintTypes
            .firstWhere(
              (e) => e.id == complaint.complaintTypeId,
              orElse: () => dropdownProvider.complaintTypes.first,
            )
            .name;

// if (dropdownProvider.dataLoadingState != DataLoadingState.loaded) {
//   return Scaffold(
//     appBar: AppBar(title: const Text("تفاصيل الشكوى")),
//     body: const Center(child: CircularProgressIndicator()),
//   );
// }
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "تفاصيل الشكوى",
          style: TextStyle(color: AppColors.primary500),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: AppColors.primary500),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ================= HEADER BOX =================
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.primary500.withOpacity(0.9),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "رقم الشكوى",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    complaint.referenceNumber,
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      Icon(Icons.info, color: getStatusColor(complaint.state)),
                      SizedBox(width: 8.w),
                      Text(
                        complaint.state,
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: getStatusColor(complaint.state),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // =================== DATE ===================
            _buildSection(
              title: "تاريخ الإنشاء",
              icon: Icons.calendar_today,
              value:
                  "${complaint.createdAt.year}/${complaint.createdAt.month}/${complaint.createdAt.day}",
            ),

            // =================== نوع الشكوى ===================
            _buildSection(
              title: "نوع الشكوى",
              icon: Icons.category,
              value: typeName,
            ),
            // =================== الجهة الحكومية ===================
            _buildSection(
              title: "الجهة الحكومية",
              icon: Icons.account_balance,
              value: entityName,
            ),

            // =================== الموقع ===================
            _buildSection(
              title: "الموقع",
              icon: Icons.location_on,
              value: complaint.locationDescription,
            ),

            // =================== وصف المشكلة ===================
            _buildSection(
              title: "وصف المشكلة",
              icon: Icons.description,
              value: complaint.problemDescription,
            ),

            SizedBox(height: 20.h),

            // =================== المرفقات ===================
            _buildAttachmentsSection(context, complaint),
          ],
        ),
      ),
    );
  }

  // =================== SECTION CARD UI ===================
  Widget _buildSection({
    required String title,
    required IconData icon,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary500, size: 26),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary500,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  value,
                  style: TextStyle(fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =================== ATTACHMENTS ===================
  Widget _buildAttachmentsSection(BuildContext context, Complaint complaint) {
    final attachments = complaint.attachments ?? [];

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "المرفقات",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primary500,
            ),
          ),
          SizedBox(height: 10.h),
          if (attachments.isEmpty)
            Text("لا يوجد مرفقات", style: TextStyle(fontSize: 14.sp))
          else
            ...attachments.map(
              (file) => _buildAttachmentCard(context, file),
            ),
        ],
      ),
    );
  }

  // =================== ATTACHMENT CARD ===================
  Widget _buildAttachmentCard(BuildContext context, String file) {
    final fullUrl = file.startsWith("http")
        ? file
        : "http://10.0.2.2:8000/$file"; // عدلي حسب سيرفرك

    final isImage = file.endsWith(".jpg") ||
        file.endsWith(".png") ||
        file.endsWith(".jpeg");

    final isPdf = file.endsWith(".pdf");
    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.grey.shade100,
      ),
      child: Row(
        children: [
          // Thumbnail
          if (isImage)
            GestureDetector(
              onTap: () => showFullImage(context, fullUrl),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  fullUrl,
                  width: 60.w,
                  height: 60.w,
                  fit: BoxFit.cover,
                ),
              ),
            )
          else if (isPdf)
            const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40)
          else
            const Icon(Icons.insert_drive_file, color: Colors.grey, size: 40),

          SizedBox(width: 12.w),

          Expanded(
            child: Text(
              file.split("/").last,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // IconButton(
          //   icon: const Icon(Icons.open_in_new, color: AppColors.primary500),
          //   onPressed: () {
          //     if (isPdf) {
          //       openPdf(fullUrl);
          //     } else if (isImage) {
          //       showFullImage(context, fullUrl);
          //     } else {
          //       openPdf(fullUrl);
          //     }
          //   },
          // ),
        ],
      ),
    );
  }
}

// =================== FULLSCREEN IMAGE ===================
void showFullImage(BuildContext context, String imageUrl) {
  showDialog(
    context: context,
    builder: (_) {
      return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          color: Colors.black,
          child: InteractiveViewer(
            child: Center(child: Image.network(imageUrl)),
          ),
        ),
      );
    },
  );
}

// =================== OPEN PDF ===================
// void openPdf(String url) async {
//   final uri = Uri.parse(url);
//   if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
//     throw "لا يمكن فتح الملف";
//   }
// }

// =================== STATUS COLOR ===================
Color getStatusColor(String status) {
  switch (status.trim()) {
    case "انتظار":
      return Colors.orange;
    case "قيد المعالجة":
      return Colors.blue;
    case "مكتملة":
    case "منجزة":
      return Colors.green;
    case "مرفوضة":
      return Colors.red;
    default:
      return Colors.white;
  }
}
