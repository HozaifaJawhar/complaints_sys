import 'package:flutter/material.dart';
import 'package:complaints_sys/features/complaints/presentation/provider/get_complaints_provider.dart';
import 'package:complaints_sys/features/complaints/presentation/widgets/ComplaintCard.dart';

class ComplaintsListWidget extends StatelessWidget {
  final ComplaintsProvider provider;

  const ComplaintsListWidget({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    switch (provider.state) {
      case ComplaintsState.loading:
        return const Center(child: CircularProgressIndicator());

      case ComplaintsState.error:
        return Center(
          child: Text(
            provider.errorMessage ?? "حدث خطأ غير متوقع",
            style: const TextStyle(color: Colors.red),
          ),
        );

case ComplaintsState.loaded:
  final complaints = provider.filteredComplaints;

  return RefreshIndicator(
    onRefresh: () async {
      await provider.loadComplaints();
    },
    child: complaints.isEmpty
        ? ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Center(
                  child: Text(
                    provider.searchQuery.isEmpty
                        ? "لا توجد شكاوى حالياً\nاسحب للتحديث"
                        : "لا توجد شكاوى مطابقة\nاسحب للتحديث",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          )
        : ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: complaints.length,
            itemBuilder: (context, index) {
              final complaint = complaints[index];
              return ComplaintCard(complaint: complaint);
            },
          ),
  );


      case ComplaintsState.initial:
        return const Center(child: CircularProgressIndicator());
    }
  }
}
