import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel_frontend_v1/app/router/router_names.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_error_view.dart';
import 'package:travel_frontend_v1/core/widget/app_loading.dart';
import 'package:travel_frontend_v1/core/widget/app_scaffold.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/application/trip_detail_overview_controller.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/data/models/trip_detail_models.dart';
import 'package:travel_frontend_v1/features/trips/trip-details/presentation/widgets/trip_detail_feedback.dart';

import '../../application/trip_expense_receipt_ocr.dart';
import '../../application/trip_expense_receipt_ocr_reader.dart';
import '../../application/trip_expenses_action_controller.dart';
import '../../application/trip_expenses_create_form.dart';
import '../../data/models/trip_expenses_models.dart';
import '../../utils/trip_expenses_formatters.dart';
import '../widgets/trip_add_expense_widgets.dart';

/// Full-screen form to create a trip expense (Stitch "Thêm Khoản Chi Mới").
class TripAddExpenseScreen extends ConsumerStatefulWidget {
  const TripAddExpenseScreen({super.key, required this.tripId});

  final String tripId;

  @override
  ConsumerState<TripAddExpenseScreen> createState() =>
      _TripAddExpenseScreenState();
}

class _TripAddExpenseScreenState extends ConsumerState<TripAddExpenseScreen> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _customControllers = <String, TextEditingController>{};
  final _picker = ImagePicker();
  final _pendingReceipts = <XFile>[];

  TripExpensesCreateFormState _form = TripExpensesCreateFormState(
    spentAt: DateTime.now(),
  );
  TripExpensesCreateValidation _validation =
      const TripExpensesCreateValidation();
  bool _submitted = false;
  bool _ocrBusy = false;

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    for (final c in _customControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  TextEditingController _controllerFor(String memberId) {
    return _customControllers.putIfAbsent(
      memberId,
      () => TextEditingController(text: _form.customAmounts[memberId] ?? ''),
    );
  }

  void _syncForm(TripExpensesCreateFormState next) {
    setState(() {
      _form = next;
      if (_submitted) {
        _validation = validateTripExpensesCreateForm(
          _form,
          memberIds: _memberIds,
        );
      }
    });
  }

  List<String> get _memberIds {
    final members =
        ref
            .read(tripDetailOverviewControllerProvider(widget.tripId))
            .value
            ?.members ??
        const <TripDetailMember>[];
    return members.map((m) => m.id).toList(growable: false);
  }

  TripDetailMember? _viewerMember(List<TripDetailMember> members) {
    final viewerUserId = ref
        .read(tripDetailOverviewControllerProvider(widget.tripId))
        .value
        ?.viewer
        .userId;
    for (final member in members) {
      if (member.userId == viewerUserId) return member;
    }
    return members.isEmpty ? null : members.first;
  }

  void _onAmountChanged(String value) {
    final formatted = formatExpenseAmountInput(value, currency: _form.currency);
    if (formatted != _amountController.text) {
      _amountController.value = TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    }
    _syncForm(_form.copyWith(amountText: formatted));
  }

  void _clearAmount() {
    _amountController.clear();
    _syncForm(_form.copyWith(amountText: ''));
  }

  Future<void> _pickReceipt({required bool fromCamera}) async {
    if (_pendingReceipts.length >= maxExpenseReceipts) {
      showTripDetailMessage(context, 'Tối đa $maxExpenseReceipts ảnh hóa đơn');
      return;
    }
    final file = await _picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 2000,
    );
    if (file == null || !mounted) return;
    setState(() => _pendingReceipts.add(file));
  }

  Future<void> _showReceiptSourceSheet({bool runOcrAfter = false}) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: const Text('Chụp ảnh'),
              onTap: () async {
                Navigator.pop(ctx);
                await _pickReceipt(fromCamera: true);
                if (runOcrAfter && _pendingReceipts.isNotEmpty && mounted) {
                  await _runOcrAt(_pendingReceipts.length - 1);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Thư viện'),
              onTap: () async {
                Navigator.pop(ctx);
                await _pickReceipt(fromCamera: false);
                if (runOcrAfter && _pendingReceipts.isNotEmpty && mounted) {
                  await _runOcrAt(_pendingReceipts.length - 1);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _runOcrAt(int index) async {
    if (!expenseReceiptOcrAvailable) {
      showTripDetailMessage(
        context,
        'OCR chỉ hỗ trợ trên Android/iOS. Ảnh vẫn được đính kèm.',
      );
      return;
    }
    if (index < 0 || index >= _pendingReceipts.length) return;
    setState(() => _ocrBusy = true);
    try {
      final result = await recognizeExpenseReceipt(
        imagePath: _pendingReceipts[index].path,
        currency: _form.currency,
      );
      if (!mounted) return;
      _applyOcrResult(result);
    } catch (_) {
      if (!mounted) return;
      showTripDetailMessage(
        context,
        'Không đọc được hóa đơn. Bạn vẫn có thể nhập tay.',
      );
    } finally {
      if (mounted) setState(() => _ocrBusy = false);
    }
  }

  void _applyOcrResult(TripExpenseOcrResult result) {
    var next = _form;
    if (result.amountText != null && result.amountText!.isNotEmpty) {
      final formatted = formatExpenseAmountInput(
        result.amountText!,
        currency: _form.currency,
      );
      _amountController.text = formatted;
      next = next.copyWith(amountText: formatted);
    }
    if (result.description != null && result.description!.isNotEmpty) {
      _descriptionController.text = result.description!;
      next = next.copyWith(description: result.description);
    }
    if (result.category != null) {
      next = next.copyWith(category: result.category);
    }
    _syncForm(next);
    showTripDetailMessage(context, 'Đã điền gợi ý từ hóa đơn');
  }

  Future<void> _editWhenAndLocation() async {
    await showTripAddExpenseWhenSheet(
      context: context,
      initialSpentAt: _form.spentAt ?? DateTime.now(),
      initialLocation: _form.locationNote,
      onSave: (spentAt, locationNote) {
        _syncForm(_form.copyWith(spentAt: spentAt, locationNote: locationNote));
      },
    );
  }

  Future<void> _submit(List<TripDetailMember> members) async {
    final viewer = _viewerMember(members);
    setState(() {
      _submitted = true;
      _validation = validateTripExpensesCreateForm(
        _form,
        memberIds: members.map((m) => m.id).toList(),
      );
    });
    final request = buildCreateTripExpenseRequest(
      _form,
      memberIds: members.map((m) => m.id).toList(),
      defaultPayerTripMemberId: viewer?.id,
    );
    if (request == null) return;

    try {
      await ref
          .read(tripExpensesActionControllerProvider(widget.tripId).notifier)
          .createExpenseWithReceipts(
            request: request,
            pendingReceipts: List<XFile>.from(_pendingReceipts),
          );
      if (!mounted) return;
      showTripDetailMessage(context, 'Đã thêm khoản chi');
      context.pop(true);
    } catch (error) {
      if (!mounted) return;
      showTripDetailMessage(context, tripExpensesActionErrorMessage(error));
    }
  }

  void _goBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(
        RouteNames.tripExpenses,
        pathParameters: {'tripId': widget.tripId},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tripAsync = ref.watch(
      tripDetailOverviewControllerProvider(widget.tripId),
    );
    final action = ref.watch(
      tripExpensesActionControllerProvider(widget.tripId),
    );
    final busy = action.isBusy || _ocrBusy;

    return AppScaffold(
      extendBody: false,
      topBar: TripAddExpenseTopBar(
        tripName: tripAsync.value?.name,
        onCancel: _goBack,
        onScanReceipt: () => _showReceiptSourceSheet(runOcrAfter: true),
      ),
      bottomNavigationBar: tripAsync.when(
        data: (trip) => TripAddExpenseBottomBar(
          memberCount: trip.members.length,
          isLoading: busy,
          onSubmit: busy ? null : () => _submit(trip.members),
        ),
        loading: () => null,
        error: (_, _) => null,
      ),
      body: switch (tripAsync) {
        AsyncValue(:final value?) => _AddExpenseFormBody(
          trip: value,
          form: _form,
          validation: _validation,
          submitted: _submitted,
          amountController: _amountController,
          descriptionController: _descriptionController,
          customControllerFor: _controllerFor,
          pendingReceiptPaths: _pendingReceipts.map((f) => f.path).toList(),
          onAmountChanged: _onAmountChanged,
          onClearAmount: _clearAmount,
          onDescriptionChanged: (value) =>
              _syncForm(_form.copyWith(description: value)),
          onCurrencyChanged: (currency) =>
              _syncForm(_form.copyWith(currency: currency)),
          onCategoryChanged: (category) =>
              _syncForm(_form.copyWith(category: category)),
          onSplitTypeChanged: (splitType) =>
              _syncForm(_form.copyWith(splitType: splitType)),
          onCustomAmountChanged: (memberId, value) {
            final formatted = formatExpenseAmountInput(
              value,
              currency: _form.currency,
            );
            final controller = _controllerFor(memberId);
            if (formatted != controller.text) {
              controller.value = TextEditingValue(
                text: formatted,
                selection: TextSelection.collapsed(offset: formatted.length),
              );
            }
            final next = Map<String, String>.from(_form.customAmounts)
              ..[memberId] = formatted;
            _syncForm(_form.copyWith(customAmounts: next));
          },
          onSelectPayer: (member) =>
              _syncForm(_form.copyWith(payerTripMemberId: member.id)),
          onAddReceipt: () => _showReceiptSourceSheet(),
          onRemoveReceipt: (index) {
            setState(() => _pendingReceipts.removeAt(index));
          },
          onOcrReceipt: _runOcrAt,
          onEditWhen: _editWhenAndLocation,
          onCalculate: () => showTripDetailComingSoon(context),
        ),
        AsyncValue(:final error?) => AppErrorView(
          title: 'Không thể tải thành viên',
          message: tripExpensesErrorMessage(error),
          actionLabel: 'Thử lại',
          onRetry: () => ref.invalidate(
            tripDetailOverviewControllerProvider(widget.tripId),
          ),
        ),
        _ => const AppLoading(),
      },
    );
  }
}

class _AddExpenseFormBody extends StatelessWidget {
  const _AddExpenseFormBody({
    required this.trip,
    required this.form,
    required this.validation,
    required this.submitted,
    required this.amountController,
    required this.descriptionController,
    required this.customControllerFor,
    required this.pendingReceiptPaths,
    required this.onAmountChanged,
    required this.onClearAmount,
    required this.onDescriptionChanged,
    required this.onCurrencyChanged,
    required this.onCategoryChanged,
    required this.onSplitTypeChanged,
    required this.onCustomAmountChanged,
    required this.onSelectPayer,
    required this.onAddReceipt,
    required this.onRemoveReceipt,
    required this.onOcrReceipt,
    required this.onEditWhen,
    required this.onCalculate,
  });

  final TripDetailOverview trip;
  final TripExpensesCreateFormState form;
  final TripExpensesCreateValidation validation;
  final bool submitted;
  final TextEditingController amountController;
  final TextEditingController descriptionController;
  final TextEditingController Function(String memberId) customControllerFor;
  final List<String> pendingReceiptPaths;
  final ValueChanged<String> onAmountChanged;
  final VoidCallback onClearAmount;
  final ValueChanged<String> onDescriptionChanged;
  final ValueChanged<TripExpensesCurrency> onCurrencyChanged;
  final ValueChanged<TripExpensesCategory> onCategoryChanged;
  final ValueChanged<TripExpensesSplitType> onSplitTypeChanged;
  final void Function(String memberId, String value) onCustomAmountChanged;
  final ValueChanged<TripDetailMember> onSelectPayer;
  final VoidCallback onAddReceipt;
  final ValueChanged<int> onRemoveReceipt;
  final ValueChanged<int> onOcrReceipt;
  final VoidCallback onEditWhen;
  final VoidCallback onCalculate;

  @override
  Widget build(BuildContext context) {
    final amount = form.amount;
    final memberCount = trip.members.length;
    final equalShare = amount != null && memberCount > 0
        ? amount / memberCount
        : null;
    final customAllocated = _customAllocatedSum();
    final customPercent = amount != null && amount > 0
        ? ((customAllocated / amount) * 100).clamp(0, 100).round()
        : 0;
    String? selectedPayerId = form.payerTripMemberId;
    if (selectedPayerId == null) {
      for (final member in trip.members) {
        if (member.userId == trip.viewer.userId) {
          selectedPayerId = member.id;
          break;
        }
      }
      selectedPayerId ??= trip.members.isEmpty ? null : trip.members.first.id;
    }

    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.sm,
        AppSpacing.screenHorizontal,
        AppSpacing.xl,
      ),
      children: [
        TripAddExpenseAmountCard(
          amountController: amountController,
          descriptionController: descriptionController,
          currency: form.currency,
          amountError: submitted ? validation.amountError : null,
          onAmountChanged: onAmountChanged,
          onClearAmount: onClearAmount,
          onDescriptionChanged: onDescriptionChanged,
          onCurrencyChanged: onCurrencyChanged,
          onCalculate: onCalculate,
        ),
        const SizedBox(height: AppSpacing.section),
        TripAddExpenseCategoryGrid(
          selected: form.category,
          onSelected: onCategoryChanged,
        ),
        const SizedBox(height: AppSpacing.section),
        TripAddExpensePayerSection(
          members: trip.members,
          viewerUserId: trip.viewer.userId,
          selectedMemberId: selectedPayerId,
          onSelect: onSelectPayer,
        ),
        if (submitted && validation.payerError != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            validation.payerError!,
            style: AppTypography.caption.copyWith(color: AppColors.danger),
          ),
        ],
        const SizedBox(height: AppSpacing.section),
        TripAddExpenseSplitSection(
          form: form,
          members: trip.members,
          viewerUserId: trip.viewer.userId,
          equalShare: equalShare,
          customAllocated: customAllocated,
          customPercent: customPercent,
          splitsError: submitted ? validation.splitsError : null,
          customControllerFor: customControllerFor,
          onSplitTypeChanged: onSplitTypeChanged,
          onCustomAmountChanged: onCustomAmountChanged,
        ),
        const SizedBox(height: AppSpacing.section),
        TripAddExpenseReceiptSection(
          localPaths: pendingReceiptPaths,
          onAddPhoto: onAddReceipt,
          onRemoveAt: onRemoveReceipt,
          onOcrAt: onOcrReceipt,
          canAddMore: pendingReceiptPaths.length < maxExpenseReceipts,
          showOcr: expenseReceiptOcrAvailable,
        ),
        if (submitted && validation.receiptsError != null) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            validation.receiptsError!,
            style: AppTypography.caption.copyWith(color: AppColors.danger),
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        Center(
          child: TextButton.icon(
            onPressed: onEditWhen,
            icon: const Icon(Icons.schedule_rounded, size: 16),
            label: Text(
              'Thay đổi ngày chi: ${formatExpenseSpentAtLabel(form.spentAt)}'
              '${form.locationNote.trim().isEmpty ? '' : ' • ${form.locationNote.trim()}'}',
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  num _customAllocatedSum() {
    num sum = 0;
    for (final raw in form.customAmounts.values) {
      final value = parseExpenseAmountText(raw, form.currency);
      if (value != null && value > 0) sum += value;
    }
    return sum;
  }
}
