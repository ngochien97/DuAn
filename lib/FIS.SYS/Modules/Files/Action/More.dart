import 'package:Framework/FIS.SYS/Components/ComponentsBase.dart';
import 'package:Framework/FIS.SYS/Skins/Icon.dart';
import 'package:Framework/FIS.SYS/Skins/Skin_FDA.Thue/SkinColors.dart';
import 'package:Framework/FIS.SYS/Skins/Typography.dart';
import 'package:Framework/FIS.SYS/Styles/Icons.dart';
import 'package:Framework/FIS.SYS/Styles/StyleBase.dart';
import 'package:flutter/material.dart';

more(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) => FBottomSheet(
            header: FModal(
              textAction: SizedBox(
                width: 50,
              ),
              title: FText(
                'Tác vụ',
                style: FTextStyle.buttonText1,
              ),
            ),
            body: Container(
              color: SkinColor.backGroundSearch,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  FListTitle(
                    avatar: FBoundingBox(
                      backgroundColor: SkinColor.backStatus,
                      size: FBoxSize.size32x32,
                      type: FBoundingBoxType.circle,
                      child: FIcon(
                        icon: FOutlinedIcons.reload,
                        size: 20,
                        color: [SkinColor.status],
                      ),
                    ),
                    dividerIndent: true,
                    title: FText('Nhận dạng lại hoá đơn'),
                  ),
                  FSpacer.space16px,
                  FListTitle(
                    avatar: FBoundingBox(
                      backgroundColor: SkinColor.backStatus,
                      size: FBoxSize.size32x32,
                      type: FBoundingBoxType.circle,
                      child: FIcon(
                        icon: FOutlinedIcons.share_alt,
                        size: 20,
                        color: [SkinColor.status],
                      ),
                    ),
                    dividerIndent: true,
                    title: FText('Chia sẻ'),
                    action: [],
                  ),
                  FSpacer.space16px,
                  FListTitle(
                    avatar: FBoundingBox(
                      backgroundColor: SkinColor.backStatus,
                      size: FBoxSize.size32x32,
                      type: FBoundingBoxType.circle,
                      child: FIcon(
                        icon: FOutlinedIcons.font_colors,
                        size: 20,
                        color: [SkinColor.status],
                      ),
                    ),
                    dividerIndent: true,
                    title: FText('Đổi tên'),
                    action: [],
                  ),
                  FSpacer.space16px,
                  FListTitle(
                    avatar: FBoundingBox(
                      backgroundColor: SkinColor.backStatus,
                      size: FBoxSize.size32x32,
                      type: FBoundingBoxType.circle,
                      child: FIcon(
                        icon: FOutlinedIcons.swap,
                        size: 20,
                        color: [SkinColor.status],
                      ),
                    ),
                    title: FText('Move location'),
                    action: [],
                  ),
                  FSpacer.space16px,
                  FListTitle(
                    avatar: FBoundingBox(
                      backgroundColor: SkinColor.backIconDelete,
                      size: FBoxSize.size32x32,
                      type: FBoundingBoxType.circle,
                      child: FIcon(
                        icon: FFilledIcons.delete,
                        size: 20,
                        color: [SkinColor.IconDelete],
                      ),
                    ),
                    title: FText('Xoá File'),
                    action: [],
                  ),
                ],
              ),
            ),
          ));
}
