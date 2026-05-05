import 'package:focus_planner/core/use_case/use_case.dart';
import 'package:focus_planner/features/tasks/domain/repository/task_repository.dart';

class DeleteAttachment
    implements UseCase<void, DeleteAttachmentParams> {
  final TaskRepository _taskRepository;
  const DeleteAttachment(this._taskRepository);

  @override
  Future<void> call(DeleteAttachmentParams params) async {
    await _taskRepository.deleteAttachment(
      attachmentId: params.attachmentId,
      storagePath: params.storagePath,
    );
  }
}

class DeleteAttachmentParams {
  final String attachmentId;
  final String storagePath;

  const DeleteAttachmentParams({
    required this.attachmentId,
    required this.storagePath,
  });
}
