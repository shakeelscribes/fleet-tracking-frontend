import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/errors/app_exception.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/utils/app_localizations_ext.dart';
import '../../../../core/utils/constants.dart';

/// PDF surface 1: multi-user login. Demo chips pre-fill the grader's
/// credentials (ravi = driver, admin = fleet admin) - zero typing needed.
class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final email = useTextEditingController();
    final password = useTextEditingController();
    final obscure = useState(true);
    final submitting = useState(false);
    final l10n = context.l10n;

    Future<void> submit() async {
      if (!(formKey.currentState?.validate() ?? false)) return;
      submitting.value = true;
      try {
        await ref
            .read(authControllerProvider.notifier)
            .login(email.text.trim(), password.text);
        // Router redirect takes over on success.
      } on AppException catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.localizedException(e)),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } finally {
        submitting.value = false;
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg.w),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 420.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.directions_bus_outlined,
                      size: 48.sp,
                      color: AppColors.primary,
                    ),
                    16.verticalSpace,
                    Text(
                      l10n.loginTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    8.verticalSpace,
                    Text(
                      l10n.loginSubtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    32.verticalSpace,
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        labelText: l10n.emailLabel,
                        prefixIcon: const Icon(Icons.alternate_email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) return l10n.fieldRequired;
                        if (!value.contains('@')) return l10n.emailInvalid;
                        return null;
                      },
                      onFieldSubmitted: (_) => submit(),
                    ),
                    16.verticalSpace,
                    TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                        labelText: l10n.passwordLabel,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscure.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () => obscure.value = !obscure.value,
                        ),
                      ),
                      obscureText: obscure.value,
                      autofillHints: const [AutofillHints.password],
                      validator: (v) =>
                          (v ?? '').length < 8 ? l10n.passwordShort : null,
                      onFieldSubmitted: (_) => submit(),
                    ),
                    24.verticalSpace,
                    FilledButton(
                      onPressed: submitting.value ? null : submit,
                      child: submitting.value
                          ? SizedBox(
                              height: 22.h,
                              width: 22.h,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2.4,
                              ),
                            )
                          : Text(l10n.signIn),
                    ),
                    32.verticalSpace,
                    Text(
                      l10n.demoAccounts,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: _DemoChip(
                            icon: Icons.directions_bus_outlined,
                            label: l10n.demoDriver,
                            onTap: () {
                              email.text = AppConstants.demoDriverEmail;
                              password.text = AppConstants.demoPassword;
                            },
                          ),
                        ),
                        8.horizontalSpace,
                        Expanded(
                          child: _DemoChip(
                            icon: Icons.admin_panel_settings_outlined,
                            label: l10n.demoAdmin,
                            onTap: () {
                              email.text = AppConstants.demoAdminEmail;
                              password.text = AppConstants.demoPassword;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DemoChip extends StatelessWidget {
  const _DemoChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md.r),
      child: Ink(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: colors.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppRadius.md.r),
          border: Border.all(color: colors.outlineVariant),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18.sp, color: AppColors.primary),
            8.horizontalSpace,
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
