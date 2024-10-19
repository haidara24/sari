import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custome_mobile/Localization/app_localizations.dart';
import 'package:custome_mobile/business_logic/bloc/attachment/attachment_type_bloc.dart';
import 'package:custome_mobile/business_logic/bloc/trader_additional_attachment_bloc.dart';
import 'package:custome_mobile/business_logic/cubit/locale_cubit.dart';
import 'package:custome_mobile/data/models/attachments_models.dart';
import 'package:custome_mobile/data/models/offer_model.dart';
import 'package:custome_mobile/data/providers/trader_offer_provider.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/widgets/custom_app_bar.dart';
import 'package:custome_mobile/views/widgets/custom_botton.dart';
import 'package:custome_mobile/views/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class BrokerAttachmentsScreen extends StatefulWidget {
  final int offerId;
  final String offerState;

  const BrokerAttachmentsScreen(
      {Key? key, required this.offerId, required this.offerState})
      : super(key: key);

  @override
  State<BrokerAttachmentsScreen> createState() =>
      _BrokerAttachmentsScreenState();
}

class _BrokerAttachmentsScreenState extends State<BrokerAttachmentsScreen> {
  List<AttachmentType> attachmentTypes = [];
  TraderOfferProvider? trader_offerProvider;
  final TextEditingController _otherAttachmentController =
      TextEditingController();
  File? _image;
  List<File>? _images = [];
  List<File>? _files = [];
  final ImagePicker _picker = ImagePicker();

  bool additionalattachmentsucees = false;

  int additionalattachmentId = 0;

  List<int> attachmentIds = [];

  List<int> additionalattachmentIds = [];

  List<Attachment> attachments = [];
  List<int> attachmentsId = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      trader_offerProvider =
          Provider.of<TraderOfferProvider>(context, listen: false);
    });
    _otherAttachmentController.text = "";
  }

  String attachmentName(int attachmentType) {
    for (var element in attachmentTypes) {
      if (element.id! == attachmentType) {
        return element.name!;
      }
    }
    return "attachment";
  }

  List<Widget> _buildAttachmentImages(List<AttachmentImage>? images) {
    List<Widget> list = [];
    var restofImagesNum = 0;
    var tempimages = images!.removeAt(0);
    if (images != null) {
      for (var i = 0; i < images!.length; i++) {
        if (i < 3) {
          var elem = Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
            ),
            width: 58.w,
            height: 68.h,
            child: Image.network(
                width: 58.w, height: 68.h, fit: BoxFit.fill, images![i].image!),
          );
          list.add(elem);
        } else {
          restofImagesNum = images!.length - 3;
          var elem = Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                width: 58.w,
                height: 68.h,
                child: Image.network(
                    width: 58.w,
                    height: 68.h,
                    fit: BoxFit.fill,
                    images![i].image!),
              ),
              Container(
                color: Colors.white70,
                width: 58.w,
                height: 68.h,
                child: Center(
                  child: Text(
                    "+$restofImagesNum",
                    style: TextStyle(color: AppColor.deepBlue, fontSize: 18.sp),
                  ),
                ),
              ),
            ],
          );
          list.add(elem);
          break;
        }
      }
    }
    return list;
  }

  Widget _buildAttachmentItem(Attachment attachment) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              attachment.image!.length == 1
                  ? Container(
                      margin: EdgeInsets.all(5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColor.deepAppBarBlue,
                          width: 1.0,
                        ),
                      ),
                      height: 140.h,
                      width: 245.w,
                      clipBehavior: Clip.antiAlias,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          height: 137.h,
                          width: 120.w,
                          child: Image.network(
                              fit: BoxFit.fill, attachment.image![0].image!),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              attachment.image!.isEmpty
                  ? Container(
                      margin: EdgeInsets.all(5.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColor.deepAppBarBlue,
                          width: 1.0,
                        ),
                      ),
                      height: 140.h,
                      width: 245.w,
                      clipBehavior: Clip.antiAlias,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: SizedBox(
                          height: 137.h,
                          width: 120.w,
                          child:
                              const Center(child: Text("there are no Images")),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              attachment.image!.length > 1
                  ? Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: AppColor.deepAppBarBlue,
                              width: 1.0,
                            ),
                          ),
                          height: 140.h,
                          width: 120.w,
                          clipBehavior: Clip.antiAlias,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: SizedBox(
                              height: 137.h,
                              width: 120.w,
                              child: Image.network(
                                  fit: BoxFit.fill,
                                  attachment.image![0].image!),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          margin: EdgeInsets.all(5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: AppColor.deepAppBarBlue,
                              width: 1.0,
                            ),
                          ),
                          height: 140.h,
                          width: 120.w,
                          clipBehavior: Clip.antiAlias,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: SizedBox(
                              height: 137.h,
                              width: 120.w,
                              child: Wrap(
                                children:
                                    _buildAttachmentImages(attachment.image!),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                width: 5.w,
              ),
              SizedBox(
                width: 100.w,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    attachment.attachmentType!.name!,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildAttachmentslist(List<Attachment> attachments) {
    List<Widget> list = [];
    for (var element in attachments) {
      var elem = Column(
        children: [
          Container(
            margin: EdgeInsets.all(5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: AppColor.deepAppBarBlue,
                width: 1.0,
              ),
            ),
            height: 140.h,
            width: 120.w,
            clipBehavior: Clip.antiAlias,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 137.h,
                width: 120.w,
                child: Wrap(children: _buildAttachmentImages(element.image)),
              ),
            ),
          ),
          SizedBox(
            width: 120.w,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                element.attachmentType!.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
      list.add(elem);
    }
    return list;
  }

  // Widget _buildAttachmentItem(Attachment attachment){

  // }

  List<Widget> _buildAttachmentsTypelist(
      List<AttachmentType> att, BuildContext context) {
    List<Widget> list = [];
    for (var element in att) {
      if (element.name! == "كافة المستندات") {
        continue;
      }
      var elem = Container(
        margin: EdgeInsets.all(5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColor.deepAppBarBlue,
            width: 1.0,
          ),
        ),
        width: MediaQuery.of(context).size.width * .28,
        height: 150.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .27,
              child:
                  FittedBox(fit: BoxFit.scaleDown, child: Text(element.name!)),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => StatefulBuilder(
                      builder: (context, StateSetter setState2) {
                    return Directionality(
                      textDirection: TextDirection.rtl,
                      child: SimpleDialog(
                        backgroundColor: Colors.white,
                        title: Text(element.name!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: EdgeInsets.all(8.h),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 15.h),
                                child: InkWell(
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Card(
                                        elevation: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: SizedBox(
                                              height: 55.h,
                                              width: 50.w,
                                              child: SvgPicture.asset(
                                                  "assets/icons/pdf_icon.svg"),
                                            ),
                                          ),
                                        ),
                                      ),
                                      _files!.isNotEmpty
                                          ? Positioned(
                                              right: -7.w,
                                              top: -10.h,
                                              child: Container(
                                                height: 25.h,
                                                width: 25.h,
                                                padding:
                                                    const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: AppColor.goldenYellow,
                                                  borderRadius:
                                                      BorderRadius.circular(45),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    _files!.length.toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox.shrink()
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 15.h),
                                child: InkWell(
                                  onTap: () async {
                                    var pickedImages =
                                        await _picker.pickMultiImage();
                                    for (var element in pickedImages) {
                                      _images!.add(File(element!.path));
                                    }
                                    setState2(
                                      () {},
                                    );
                                  },
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Card(
                                        elevation: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: SizedBox(
                                              height: 55.h,
                                              width: 50.w,
                                              child: SvgPicture.asset(
                                                  "assets/icons/photo_icon.svg"),
                                            ),
                                          ),
                                        ),
                                      ),
                                      _images!.isNotEmpty
                                          ? Positioned(
                                              right: -7.w,
                                              top: -10.h,
                                              child: Container(
                                                height: 25.h,
                                                width: 25.h,
                                                padding:
                                                    const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: AppColor.goldenYellow,
                                                  borderRadius:
                                                      BorderRadius.circular(45),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    _images!.length.toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox.shrink()
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // _previewImages(),
                          Visibility(
                            visible: element.number != 200,
                            child: const SizedBox(
                              height: 15,
                            ),
                          ),
                          Visibility(
                            visible: element.number == 200,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 7.h, horizontal: 15.w),
                                child: TextField(
                                  controller: _otherAttachmentController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    labelText: AppLocalizations.of(context)!
                                        .translate('enter_attachment_name'),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  style: const TextStyle(fontSize: 18),
                                )),
                          ),

                          BlocConsumer<TraderAdditionalAttachmentBloc,
                              TraderAdditionalAttachmentState>(
                            listener: (context, state) {
                              if (state
                                      is TraderAdditionalAttachmentLoadedSuccess &&
                                  additionalattachmentsucees) {
                                Navigator.pop(context);

                                additionalattachmentsucees = false;
                                setState2(() {
                                  _images = [];
                                  _files = [];
                                  _otherAttachmentController.text = "";
                                  attachmentsId.add(state.attachment.id!);
                                  attachments.add(state.attachment);
                                });
                                trader_offerProvider!
                                    .addAttachment(state.attachment);
                                trader_offerProvider!
                                    .removeAdditionalAttachment(element);
                              } else {
                                print(state);
                              }
                            },
                            builder: (context, state) {
                              if (state
                                  is TraderAdditionalAttachmentLoadingProgress) {
                                return const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(child: LoadingIndicator()),
                                  ],
                                );
                              } else {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomButton(
                                        title: SizedBox(
                                          width: 90,
                                          child: Center(
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .translate('close'))),
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                        }),
                                    CustomButton(
                                        title: SizedBox(
                                            width: 90,
                                            child: Center(
                                                child: Text(AppLocalizations.of(
                                                        context)!
                                                    .translate('save')))),
                                        onTap: () {
                                          attachmentIds = [];
                                          additionalattachmentIds = [];
                                          for (var element
                                              in trader_offerProvider!
                                                  .attachments) {
                                            attachmentIds.add(element.id!);
                                          }
                                          for (var element
                                              in trader_offerProvider!
                                                  .additionalAttachments) {
                                            additionalattachmentIds
                                                .add(element.id!);
                                          }
                                          BlocProvider.of<
                                                      TraderAdditionalAttachmentBloc>(
                                                  context)
                                              .add(AddAdditionalAttachmentEvent(
                                                  element,
                                                  _images!,
                                                  _files!,
                                                  widget.offerId,
                                                  widget.offerState,
                                                  _otherAttachmentController
                                                      .text,
                                                  attachmentIds,
                                                  trader_offerProvider!
                                                      .additionalAttachments));
                                          additionalattachmentsucees = true;
                                          additionalattachmentId = element.id!;
                                        }),
                                  ],
                                );
                              }
                            },
                          )
                        ],
                      ),
                    );
                  }),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(7),
                height: 75.h,
                width: 75.w,
                child: CachedNetworkImage(imageUrl: element.image!),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 5,
                ),
                SizedBox(
                  height: 25.h,
                  width: 25.w,
                  child: SvgPicture.asset("assets/icons/cloud.svg"),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            )
          ],
        ),
      );
      list.add(elem);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, localeState) {
        return Directionality(
          textDirection: localeState.value.languageCode == 'en'
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
              appBar: CustomAppBar(
                  title: AppLocalizations.of(context)!
                      .translate('attachments_details')),
              backgroundColor: Colors.grey[200],
              body: SingleChildScrollView(
                child: Consumer<TraderOfferProvider>(
                    builder: (context, traderofferProvider, child) {
                  return BlocListener<TraderAdditionalAttachmentBloc,
                      TraderAdditionalAttachmentState>(
                    listener: (context, state) {
                      if (state is TraderAdditionalAttachmentLoadedSuccess &&
                          additionalattachmentsucees) {}
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          )),
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          elevation: 1,
                          color: Colors.blue[100],
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                style: BorderStyle.solid,
                                width: 1,
                                color: AppColor.deepBlue,
                              ),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: SizedBox(
                                height: 137.h,
                                width: 120.w,
                                child:
                                    SvgPicture.asset("assets/icons/cloud.svg"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          )),
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          elevation: 1,
                          color: Colors.white,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 7),
                            width: double.infinity,
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .translate('uploaded_attachments'),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                traderofferProvider.attachments.isEmpty
                                    ? Center(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .translate(
                                                  'no_uploaded_attachments'),
                                        ),
                                      )
                                    : ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: traderofferProvider
                                            .attachments.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return _buildAttachmentItem(
                                              traderofferProvider
                                                  .attachments[index]);
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Card(
                          clipBehavior: Clip.antiAlias,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          )),
                          margin: EdgeInsets.symmetric(horizontal: 10.w),
                          elevation: 1,
                          color: Colors.white,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 7),
                            width: double.infinity,
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.translate(
                                        'additional_required_attachments'),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  traderofferProvider
                                          .additionalAttachments.isEmpty
                                      ? Center(
                                          child: Text(AppLocalizations.of(
                                                  context)!
                                              .translate(
                                                  'no_additional_attachments')),
                                        )
                                      : Wrap(
                                          children: _buildAttachmentsTypelist(
                                              traderofferProvider
                                                  .additionalAttachments,
                                              context)),
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
