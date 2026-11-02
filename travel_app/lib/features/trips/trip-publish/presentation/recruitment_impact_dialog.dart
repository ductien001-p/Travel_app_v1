import 'package:flutter/material.dart';
import 'package:travel_frontend_v1/core/networks/api_exception.dart';

const recruitmentImpactAckCode = 'RECRUITMENT_IMPACT_ACK_REQUIRED';

bool isRecruitmentImpactAck(Object error) =>
    error is ApiException && error.code == recruitmentImpactAckCode;

Future<bool> showRecruitmentImpactDialog(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Ngày đi sẽ đổi trên bài tuyển'),
        content: const Text(
          'Chuyến đang tuyển. Đổi ngày hoặc điểm đến sẽ tính lại thời điểm '
          'hết hạn và báo cho thành viên cùng yêu cầu đang chờ.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Huỷ'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Xác nhận'),
          ),
        ],
      );
    },
  );
  return confirmed ?? false;
}
