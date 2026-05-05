import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/tasks/domain/entities/attachment.dart';
import 'package:focus_planner/features/tasks/domain/repository/task_repository.dart';

class UploadAttachment
    implements UseCase<Attachment, UploadAttachmentParams> {
  final TaskRepository _taskRepository;
  const UploadAttachment(this._taskRepository);

  @override
  Future<Attachment> call(UploadAttachmentParams params) async {
    return await _taskRepository.uploadAttachment(
      taskId: params.taskId,
      filePath: params.filePath,
      fileName: params.fileName,
    );
  }
}

class UploadAttachmentParams {
  final String taskId;
  final String filePath;
  final String fileName;

  const UploadAttachmentParams({
    required this.taskId,
    required this.filePath,
    required this.fileName,
  });
}
