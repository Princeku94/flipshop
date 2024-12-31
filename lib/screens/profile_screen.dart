import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flipshop/utils/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import '../components/textfield_widget.dart';
import '../config/routes/routes_name.dart';
import '../utils/constants.dart';
import '../utils/form_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.greyColor,
      appBar: getAppBar(
        title: 'Profile',
        context: context,
        actions: [
          IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  dialogBox(
                      context: context,
                      title: 'Profile Saved',
                      message: 'Thank you!',
                      positiveOnPress: () {
                        Navigator.pushNamed(context, RoutesName.homeScreen);

                      },
                      negativeOnPress: () {
                        Navigator.pop(context);

                      });
                }
              },
              icon: Icon(
                Icons.save,
                size: 30,
                color: Colors.blue,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/profile.png',
                  height: 130,
                  width: 130,
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GenderPickerWithImage(
                    showOtherGender: true,
      
                    verticalAlignedText: false,
                    selectedGender: Gender.Male,
                    selectedGenderTextStyle: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF8b32a8),
                        fontWeight: FontWeight.bold),
                    unSelectedGenderTextStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.black38,
                        fontWeight: FontWeight.w500),
                    onChanged: (Gender? gender) {
                      print("choose:$gender");
                    },
                    equallyAligned: true,
                    animationDuration: Duration(milliseconds: 300),
      
                    opacityOfGradient: 0.4,
                    padding: const EdgeInsets.all(3),
                    size: 50, //default : 40
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ...List.generate(
                  controllers.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: CustomTextField(
                        validator: validate[index],
                        controller: controllers[index],
                        hintText: labels[index],
                        keyboardType: textInputTypes[index],
                        lableText: labels[index]),
                  ),
                ),
                CSCPickerPlus(
                  disabledDropdownDecoration:
                      BoxDecoration(color: Colors.black12),
                  layout: Layout.horizontal,
                  countryStateLanguage: CountryStateLanguage.englishOrNative,
                  onCountryChanged: (value) {
                    
                  },
                  onStateChanged: (value) {
                   
                  },
                  onCityChanged: (value) {
                    
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
