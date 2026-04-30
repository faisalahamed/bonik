import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/application/auth_controller.dart';
import '../../features/auth/application/auth_state.dart';
import '../../core/database/app_database.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_otp_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/auth/presentation/widgets/signup_form_card.dart';
import '../../features/dashboard/presentation/pages/dashboard_entry_page.dart';
import '../../features/dues/presentation/pages/dues_giving_page.dart';
import '../../features/dues/presentation/pages/dues_ledger_details_page.dart';
import '../../features/dues/presentation/pages/dues_ledger_page.dart';
import '../../features/dues/presentation/pages/dues_taking_page.dart';
import '../../features/expenses/presentation/pages/expense_categories_page.dart';
import '../../features/expenses/presentation/pages/expense_create_page.dart';
import '../../features/expenses/presentation/pages/expense_history_page.dart';
import '../../features/expenses/presentation/pages/expense_page.dart';
import '../../features/inventory/presentation/pages/inventory_page.dart';
import '../../features/incomes/presentation/pages/other_income_page.dart';
import '../../features/incomes/presentation/pages/other_income_create_page.dart';
import '../../features/incomes/presentation/pages/other_income_categories_page.dart';
import '../../features/owners/presentation/pages/owner_giving_page.dart';
import '../../features/owners/presentation/pages/owner_taking_page.dart';
import '../../features/owners/presentation/pages/owner_transactions_page.dart';
import '../../features/purchases/presentation/pages/cash_purchase_page.dart';
import '../../features/purchases/presentation/pages/cash_purchase_payment_page.dart';
import '../../features/purchases/presentation/pages/purchase_history_details_page.dart';
import '../../features/purchases/presentation/pages/purchase_history_page.dart';
import '../../features/purchases/presentation/pages/cash_purchase_review_page.dart';
import '../../features/reports/presentation/pages/purchase_report_page.dart';
import '../../features/reports/presentation/pages/expense_report_page.dart';
import '../../features/reports/presentation/pages/other_income_report_page.dart';
import '../../features/reports/presentation/pages/product_report_page.dart';
import '../../features/reports/presentation/pages/profit_loss_report_page.dart';
import '../../features/reports/presentation/pages/profit_loss_report_details_page.dart';
import '../../features/reports/presentation/pages/reports_page.dart';
import '../../features/reports/presentation/pages/sales_report_page.dart';
import '../../features/reports/presentation/pages/stock_report_page.dart';
import '../../features/reports/presentation/pages/suppliers_report_page.dart';
import '../../features/reports/presentation/pages/top_customers_report_page.dart';
import '../../features/sales/presentation/pages/sales_cart_page.dart';
import '../../features/sales/presentation/pages/sales_history_details_page.dart';
import '../../features/sales/presentation/pages/sales_history_page.dart';
import '../../features/sales/presentation/pages/sales_payment_page.dart';
import '../../features/sales/presentation/pages/sales_return_page.dart';
import '../../features/sales/presentation/pages/sales_page.dart';
import '../../features/stores/presentation/pages/store_selector_page.dart';
import '../../features/users/presentation/pages/user_management_page.dart';
import 'app_routes.dart';

final appNavigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (ref) => GlobalKey<NavigatorState>(),
);

final _routerNotifierProvider = Provider<RouterNotifier>((ref) {
  final notifier = RouterNotifier(ref);
  ref.onDispose(notifier.dispose);
  return notifier;
});

final appRouterProvider = Provider<GoRouter>((ref) {
  final navigatorKey = ref.watch(appNavigatorKeyProvider);
  final routerNotifier = ref.watch(_routerNotifierProvider);

  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.login,
    refreshListenable: routerNotifier,
    routes: [
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        name: 'signup',
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: AppRoutes.signupOtp,
        name: 'signup-otp',
        builder: (context, state) => SignupOtpPage(
          signupData: state.extra is SignupFormData
              ? state.extra! as SignupFormData
              : null,
        ),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: AppRoutes.dashboard,
        name: 'dashboard',
        builder: (context, state) => const DashboardEntryPage(),
      ),
      GoRoute(
        path: AppRoutes.cashPurchase,
        name: 'cash-purchase',
        builder: (context, state) => const CashPurchasePage(),
      ),
      GoRoute(
        path: AppRoutes.purchaseHistory,
        name: 'purchase-history',
        builder: (context, state) => const PurchaseHistoryPage(),
      ),
      GoRoute(
        path: AppRoutes.purchaseHistoryDetails,
        name: 'purchase-history-details',
        builder: (context, state) => const PurchaseHistoryDetailsPage(),
      ),
      GoRoute(
        path: AppRoutes.cashPurchaseReview,
        name: 'cash-purchase-review',
        builder: (context, state) {
          final selectedCategories = state.extra is List<LocalCategory>
              ? state.extra! as List<LocalCategory>
              : const <LocalCategory>[];

          return CashPurchaseReviewPage(selectedCategories: selectedCategories);
        },
      ),
      GoRoute(
        path: AppRoutes.cashPurchasePayment,
        name: 'cash-purchase-payment',
        builder: (context, state) => const CashPurchasePaymentPage(),
      ),
      GoRoute(
        path: AppRoutes.duesLedger,
        name: 'dues-ledger',
        builder: (context, state) => const DuesLedgerPage(),
      ),
      GoRoute(
        path: AppRoutes.duesLedgerDetails,
        name: 'dues-ledger-details',
        builder: (context, state) => const DuesLedgerDetailsPage(),
      ),
      GoRoute(
        path: AppRoutes.duesGiving,
        name: 'dues-giving',
        builder: (context, state) => const DuesGivingPage(),
      ),
      GoRoute(
        path: AppRoutes.duesTaking,
        name: 'dues-taking',
        builder: (context, state) => const DuesTakingPage(),
      ),
      GoRoute(
        path: AppRoutes.expenses,
        name: 'expenses',
        builder: (context, state) => const ExpensePage(),
      ),
      GoRoute(
        path: AppRoutes.expenseHistory,
        name: 'expense-history',
        builder: (context, state) => const ExpenseHistoryPage(),
      ),
      GoRoute(
        path: AppRoutes.inventory,
        name: 'inventory',
        builder: (context, state) => const InventoryPage(),
      ),
      GoRoute(
        path: AppRoutes.otherIncome,
        name: 'other-income',
        builder: (context, state) => const OtherIncomePage(),
      ),
      GoRoute(
        path: '${AppRoutes.otherIncomeCreate}/:category',
        name: 'other-income-create',
        builder: (context, state) => OtherIncomeCreatePage(
          categoryName: state.pathParameters['category'] ?? '',
        ),
      ),
      GoRoute(
        path: AppRoutes.otherIncomeCategories,
        name: 'other-income-categories',
        builder: (context, state) => const OtherIncomeCategoriesPage(),
      ),
      GoRoute(
        path: AppRoutes.ownerTransactions,
        name: 'owner-transactions',
        builder: (context, state) => const OwnerTransactionsPage(),
      ),
      GoRoute(
        path: AppRoutes.ownerGiving,
        name: 'owner-giving',
        builder: (context, state) => const OwnerGivingPage(),
      ),
      GoRoute(
        path: AppRoutes.ownerTaking,
        name: 'owner-taking',
        builder: (context, state) => const OwnerTakingPage(),
      ),
      GoRoute(
        path: AppRoutes.reports,
        name: 'reports',
        builder: (context, state) => const ReportsPage(),
      ),
      GoRoute(
        path: AppRoutes.reportPurchase,
        name: 'report-purchase',
        builder: (context, state) => const PurchaseReportPage(),
      ),
      GoRoute(
        path: AppRoutes.reportSales,
        name: 'report-sales',
        builder: (context, state) => const SalesReportPage(),
      ),
      GoRoute(
        path: AppRoutes.reportStock,
        name: 'report-stock',
        builder: (context, state) => const StockReportPage(),
      ),
      GoRoute(
        path: AppRoutes.reportProduct,
        name: 'report-product',
        builder: (context, state) => const ProductReportPage(),
      ),
      GoRoute(
        path: AppRoutes.reportProfitLoss,
        name: 'report-profit-loss',
        builder: (context, state) => const ProfitLossReportPage(),
      ),
      GoRoute(
        path: AppRoutes.reportProfitLossDetails,
        name: 'report-profit-loss-details',
        builder: (context, state) => const ProfitLossReportDetailsPage(),
      ),
      GoRoute(
        path: AppRoutes.reportTopCustomers,
        name: 'report-top-customers',
        builder: (context, state) => const TopCustomersReportPage(),
      ),
      GoRoute(
        path: AppRoutes.reportExpense,
        name: 'report-expense',
        builder: (context, state) => const ExpenseReportPage(),
      ),
      GoRoute(
        path: AppRoutes.reportOtherIncome,
        name: 'report-other-income',
        builder: (context, state) => const OtherIncomeReportPage(),
      ),
      GoRoute(
        path: AppRoutes.reportSuppliers,
        name: 'report-suppliers',
        builder: (context, state) => const SuppliersReportPage(),
      ),
      GoRoute(
        path: '${AppRoutes.expenseCreate}/:category',
        name: 'expense-create',
        builder: (context, state) => ExpenseCreatePage(
          categoryName: state.pathParameters['category'] ?? '',
        ),
      ),
      GoRoute(
        path: AppRoutes.expenseCategories,
        name: 'expense-categories',
        builder: (context, state) => const ExpenseCategoriesPage(),
      ),
      GoRoute(
        path: AppRoutes.sales,
        name: 'sales',
        builder: (context, state) => const SalesPage(),
      ),
      GoRoute(
        path: AppRoutes.salesHistory,
        name: 'sales-history',
        builder: (context, state) => const SalesHistoryPage(),
      ),
      GoRoute(
        path: AppRoutes.salesHistoryDetails,
        name: 'sales-history-details',
        builder: (context, state) => const SalesHistoryDetailsPage(),
      ),
      GoRoute(
        path: AppRoutes.salesReturn,
        name: 'sales-return',
        builder: (context, state) => const SalesReturnPage(),
      ),
      GoRoute(
        path: AppRoutes.salesCart,
        name: 'sales-cart',
        builder: (context, state) => const SalesCartPage(),
      ),
      GoRoute(
        path: AppRoutes.salesPayment,
        name: 'sales-payment',
        builder: (context, state) => const SalesPaymentPage(),
      ),
      GoRoute(
        path: AppRoutes.storeSelector,
        name: 'stores',
        builder: (context, state) => const StoreSelectorPage(),
      ),
      GoRoute(
        path: AppRoutes.users,
        name: 'users',
        builder: (context, state) => const UserManagementPage(),
      ),
    ],
    redirect: routerNotifier.redirect,
  );
});

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this.ref) {
    _subscription = ref.listen<AuthState>(
      authControllerProvider,
      (_, _) => notifyListeners(),
    );
  }

  final Ref ref;
  late final ProviderSubscription<AuthState> _subscription;

  String? redirect(BuildContext context, GoRouterState state) {
    final authState = ref.read(authControllerProvider);
    final location = state.matchedLocation;
    final isLoggingIn = location == AppRoutes.login;
    final isSigningUp = location == AppRoutes.signup;
    final isVerifyingSignup = location == AppRoutes.signupOtp;
    final isForgotPassword = location == AppRoutes.forgotPassword;
    final isAuthPage =
        isLoggingIn || isSigningUp || isVerifyingSignup || isForgotPassword;

    if (!authState.isAuthenticated && !isAuthPage) {
      return AppRoutes.login;
    }

    if (authState.isAuthenticated && isAuthPage) {
      return AppRoutes.dashboard;
    }

    return null;
  }

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
