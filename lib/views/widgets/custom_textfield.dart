// import 'package:flutter/material.dart';

// class CustomTextField extends StatefulWidget {
//   final String title;
//   final String hintText;
//   final String? Function(String?) validatorFn;
//   final Function(String?) onSavedFn;
//   final String initialValue;
//   final TextEditingController controller;
//   final TextInputType? keyboardType;
//   final bool obscureText;

//   const CustomTextField({
//     required this.title,
//     required this.hintText,
//     required this.controller,
//     required this.validatorFn,
//     required this.onSavedFn,
//     this.initialValue = '',
//     this.keyboardType,
//     this.obscureText = false,
//     Key? key,
//   }) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _CustomTextFieldState createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   final focusNode = FocusNode();
//   bool stateObscureText = false;

//   @override
//   void initState() {
//     super.initState();

//     focusNode.addListener(
//       () {
//         setState(() {
//           if (focusNode.hasFocus) {}
//         });
//       },
//     );

//     stateObscureText = widget.obscureText;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _createHeader(),
//           const SizedBox(height: 5),
//           _createTextFieldStack(),
//         ],
//       ),
//     );
//   }

//   Widget _createHeader() {
//     return Text(
//       widget.title,
//       style: const TextStyle(
//         color: ColorConstants.primaryColor,
//         fontSize: 14,
//         fontWeight: FontWeight.w500,
//       ),
//     );
//   }

//   Widget _createTextFieldStack() {
//     return Stack(
//       children: [
//         _createTextField(),
//         if (widget.obscureText) ...[
//           Positioned(
//             left: 0,
//             bottom: 0,
//             top: 0,
//             child: _createShowEye(),
//           ),
//         ],
//       ],
//     );
//   }

//   Widget _createTextField() {
//     return TextFormField(
//       focusNode: focusNode,
//       keyboardType: widget.keyboardType,
//       obscureText: widget.obscureText,
//       initialValue: widget.initialValue,
//       validator: widget.validatorFn,
//       onSaved: widget.onSavedFn,
//       style: const TextStyle(
//         color: ColorConstants.textBlack,
//         fontSize: 16,
//       ),
//       decoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: BorderSide(
//             color: ColorConstants.textFieldBorder.withOpacity(0.4),
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10.0),
//           borderSide: const BorderSide(
//             color: ColorConstants.primaryColor,
//           ),
//         ),
//         hintText: widget.hintText,
//         hintStyle: const TextStyle(
//           color: ColorConstants.grey,
//           fontSize: 16,
//         ),
//         filled: true,
//         fillColor: ColorConstants.textFieldBackground,
//       ),
//     );
//   }

//   Widget _createShowEye() {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           stateObscureText = !stateObscureText;
//         });
//       },
//       child: Image(
//         image: const AssetImage('assets/images/eye_icon.png'),
//         color: widget.controller.text.isNotEmpty
//             ? ColorConstants.primaryColor
//             : ColorConstants.grey,
//       ),
//     );
//   }
// }
