import 'package:bloc/bloc.dart';
import 'package:chat_app_itsharks_25/services/cache_helper/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  
  static SettingsCubit get(context)=>BlocProvider.of(context);

  late bool isDark;
  void loadThemeFromCache(){
    bool? fromCache = SharedPreferencesHelper.getData(key: "isDark");
    if(fromCache == null) {
      isDark = false;
    }
    else {
      isDark = fromCache;
    }
    emit(LoadThemeFromCache());
  }

  void changeTheme()async{
    isDark = !isDark;
    await SharedPreferencesHelper.saveData(key: "isDark", value: isDark);
    emit(ChangeTheme());
  }
}
