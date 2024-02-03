import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:modney_flutter_boilerplate/features/home/blocs/bloc/home_bloc.dart';
import 'package:modney_flutter_boilerplate/features/home/widgets/image_slide.dart';
import 'package:modney_flutter_boilerplate/modules/dependency_injection/di.dart';
import 'package:modney_flutter_boilerplate/theme/text/app_text_theme.dart';
import 'package:modney_flutter_boilerplate/utils/methods/aliases.dart';
import 'package:modney_flutter_boilerplate/utils/methods/shortcuts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class TaggedContainer extends StatefulWidget {
  TaggedContainer(
      {super.key, required this.title, this.callbackOn, this.callbackOff});

  String title;
  // late WebViewXController webviewCtrl;
  void Function()? callbackOn;
  void Function()? callbackOff;

  @override
  _TaggedContainerState createState() => _TaggedContainerState();
}

class _TaggedContainerState extends State<TaggedContainer> {
  List<String>? _areas = [];
  String? _selected;
  List<String>? _images = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    // widget.webviewCtrl?.setIgnoreAllGestures(true);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // widget.webviewCtrl?.setIgnoreAllGestures(false);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (widget.title == "교차로") {
          _areas = state.kcrAreas ?? [];
          _images = state.kcrImages ?? [];
        }
        if (widget.title == "벼룩시장") {
          _areas = state.brAreas ?? [];
          _images = state.brImages ?? [];
        }
        logIt.debug('title : ${widget.title} $_images  $_areas');

        return Container(
          width: MediaQuery.of(context).size.width / 2 - 30.w,
          height: 200.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 45.w,
                    height: 25.h,
                    child: Center(
                        child: Text(
                      '${widget.title}',
                      style: getTextTheme(context).caption2Bold,
                    )),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFDFDFDF)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w),
                    padding: EdgeInsets.only(left: 5),
                    width: 80.w,
                    height: 25.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      // color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFDFDFDF)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    child: Center(
                      child: DropdownButton(
                        alignment: AlignmentDirectional.centerStart,
                        value: _selected == null
                            ? _areas!.length > 0
                                ? _areas![0]
                                : null
                            : null,
                        isExpanded: true,
                        items: _areas!.isEmpty
                            ? []
                            : _areas!.map((e) {
                                return DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style:
                                          getTextTheme(context).caption1Regular,
                                    ));
                              }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selected = value.toString();
                            });

                            if (widget.title == '교차로') {
                              getIt<HomeBloc>().add(HomeEvent.LoadImagesKCR(
                                  area: value.toString()));
                            } else if (widget.title == '벼룩시장') {
                              getIt<HomeBloc>().add(HomeEvent.LoadImageBR(
                                  area: value.toString()));
                            }
                          }
                        },
                        underline: SizedBox.shrink(),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 150.h,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: Color(0xFFA9A9A9)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                child: ImageSlide(
                  urls: _images,
                  callbackOff: widget.callbackOff,
                  callbackOn: widget.callbackOn,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
