import 'package:flutter/material.dart';
import 'package:flutter3_wan_android/res/gaps.dart';

/// 创建日期: 2024/12/06 17:22
/// 作者: Jerry
/// 描述: 列表骨架屏
class ListSkeletonShimmerLoading extends StatelessWidget {
  const ListSkeletonShimmerLoading({
    Key? key,
    this.length = 10,
  }) : super(key: key);

  final int length;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      child: ListView.builder(
        itemCount: length,
        itemBuilder: (context, index) {
          return listItemSkeletonShimmerLoading(context);
        },
      ),
    );
  }

  Widget listItemSkeletonShimmerLoading(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      height: 80.0,
      child: Row(
        children: <Widget>[
          Container(
            width: 100.0,
            height: 100.0,
            color: Colors.grey,
          ),
          Gaps.hGap10,
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 10.0,
                    color: Colors.grey,
                  ),
                  Gaps.vGap10,
                  Container(
                    height: 10.0,
                    color: Colors.grey,
                  ),
                  Gaps.vGap10,
                  Container(
                    height: 10.0,
                    color: Colors.grey,
                  ),
                  Gaps.vGap10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 50.0,
                        height: 10.0,
                        color: Colors.grey,
                      ),
                      Container(
                        width: 70.0,
                        height: 10.0,
                        color: Colors.grey,
                      ),
                      Container(
                        width: 20.0,
                        height: 10.0,
                        color: Colors.grey,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
