import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' show basename;
import 'package:provider/provider.dart';
import 'package:complaints_sys/core/constants/app_colors.dart';
import 'package:complaints_sys/features/auth/presentation/widgets/custom_button.dart';
import 'package:complaints_sys/features/complaints/domain/entities/dropdown_item.dart';
import 'package:complaints_sys/features/complaints/presentation/provider/add_complaint_provider.dart';
import 'package:complaints_sys/features/complaints/presentation/widgets/success_dialog.dart';

class AddComplaintScreen extends StatefulWidget {
  const AddComplaintScreen({super.key});

  @override
  State<AddComplaintScreen> createState() => _AddComplaintScreenState();
}

class _AddComplaintScreenState extends State<AddComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();

  DropdownItem? _selectedComplaintType;
  DropdownItem? _selectedEntity;

  // --- 1. متغير لتتبع حالة التحقق التلقائي ---
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddComplaintProvider>().loadInitialData();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    context.read<AddComplaintProvider>().clearState();
    super.dispose();
  }

  void _submitComplaint() async {
    final provider = context.read<AddComplaintProvider>();

    // --- 2. التعديل هنا ---
    if (_formKey.currentState!.validate()) {
      // --- إذا نجح التحقق ---
      bool success = await provider.submitComplaint(
        name: _nameController.text,
        complaintTypeId: _selectedComplaintType!.id.toString(),
        governmentEntityId: _selectedEntity!.id.toString(),
        locationDescription: _locationController.text,
        problemDescription: _descriptionController.text,
      );

      if (success && mounted) {
        // إظهار مربع النجاح
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext dialogContext) {
            return SuccessDialog(
              title: 'تم الإرسال بنجاح',
              message: 'شكراً لك، تم إرسال بياناتك بنجاح.',
              onPressed: () {
                Navigator.of(dialogContext).pop();

                _formKey.currentState?.reset();
                _nameController.clear();
                _locationController.clear();
                _descriptionController.clear();
                setState(() {
                  _selectedComplaintType = null;
                  _selectedEntity = null;
                  _autovalidateMode =
                      AutovalidateMode.disabled; // إيقاف التحقق التلقائي
                });
                provider.clearAttachments();
              },
            );
          },
        );
      }
    } else {
      // --- 3. إذا فشل التحقق (أول مرة) ---
      // (قم بتشغيل التحقق التلقائي من الآن فصاعداً)
      setState(() {
        _autovalidateMode = AutovalidateMode.onUserInteraction;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // --- (تعريف الـ Borders) ---
    final greyBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.5),
        width: 1.5,
      ),
    );

    final redErrorBorder = greyBorder.copyWith(
      borderSide: BorderSide(
        color: Colors.red.shade700,
        width: 1.5,
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.fillColor.withOpacity(0.5),
      appBar: AppBar(
        title: const Text('إضافة شكوى جديدة'),
        centerTitle: true,
        elevation: 1,
      ),
      body: Consumer<AddComplaintProvider>(
        builder: (context, provider, child) {
          if (provider.dataLoadingState == DataLoadingState.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.dataLoadingState == DataLoadingState.error) {
            return Center(
              child: Text(
                'فشل جلب البيانات: ${provider.dataError}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          return Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: ListView(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 20.h,
                bottom: 120.h,
              ),
              children: [
                TextFormField(
                  controller: _nameController,
                  validator: (value) => value == null || value.isEmpty
                      ? 'الرجاء إدخال العنوان'
                      : null,
                  style: const TextStyle(
                      color: Colors.black87, fontFamily: 'Zain'),
                  decoration: InputDecoration()
                      .applyDefaults(theme.inputDecorationTheme)
                      .copyWith(
                        hintText: 'عنوان الشكوى (مثال: تعطل إنارة)',
                        prefixIcon: const Icon(Icons.title),
                        enabledBorder: greyBorder,
                        focusedBorder: greyBorder.copyWith(
                          borderSide: const BorderSide(
                              color: AppColors.primary500, width: 1.5),
                        ),
                        errorBorder: redErrorBorder,
                        focusedErrorBorder: redErrorBorder,
                      ),
                ),
                SizedBox(height: 16.h),
                DropdownButtonFormField<DropdownItem>(
                  value: _selectedComplaintType,
                  hint: const Text('اختر نوع الشكوى'),
                  decoration: InputDecoration()
                      .applyDefaults(theme.inputDecorationTheme)
                      .copyWith(
                        prefixIcon: const Icon(Icons.category),
                        enabledBorder: greyBorder,
                        focusedBorder: greyBorder.copyWith(
                          borderSide: const BorderSide(
                              color: AppColors.primary500, width: 1.5),
                        ),
                        errorBorder: redErrorBorder,
                        focusedErrorBorder: redErrorBorder,
                      ),
                  items: provider.complaintTypes.map((DropdownItem item) {
                    return DropdownMenuItem<DropdownItem>(
                      value: item,
                      child: Text(item.name,
                          style: const TextStyle(fontFamily: 'Zain')),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedComplaintType = newValue;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'الرجاء اختيار نوع الشكوى' : null,
                ),
                SizedBox(height: 16.h),
                DropdownButtonFormField<DropdownItem>(
                  value: _selectedEntity,
                  hint: const Text('اختر الجهة المعنية'),
                  decoration: InputDecoration()
                      .applyDefaults(theme.inputDecorationTheme)
                      .copyWith(
                        prefixIcon: const Icon(Icons.account_balance),
                        enabledBorder: greyBorder,
                        focusedBorder: greyBorder.copyWith(
                          borderSide: const BorderSide(
                              color: AppColors.primary500, width: 1.5),
                        ),
                        errorBorder: redErrorBorder,
                        focusedErrorBorder: redErrorBorder,
                      ),
                  items: provider.governmentEntities.map((DropdownItem item) {
                    return DropdownMenuItem<DropdownItem>(
                      value: item,
                      child: Text(item.name,
                          style: const TextStyle(fontFamily: 'Zain')),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedEntity = newValue;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'الرجاء اختيار الجهة' : null,
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: _locationController,
                  validator: (value) => value == null || value.isEmpty
                      ? 'الرجاء إدخال الموقع'
                      : null,
                  style: const TextStyle(
                      color: Colors.black87, fontFamily: 'Zain'),
                  decoration: InputDecoration()
                      .applyDefaults(theme.inputDecorationTheme)
                      .copyWith(
                        hintText: 'الموقع (الحي، الشارع...)',
                        prefixIcon: const Icon(Icons.location_on),
                        enabledBorder: greyBorder,
                        focusedBorder: greyBorder.copyWith(
                          borderSide: const BorderSide(
                              color: AppColors.primary500, width: 1.5),
                        ),
                        errorBorder: redErrorBorder,
                        focusedErrorBorder: redErrorBorder,
                      ),
                ),
                SizedBox(height: 16.h),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 6,
                  style: const TextStyle(
                      color: Colors.black87, fontFamily: 'Zain'),
                  decoration: InputDecoration()
                      .applyDefaults(theme.inputDecorationTheme)
                      .copyWith(
                        hintText: 'اكتب وصف المشكلة هنا...',
                        prefixIcon: null,
                        alignLabelWithHint: true,
                        enabledBorder: greyBorder,
                        focusedBorder: greyBorder.copyWith(
                          borderSide: const BorderSide(
                              color: AppColors.primary500, width: 1.5),
                        ),
                        errorBorder: redErrorBorder,
                        focusedErrorBorder: redErrorBorder,
                      ),
                  validator: (value) => value == null || value.isEmpty
                      ? 'الرجاء إدخال الوصف'
                      : null,
                ),
                SizedBox(height: 24.h),
                OutlinedButton.icon(
                  onPressed: () => provider.pickFiles(),
                  icon: const Icon(Icons.attach_file),
                  label: const Text('إرفاق صور أو مستندات (PDF)'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary500,
                    side: const BorderSide(color: AppColors.primary500),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
                SizedBox(height: 16.h),
                ...provider.attachments.asMap().entries.map((entry) {
                  int index = entry.key;
                  String path = entry.value;
                  return Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: Icon(
                        path.endsWith('.pdf')
                            ? Icons.picture_as_pdf
                            : Icons.image,
                        color: AppColors.primary500,
                      ),
                      title: Text(
                        basename(path),
                        style: const TextStyle(fontFamily: 'Zain'),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => provider.removeFile(index),
                      ),
                    ),
                  );
                }),
                SizedBox(height: 24.h),
                if (provider.submissionError != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Text(
                      provider.submissionError!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red[700],
                        fontSize: 15.sp,
                        fontFamily: 'Zain',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                CustomButton(
                  onPressed: provider.isSubmitting ? null : _submitComplaint,
                  backgroundColor: AppColors.primary500,
                  textColor: Colors.white,
                  child: provider.isSubmitting
                      ? SizedBox(
                          height: 25.h,
                          width: 25.w,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : Text(
                          'إرسال الشكوى',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Zain',
                          ),
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
