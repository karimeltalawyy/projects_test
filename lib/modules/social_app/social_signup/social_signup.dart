import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/layout/social_app/social_layout.dart';
import 'package:test_one/modules/basics/login/cubit/cubit.dart';
import 'package:test_one/modules/basics/login/cubit/states.dart';
import 'package:test_one/layout/shop_app/shop_app_layout.dart';
import 'package:test_one/modules/shop_app/login/shop_login.dart';
import 'package:test_one/modules/shop_app/signup/cubit/cubit.dart';
import 'package:test_one/modules/shop_app/signup/cubit/states.dart';
import 'package:test_one/modules/social_app/social_login/social_login_screen.dart';
import 'package:test_one/modules/social_app/social_signup/cubit/cubit.dart';
import 'package:test_one/shared/component/components/components.dart';
import 'package:test_one/shared/network/local/cache_helper.dart';

import '../../../shared/component/constants/constants.dart';
import 'cubit/states.dart';

class SocialSignUpScreen extends StatelessWidget {
  SocialSignUpScreen({super.key});

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
         if(state is SocialCreateUserSuccessState){
           navigateAndFinish(context, const SocialLayout());
         }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Create Account',
                              style: TextStyle(
                                fontSize: 32,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Welcome, Create New Account to communicate.',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Satoshi medium',
                                fontWeight: FontWeight.w300,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 46),
                            defaultFormFeild(
                              onTap: () {
                                print('Name entered');
                              },
                              controller: nameController,
                              type: TextInputType.name,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'You must add valid name';
                                }
                              },
                              label: 'Name',
                              hint: 'eg.mark',
                              prefix: Icons.person,
                            ),
                            const SizedBox(height: 16),
                            defaultFormFeild(
                              onTap: () {
                                print('Email entered');
                              },
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'You must add email address';
                                }
                              },
                              label: 'Email Address',
                              hint: 'Enter email address',
                              prefix: Icons.email_outlined,
                            ),
                            const SizedBox(height: 16),
                            defaultFormFeild(
                              onTap: () {
                                print('phone entered');
                              },
                              controller: phoneController,
                              type: TextInputType.number,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'You must add valid phone';
                                }
                              },
                              label: 'Phone',
                              hint: 'eg. +123456789',
                              prefix: Icons.phone,
                            ),
                            const SizedBox(height: 16),
                            defaultFormFeild(
                              onTap: () {
                                print('password entered');
                              },
                              isPassword: SocialRegisterCubit.get(context)
                                  .isPasswordShown,
                              controller: passwordController,
                              type: TextInputType.number,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'You must add correct password';
                                }
                              },
                              label: 'Password',
                              hint: 'Enter your password',
                              prefix: Icons.lock_outline_rounded,
                              sufix: SocialRegisterCubit.get(context).suffix,
                              suffixPressed: () {
                                SocialRegisterCubit.get(context)
                                    .changePassordVisibility();
                              },
                            ),
                            const SizedBox(height: 26),
                            ConditionalBuilder(
                              condition: state is! SocialRegisterLoadingState,
                              builder: (context) => defaultButton(
                                text: 'Create Account',
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    SocialRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                              ),
                              fallback: (context) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    fontFamily: 'Satoshi medium',
                                  ),
                                ),
                                defaultTextButton(
                                  function: () {
                                    navigateAndFinish(context, SocialAppLogin());
                                  },
                                  text: 'LOGIN',
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}