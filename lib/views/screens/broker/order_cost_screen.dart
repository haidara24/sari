import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:custome_mobile/business_logic/bloc/cost_bloc.dart';
import 'package:custome_mobile/constants/text_constants.dart';
import 'package:custome_mobile/data/models/offer_model.dart';
import 'package:custome_mobile/data/models/state_custome_agency_model.dart';
import 'package:custome_mobile/helpers/color_constants.dart';
import 'package:custome_mobile/views/widgets/custom_app_bar.dart';
import 'package:custome_mobile/views/widgets/custom_botton.dart';
import 'package:custome_mobile/views/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCostScreen extends StatefulWidget {
  final Offer offer;
  const OrderCostScreen({super.key, required this.offer});

  @override
  State<OrderCostScreen> createState() => _OrderCostScreenState();
}

class _OrderCostScreenState extends State<OrderCostScreen> {
  final TextEditingController _noteController = TextEditingController();
  List<Cost> costs = [];
  List<Widget> _children = [];

  List<TextEditingController> controllers = [];
  List<TextEditingController> labelsControllers = [];
  //the controllers list
  int _count = 0;

  final GlobalKey<FormState> _costformKey = GlobalKey<FormState>();

  @override
  void initState() {
    TextEditingController controller = TextEditingController();
    TextEditingController labelcontroller = TextEditingController();

    labelcontroller.text = "مصروف البيان";
    controllers.add(controller); //adding the current controller to the list
    labelsControllers
        .add(labelcontroller); //adding the current controller to the list

    _children = List.from(_children)
      ..add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: 150.w, child: const Text("مصروف البيان")),
              SizedBox(
                width: 230.w,
                child: TextFormField(
                  controller: controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return TextConstants.emailErrorText;
                    }
                    return null;
                  },
                  onTap: () {
                    controller.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: controller.value.text.length);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: const Text("  أدخل قيمة الرسم"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

    setState(() => ++_count);
    super.initState();
  }

  void _add() {
    TextEditingController controller = TextEditingController();
    TextEditingController labelcontroller = TextEditingController();

    controllers.add(controller); //adding the current controller to the list
    labelsControllers
        .add(labelcontroller); //adding the current controller to the list

    _children = List.from(_children)
      ..add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 150.w,
                child: TextFormField(
                  controller: labelcontroller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return TextConstants.emailErrorText;
                    }
                    return null;
                  },
                  onTap: () {
                    labelcontroller.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: labelcontroller.value.text.length);
                  },
                  decoration: InputDecoration(
                    label: const Text("أدخل وصف الرسم"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
              SizedBox(
                width: 230.w,
                child: TextFormField(
                  controller: controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return TextConstants.emailErrorText;
                    }
                    return null;
                  },
                  onTap: () {
                    controller.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: controller.value.text.length);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: const Text("أدخل قيمة الرسم"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    setState(() => ++_count);
  }

  @override
  void dispose() {
    controllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(title: "طلبات تخليص"),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 7.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'رقم العملية: ${widget.offer.id!}',
                        style: TextStyle(
                            color: AppColor.lightBlue,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text('ادخل الرسوم والمصاريف الخاصة بك'),
                      Form(
                        key: _costformKey,
                        child: ListView(
                          shrinkWrap: true,
                          children: _children,
                        ),
                      ),
                      GestureDetector(
                        onTap: _add,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "أضف ",
                            style: TextStyle(
                                color: AppColor.lightBlue,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 280.h - (controllers.length * 55) > 0
                    ? 280.h - (controllers.length * 55)
                    : 10,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 7.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _noteController,
                        maxLines: 4,
                        onTap: () => _noteController.selection = TextSelection(
                            baseOffset: 0,
                            extentOffset: _noteController.value.text.length),
                        // keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "رد على التاجر",
                          prefixStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                    onTap: () {},
                    title: const SizedBox(
                        width: 100, child: Center(child: Text("إلغاء"))),
                  ),
                  BlocConsumer<CostBloc, CostState>(
                    listener: (context, state) {
                      if (state is CostListLoadedSuccess) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppColor.deepYellow,
                            content: Text("تم إدخال التكاليف بنجاح."),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                      if (state is CostLoadedFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red[300],
                            content: Text(
                                "حدث خطأ أثناء إرسال التكاليف الرجاء المحاولة مرة أخرى.\n اذا تكرر هذا الخطأ الرجاء التواصل معنا لحل هذا الخطأ."),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is CostListLoadingProgress) {
                        return CustomButton(
                          onTap: () {},
                          title: SizedBox(
                              width: 250.w,
                              child: const Center(child: LoadingIndicator())),
                        );
                      } else {
                        return CustomButton(
                          onTap: () {
                            if (_costformKey.currentState!.validate()) {
                              costs = [];
                              for (var i = 0; i < controllers.length; i++) {
                                costs.add(Cost.fromJson({
                                  "description": labelsControllers[i].text,
                                  "amount": double.parse(controllers[i].text),
                                  "offer": widget.offer.id,
                                }));
                              }
                              BlocProvider.of<CostBloc>(context)
                                  .add(CostSubmitEvent(costs));
                            }
                          },
                          title: SizedBox(
                              width: 250.w,
                              child: const Center(
                                  child: Text("قبول وإرسال التكاليف"))),
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
