import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:focus_planner/features/tasks/domain/entities/attachment.dart';

part 'attachment_model.g.dart';
part 'attachment_model.freezed.dart';

@freezed
abstract class AttachmentModel with _$AttachmentModel {
  const AttachmentModel._();

  const factory AttachmentModel({
    required String id,
    @JsonKey(name: 'task_id') required String taskId,
    @JsonKey(name: 'image_url') required String imageUrl,
    @JsonKey(name: 'file_name') required String fileName,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _AttachmentModel;

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentModelFromJson(json);

  Attachment toEntity() {
    return Attachment(
      id: id,
      taskId: taskId,
      imageUrl: imageUrl,
      fileName: fileName,
      createdAt: DateTime.parse(createdAt),
    );
  }
}
