import 'package:flutter/material.dart';
import 'package:letsdo/models/settings.dart';
import 'package:letsdo/models/task_data.dart';
import 'package:letsdo/widgets/task_list.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:provider/provider.dart';

class BottomContainer extends StatefulWidget {
  @override
  _BottomContainerState createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  var _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Provider.of<Settings>(context).currentSecondaryColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(17.0),
          topLeft: Radius.circular(17.0),
        ),
      ),
      child: Stack(
        children: <Widget>[
          PageView.builder(
            itemCount: Provider.of<TaskData>(context).taskPageCount,
            itemBuilder: (context, curIndex) {
              /// to view the newly added page first, we have to do this.
              int reversedPage =
                  Provider.of<TaskData>(context, listen: false).taskPageCount -
                      curIndex -
                      1;
              return TaskList(
                pageNo: reversedPage,
              );
            },
            onPageChanged: (int index) {
              /// to set the actual current page.
              int reversedPage =
                  Provider.of<TaskData>(context, listen: false).taskPageCount -
                      index -
                      1;

              Provider.of<TaskData>(context, listen: false)
                  .updateCurrentPage(reversedPage);

              _currentPageNotifier.value = index;
              print(index);
            },
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: PageViewIndicator(
              pageIndexNotifier: _currentPageNotifier,
              length: Provider.of<TaskData>(context).taskPageCount,
              indicatorPadding: EdgeInsets.all(4.0),
              normalBuilder: (animationController, index) => Circle(
                size: 8.0,
                color: Colors.grey.shade400,
              ),
              highlightedBuilder: (animationController, index) =>
                  ScaleTransition(
                scale: CurvedAnimation(
                  parent: animationController,
                  curve: Curves.ease,
                ),
                child: Circle(
                  size: 8.0,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
