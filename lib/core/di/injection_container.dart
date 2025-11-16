import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:complaints_sys/core/api/api_helper.dart';
import 'package:complaints_sys/core/services/secure_storage_service.dart';
import 'package:complaints_sys/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:complaints_sys/features/complaints/data/repositories/complaint_repository_impl.dart';
import 'package:complaints_sys/features/auth/domain/repositories/auth_repository.dart';
import 'package:complaints_sys/features/auth/domain/usecases/login_usecase.dart';
import 'package:complaints_sys/features/auth/domain/usecases/logout_usecase.dart';
import 'package:complaints_sys/features/auth/domain/usecases/register_usecase.dart';
import 'package:complaints_sys/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:complaints_sys/features/complaints/domain/repositories/complaint_repository.dart';
import 'package:complaints_sys/features/complaints/domain/usecases/get_complaint_types_usecase.dart';
import 'package:complaints_sys/features/complaints/domain/usecases/get_government_entities_usecase.dart';
import 'package:complaints_sys/features/complaints/domain/usecases/submit_complaint_usecase.dart';
import 'package:complaints_sys/features/auth/presentation/provider/login_provider.dart';
import 'package:complaints_sys/features/profile/presentation/provider/profile_provider.dart';
import 'package:complaints_sys/features/auth/presentation/provider/register_provider.dart';
import 'package:complaints_sys/features/auth/presentation/provider/otp_provider.dart';
import 'package:complaints_sys/features/complaints/presentation/provider/add_complaint_provider.dart';

class Injector {
  Injector._();

  static List<SingleChildWidget> setupProviders() {
    return [
      // (Core Services)
      Provider<Api>(create: (_) => Api()),
      Provider<SecureStorageService>(create: (_) => SecureStorageService()),

      //طبقة  Data (Repositories) ---
      ProxyProvider2<Api, SecureStorageService, AuthRepository>(
        update: (_, api, storage, __) =>
            AuthRepositoryImpl(api: api, storage: storage),
      ),
      ProxyProvider2<Api, SecureStorageService, ComplaintRepository>(
        update: (_, api, storage, __) =>
            ComplaintRepositoryImpl(api: api, storage: storage),
      ),

      //طبقة  Domain (UseCases) ---
      // (Auth UseCases)
      ProxyProvider<AuthRepository, LoginUseCase>(
        update: (_, repo, __) => LoginUseCase(repo),
      ),
      ProxyProvider<AuthRepository, LogoutUseCase>(
        update: (_, repo, __) => LogoutUseCase(repo),
      ),
      ProxyProvider<AuthRepository, RegisterUseCase>(
        update: (_, repo, __) => RegisterUseCase(repo),
      ),
      ProxyProvider<AuthRepository, VerifyOtpUseCase>(
        update: (_, repo, __) => VerifyOtpUseCase(repo),
      ),
      // (Complaint UseCases)
      ProxyProvider<ComplaintRepository, GetComplaintTypesUseCase>(
        update: (_, repo, __) => GetComplaintTypesUseCase(repo),
      ),
      ProxyProvider<ComplaintRepository, GetGovernmentEntitiesUseCase>(
        update: (_, repo, __) => GetGovernmentEntitiesUseCase(repo),
      ),
      ProxyProvider<ComplaintRepository, SubmitComplaintUseCase>(
        update: (_, repo, __) => SubmitComplaintUseCase(repo),
      ),

      // طبقة  Presentation (Providers) ---
      ChangeNotifierProvider<LoginProvider>(
        create: (context) => LoginProvider(context.read<LoginUseCase>()),
      ),
      ChangeNotifierProvider<ProfileProvider>(
        create: (context) => ProfileProvider(context.read<LogoutUseCase>()),
      ),
      ChangeNotifierProvider<RegisterProvider>(
        create: (context) => RegisterProvider(context.read<RegisterUseCase>()),
      ),
      ChangeNotifierProvider<OtpProvider>(
        create: (context) => OtpProvider(context.read<VerifyOtpUseCase>()),
      ),

      // Provider
      ChangeNotifierProvider<AddComplaintProvider>(
        create: (context) => AddComplaintProvider(
          context.read<GetComplaintTypesUseCase>(),
          context.read<GetGovernmentEntitiesUseCase>(),
          context.read<SubmitComplaintUseCase>(),
        ),
      ),
    ];
  }
}
