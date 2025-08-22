import 'package:logger/logger.dart';
import 'package:hezmart/core/di/bloc_module.dart' as blocModule;
import 'package:hezmart/core/di/repository.dart' as repositoryModule;
import 'package:hezmart/core/di/network.dart' as networkModule;
import 'package:get_it/get_it.dart';


GetIt injector = GetIt.instance;
final logger = Logger(level: Level.debug);

Future<void> init() async {
  injector.allowReassignment = true;
  networkModule.setup(injector);
  repositoryModule.setup(injector);
  blocModule.setup(injector);
}
