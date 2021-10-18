import 'package:flutter/material.dart';
import 'package:khao_thi_gv/FIS.SYS/Components/ComponentsBase.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Icon.dart';
import 'package:khao_thi_gv/FIS.SYS/Skins/Typography.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Colors.dart';
import 'package:khao_thi_gv/FIS.SYS/Styles/Icons.dart';
import 'package:khao_thi_gv/Khao_thi_GV/Screens/M.2.7_Lich_su_danh_gia.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  bool isSwitch = true;

  List<Map<String, dynamic>> tieuChi = [
    {
      'point': 1,
      'title':
          '1.  Thân bài v Đảm bảo đúng cấu trúc bài nghị luận Bài viết đầy đủ ba phần: Mở bài, Thân bài và Kết bài; Mở bài và Kết bài có dung lượng cân đối.'
    },
    {'point': 2, 'title': '2. Xác định đúng vấn đề nghị luận'},
    {'point': 2, 'title': '3. Triển khai vấn đề nghị luận'},
  ];
  List<Map<String, dynamic>> tieuChi2 = [
    {
      'title':
          'Bài viết đầy đủ ba phần: Mở bài, Thân bài và Kết bài; Mở bài và Kết bài có dung lượng cân đối.'
    },
    {
      'title':
          'Bài viết đầy đủ ba phần: Mở bài, Thân bài và Kết bài; Mở bài và Kết bài có dung lượng cân đối.'
    },
    {
      'title':
          'Bài viết đầy đủ ba phần: Mở bài, Thân bài và Kết bài; Mở bài và Kết bài có dung lượng cân đối.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: FAppBar(
          headerLead: FIconButton(
            icon: FOutlinedIcons.left,
            backgroundColor: FColors.transparent,
            color: FColors.grey9,
            size: FIconButtonSize.size40,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          headerCenter: Container(
            alignment: Alignment.center,
            child: FText(
              'Đánh giá',
              style: FTextStyle.titleModules3,
            ),
          ),
          headerActions: [
            Container(
              width: 48,
            )
          ],
          backgroundColor: FColors.grey1,
          bottom: TabBar(
            onTap: (value) {},
            indicatorColor: FColors.blue6,
            labelColor: FColors.blue6,
            unselectedLabelColor: FColors.grey7,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(
                child: Text(
                  'Đánh giá',
                ),
              ),
              Tab(
                child: Text(
                  'Lịch sử đánh giá',
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                color: FColors.grey3,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      color: FColors.grey1,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FText(
                                  'Tiểu học - Phẩm chất chăm học, chăm làm',
                                  style: FTextStyle.titleModules6,
                                  maxLines: 2,
                                ),
                                FText(
                                  'Mã: TTNNJJ',
                                  style: FTextStyle.subtitle2,
                                  color: FColors.blue6,
                                )
                              ],
                            ),
                          ),
                          FButton(
                            title: 'Thay đổi',
                            color: FColors.blue6,
                            backgroundColor: FColors.grey1,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: FColors.transparent,
                                builder: (BuildContext context) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 24.0),
                                    child: SingleChildScrollView(
                                      child: StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter mystate) {
                                        return FBottomSheet(
                                          header: FModal(
                                            title: Column(
                                              children: [
                                                FText('Chọn Rubric',
                                                    style: FTextStyle
                                                        .titleModules3),
                                                FText('Lớp 10A6',
                                                    style:
                                                        FTextStyle.subtitle2),
                                              ],
                                            ),
                                            textAction: FButton(
                                              size: FButtonSize.size40,
                                              title: 'xong',
                                              color: FColors.blue6,
                                              backgroundColor: FColors.grey1,
                                              onPressed: () {},
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                          ),
                                          body: Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            padding: EdgeInsets.all(16),
                                            color: FColors.grey1,
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      color: FColors.grey1,
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FText(
                                  'Phạm Hoàng Ngọc Anh',
                                  style: FTextStyle.titleModules6,
                                  maxLines: 2,
                                ),
                                FText(
                                  'Mã: AGNTK21',
                                  style: FTextStyle.subtitle2,
                                  color: FColors.blue6,
                                ),
                                SizedBox(height: 12),
                                Container(
                                  width: 110,
                                  child: FTag(
                                    title: 'Điểm: 6.00',
                                    leftIcon: FOutlinedIcons.star,
                                    color: FColors.red6,
                                    backgroundColor: FColors.red1,
                                  ),
                                )
                              ],
                            ),
                          ),
                          FButton(
                            title: 'Thay đổi',
                            color: FColors.blue6,
                            backgroundColor: FColors.grey1,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                backgroundColor: FColors.transparent,
                                builder: (BuildContext context) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 24.0),
                                    child: SingleChildScrollView(
                                      child: StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter mystate) {
                                        return FBottomSheet(
                                          mainAxisSize: MainAxisSize.max,
                                          header: FModal(
                                            title: Column(
                                              children: [
                                                FText('Chọn học sinh',
                                                    style: FTextStyle
                                                        .titleModules3),
                                                FText(
                                                  '15 học sinh',
                                                  style: FTextStyle.subtitle2,
                                                  color: FColors.grey6,
                                                ),
                                              ],
                                            ),
                                            textAction: FButton(
                                              size: FButtonSize.size40,
                                              title: 'xong',
                                              color: FColors.blue6,
                                              backgroundColor: FColors.grey1,
                                              onPressed: () {},
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                          ),
                                          body: Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            padding: EdgeInsets.all(16),
                                            color: FColors.grey1,
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 12),
                      color: FColors.grey1,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FText(
                                  'Tiêu chí đánh giá',
                                  style: FTextStyle.titleModules5,
                                ),
                                FButton(
                                  title: 'Nhận xét',
                                  color: FColors.blue6,
                                  backgroundColor: FColors.grey1,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onPressed: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      backgroundColor: FColors.transparent,
                                      builder: (BuildContext context) {
                                        return Container(
                                          color: FColors.grey1,
                                          margin: EdgeInsets.only(top: 24.0),
                                          child: SingleChildScrollView(
                                            child: StatefulBuilder(builder:
                                                (BuildContext context,
                                                    StateSetter mystate) {
                                              return FBottomSheet(
                                                mainAxisSize: MainAxisSize.max,
                                                header: FModal(
                                                  title: FText('Nhận xét',
                                                      style: FTextStyle
                                                          .titleModules3),
                                                ),
                                                body: Container(
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding: EdgeInsets.all(16),
                                                  color: FColors.grey1,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      FText(
                                                        'Nhận xét theo tiêu chí',
                                                        style: FTextStyle
                                                            .titleModules5,
                                                      ),
                                                      SizedBox(height: 8),
                                                      FText(
                                                        'Tiêu chí 1: Đảm bảo đúng cấu trúc bài nghị luận',
                                                        style: FTextStyle
                                                            .titleModules6,
                                                      ),
                                                      SizedBox(height: 8),
                                                      Container(
                                                        height: 98,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: FColors.grey1,
                                                          border: Border.all(
                                                            color:
                                                                FColors.grey4,
                                                            width: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 8),
                                                      FText(
                                                        'Tiêu chí 2: Đảm bảo đúng cấu trúc bài nghị luận.',
                                                        style: FTextStyle
                                                            .titleModules6,
                                                      ),
                                                      SizedBox(height: 8),
                                                      Container(
                                                        height: 98,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: FColors.grey1,
                                                          border: Border.all(
                                                            color:
                                                                FColors.grey4,
                                                            width: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 8),
                                                      FText(
                                                        'Tiêu chí 2: Đảm bảo đúng cấu trúc bài nghị luận.',
                                                        style: FTextStyle
                                                            .titleModules6,
                                                      ),
                                                      SizedBox(height: 8),
                                                      Container(
                                                        height: 98,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: FColors.grey1,
                                                          border: Border.all(
                                                            color:
                                                                FColors.grey4,
                                                            width: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 8),
                                                      FText(
                                                        'Nhận xét',
                                                        style: FTextStyle
                                                            .titleModules5,
                                                      ),
                                                      SizedBox(height: 8),
                                                      Container(
                                                        height: 98,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: FColors.grey1,
                                                          border: Border.all(
                                                            color:
                                                                FColors.grey4,
                                                            width: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 24),
                                                        child: FButton(
                                                          title:
                                                              'Lưu và nhận xét',
                                                          block: true,
                                                          backgroundColor:
                                                              FColors.blue6,
                                                          color: FColors.grey1,
                                                          size: FButtonSize
                                                              .size40,
                                                          onPressed: () {},
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          FDivider(),
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FText(
                                  'Hiển thị đầy đủ thông tin',
                                  style: FTextStyle.titleModules6,
                                ),
                                FSwitch(
                                  value: isSwitch,
                                  onChanged: () {
                                    setState(() {
                                      isSwitch = !isSwitch;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      // height: 148,
                      // height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        itemCount: tieuChi.length,
                        itemBuilder: (context, index) {
                          var item = tieuChi[index];
                          return Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(right: 8),
                            color: FColors.grey1,
                            width: 140,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    FIcon(
                                      icon: FOutlinedIcons.star,
                                      color: [FColors.blue6],
                                    ),
                                    FText(
                                      '${item['point']} Điểm',
                                      style: FTextStyle.subtitle2,
                                      color: FColors.blue6,
                                    )
                                  ],
                                ),
                                FText(
                                  item['title'],
                                  style: FTextStyle.subtitle1,
                                  maxLines: 3,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      height: 230,
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        itemCount: tieuChi.length,
                        itemBuilder: (context, index) {
                          var item = tieuChi2[index];
                          return Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(right: 8),
                            color: FColors.grey1,
                            width: 140,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 110,
                                  child: FTag(
                                    title: 'Xuất sắc 100%',
                                    backgroundColor: FColors.blue1,
                                    color: FColors.blue6,
                                  ),
                                ),
                                SizedBox(height: 8),
                                FText(
                                  item['title'],
                                  style: FTextStyle.subtitle1,
                                  maxLines: 6,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: EvaluationHistory(),
            ),
          ],
        ),
        floatingActionButton: FIconButton(
          icon: FOutlinedIcons.plus,
          backgroundColor: FColors.blue6,
          color: FColors.grey1,
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              backgroundColor: FColors.transparent,
              builder: (BuildContext context) {
                return Container(
                  margin: EdgeInsets.only(top: 24.0),
                  child: SingleChildScrollView(
                    child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter mystate) {
                      return FBottomSheet(
                        mainAxisSize: MainAxisSize.max,
                        header: FModal(
                          title: FText('Chọn tác vụ',
                              style: FTextStyle.titleModules3),
                        ),
                        body: Container(
                          padding: EdgeInsets.all(16),
                          color: FColors.grey1,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  color: FColors.grey3,
                                  padding: EdgeInsets.fromLTRB(16, 12, 0, 12),
                                  child: Row(
                                    children: [
                                      FIcon(
                                        icon: FOutlinedIcons.picture,
                                        color: [FColors.blue6],
                                      ),
                                      SizedBox(width: 12),
                                      FText('Upload ảnh')
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  color: FColors.grey3,
                                  padding: EdgeInsets.fromLTRB(16, 12, 0, 12),
                                  child: Row(
                                    children: [
                                      FIcon(
                                        icon: FOutlinedIcons.file_add,
                                        color: [FColors.blue6],
                                      ),
                                      SizedBox(width: 12),
                                      FText('Upload file')
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  color: FColors.grey3,
                                  padding: EdgeInsets.fromLTRB(16, 12, 0, 12),
                                  child: Row(
                                    children: [
                                      FIcon(
                                        icon: FOutlinedIcons.camera,
                                        color: [FColors.blue6],
                                      ),
                                      SizedBox(width: 12),
                                      FText('Chụp ảnh, quay video')
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
            );
          },
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(left: 12, right: 12),
          color: FColors.grey1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FIconButton(
                icon: FOutlinedIcons.left,
                onPressed: () {},
                backgroundColor: FColors.grey1,
                color: FColors.blue6,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              FButton(
                title: 'Lưu đánh giá',
                color: FColors.red6,
                backgroundColor: FColors.grey1,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        scrollable: true,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FText(
                              'Kết quả đánh giá',
                              style: FTextStyle.titleModules3,
                            ),
                            FText(
                              'Số điểm đạt được',
                              style: FTextStyle.subtitle2,
                            ),
                            FText(
                              'Điểm: 7.00',
                              style: FTextStyle.titleModules2,
                              color: FColors.red6,
                            ),
                          ],
                        ),
                        actions: [
                          FButton(
                            title: 'Đóng',
                            backgroundColor: FColors.grey1,
                            color: FColors.grey7,
                            onPressed: () {},
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          FButton(
                            title: 'Tiếp tục đánh giá',
                            backgroundColor: FColors.blue6,
                            color: FColors.grey1,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {},
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              FIconButton(
                icon: FOutlinedIcons.right,
                backgroundColor: FColors.grey1,
                color: FColors.blue6,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
