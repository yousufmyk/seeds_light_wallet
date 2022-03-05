import 'package:flutter/material.dart';
import 'package:seeds/components/flat_button_long.dart';
import 'package:seeds/design/app_theme.dart';
import 'package:seeds/domain-shared/ui_constants.dart';
import 'package:seeds/screens/create_region_screens/add_region_background_image/components/upload_picture_box.dart';
import 'package:seeds/utils/build_context_extension.dart';

class AddRegionBackgroundImage extends StatelessWidget {
  const AddRegionBackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(context.loc.createRegionSelectRegionAppBarTitle),
        ),
        bottomNavigationBar: SafeArea(
          minimum: const EdgeInsets.all(horizontalEdgePadding),
          child: FlatButtonLong(title: "${context.loc.createRegionSelectRegionButtonTitle} (4/5)", onPressed: () {}),
        ),
        body: SafeArea(
            minimum: const EdgeInsets.all(horizontalEdgePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            UploadPictureBox(
              title: context.loc.createRegionAddBackGroundImageBoxTitle,
              onTap: () {},
            ),
            const SizedBox(height: 26),
            Text(context.loc.createRegionAddBackGroundImageDescription,
                style: Theme.of(context).textTheme.subtitle2OpacityEmphasis),
            Text("${context.loc.createRegionAddBackGroundImageAcceptedFilesTitle}: png//.jpg",
                style: Theme.of(context).textTheme.subtitle2OpacityEmphasis),
          ],
        )));
  }
}