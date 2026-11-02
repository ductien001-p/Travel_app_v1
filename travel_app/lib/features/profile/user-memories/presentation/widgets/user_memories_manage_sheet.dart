import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/theme/app_colors.dart';
import 'package:travel_frontend_v1/core/theme/app_spacing.dart';
import 'package:travel_frontend_v1/core/theme/app_typography.dart';
import 'package:travel_frontend_v1/core/widget/app_empty_view.dart';
import 'package:travel_frontend_v1/core/widget/app_search_bar.dart';
import 'package:travel_frontend_v1/features/profile/presentation/profile_showcase_labels.dart';

import '../../application/user_memories_view.dart';
import '../../data/models/user_memories_models.dart';

class UserMemoriesManageSheet extends StatefulWidget {
  const UserMemoriesManageSheet({super.key, required this.collections});

  final List<UserMemoryCollection> collections;

  @override
  State<UserMemoriesManageSheet> createState() =>
      _UserMemoriesManageSheetState();
}

class _UserMemoriesManageSheetState extends State<UserMemoriesManageSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final matches = filterMemoryCollections(widget.collections, _query);
    final height = MediaQuery.sizeOf(context).height * 0.6;
    return SizedBox(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Chuyến đi của bạn', style: AppTypography.sectionTitle),
          const SizedBox(height: AppSpacing.sm),
          AppSearchBar(
            hintText: 'Tìm theo tên chuyến',
            onChanged: (value) => setState(() => _query = value),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: matches.isEmpty
                ? const AppEmptyView(
                    icon: Icons.map_outlined,
                    title: 'Không có chuyến phù hợp',
                    description: 'Thử một tên ngắn hơn.',
                  )
                : ListView.separated(
                    itemCount: matches.length,
                    separatorBuilder: (_, _) =>
                        const Divider(height: 1, color: AppColors.glassBorder),
                    itemBuilder: (context, index) {
                      final collection = matches[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          collection.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          profileTripStatusLabel(collection.status),
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        trailing: Text(
                          '${collection.memoryCount} ảnh',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        onTap: () =>
                            Navigator.of(context).pop(collection.tripId),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
