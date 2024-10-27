import 'package:chat_app_supabase/utils/common_widgets/custom_text_form_field.dart';
import 'package:chat_app_supabase/utils/regex/regex_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      context.go('/auth-screen/create-user', extra: {
        'name': _nameController.text,
        'phoneNumber': _phoneController.text,
        'email': _emailController.text,
      });
    } else {}
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    if (!RegexUtils.phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  String? validateEmailID(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegexUtils.emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        height: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customTextFormField(
              label: 'Name',
              hintText: 'eg: John Doe',
              controller: _nameController,
              keyboardType: TextInputType.name,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your name' : null,
              textInputAction: TextInputAction.next,
            ),
            customTextFormField(
              label: 'Phone Number',
              hintText: 'eg: 987654321',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: validatePhoneNumber,
              textInputAction: TextInputAction.next,
              maxLength: 10,
            ),
            customTextFormField(
              label: 'Email',
              hintText: 'eg: abc@gmail.com',
              controller: _emailController,
              validator: validateEmailID,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => handleSubmit(),
            ),
            ElevatedButton(
              onPressed: handleSubmit,
              child: const Text("Proceed"),
            ),
          ],
        ),
      ),
    );
  }
}
