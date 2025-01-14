import 'package:flutter/material.dart';

class ReportDialog extends StatefulWidget {
  final String feedId;

  const ReportDialog({
    super.key,
    required this.feedId,
  });

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  String? selectedReason;
  final List<String> reportReasons = [
    '스팸/도배글입니다',
    '불법 정보를 포함하고 있습니다',
    '욕설/혐오/차별적 표현이 있습니다',
    '개인정보 노출 게시물입니다',
    '음란물/성적 표현이 있습니다',
    '기타 부적절한 내용이 있습니다',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        '신고하기',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('신고 사유를 선택해주세요'),
            const SizedBox(height: 16),
            ...reportReasons.map(
              (reason) => RadioListTile(
                title: Text(reason),
                value: reason,
                groupValue: selectedReason,
                onChanged: (value) {
                  setState(() {
                    selectedReason = value as String;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: selectedReason == null
              ? null
              : () {
                  Navigator.pop(context);
                  // 신고 제출 완료 알림
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('소중한 의견 감사합니다.'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
          child: const Text('제출'),
        ),
      ],
    );
  }
}
