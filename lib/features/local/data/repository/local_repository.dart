import 'package:nesthub/features/local/data/remote/local_dto.dart';
import 'package:nesthub/features/local/data/remote/local_service.dart';
import 'package:nesthub/features/local/domain/local.dart';

class LocalRepository {
  final LocalService localService;

  LocalRepository({required this.localService});

  Future<List<Local>> getLocals() async {
    List<LocalDto> localDto = await localService.getLocals();

    return localDto.map((localDto) => localDto.toLocal()).toList();
  }
}
