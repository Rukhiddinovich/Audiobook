import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uic_task/bloc/audiobook_bloc.dart';
import 'package:uic_task/data/model/audiobook_model.dart';
import 'package:uic_task/ui/screens/audiobook_screen/widgets/audio_controller_row_widgets.dart';
import 'package:uic_task/ui/screens/audiobook_screen/widgets/audio_info_widgets.dart';
import 'package:uic_task/ui/screens/audiobook_screen/widgets/icon_button_widgets.dart';
import 'package:uic_task/ui/screens/audiobook_screen/widgets/position_data_class.dart';
import 'package:uic_task/ui/screens/audiobook_screen/widgets/slider_text_widget.dart';
import 'package:uic_task/ui/screens/widgets/global_appbar_widget.dart';
import 'package:uic_task/utils/color.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uic_task/utils/constants.dart';

part 'audiobook_screen.dart';