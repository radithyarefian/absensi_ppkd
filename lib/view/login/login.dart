import 'dart:developer';
import 'package:absensi_ppkd/api/login.dart';
import 'package:absensi_ppkd/extensions/app_color.dart';
import 'package:absensi_ppkd/extensions/navigator.dart';
import 'package:absensi_ppkd/models/login_model.dart';
import 'package:absensi_ppkd/models/preference.dart';
import 'package:absensi_ppkd/view/login/forgot_password.dart';
import 'package:absensi_ppkd/view/login/register.dart';
import 'package:absensi_ppkd/widgets/custom_button_login.dart';
import 'package:absensi_ppkd/widgets/custom_button_register.dart';
import 'package:absensi_ppkd/widgets/custom_textfield.dart';
import 'package:absensi_ppkd/widgets/navbar.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isVisibility = true;
  bool isLoading = false;
  bool isCheckingSession = true;

  @override
  void initState() {
    super.initState();
    _checkSavedLogin();
  }

  Future<void> _checkSavedLogin() async {
    final isLogin = await PreferenceHandler.getIsLogin();
    final token = await PreferenceHandler.getToken();

    if (!mounted) return;

    if (isLogin == true && (token?.isNotEmpty ?? false)) {
      _goToHomeAfterFrame();
      return;
    }

    setState(() {
      isCheckingSession = false;
    });
  }

  void _goToHomeAfterFrame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.pushAndRemoveAll(const Navbar());
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      isVisibility = !isVisibility;
    });
  }

  Future<void> _persistLoginSession(LoginModel? login, String token) async {
    if (token.isEmpty) return;

    await PreferenceHandler().storingToken(token);
    await PreferenceHandler().storingIsLogin(true);

    final createdAt = login?.data?.user?.createdAt;
    if (createdAt != null) {
      await PreferenceHandler().storingUserCreatedAt(createdAt);
    }
  }

  Future<void> _handleLoginSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    String message = 'Login gagal';
    String token = '';

    try {
      final login = await loginUser(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      token = login?.data?.token ?? '';
      message = login?.message ?? 'Login berhasil';

      await _persistLoginSession(login, token);
    } catch (e) {
      log(e.toString());
      message = e
          .toString()
          .replaceFirst('Exception: ', '')
          .replaceFirst('HttpException: ', '')
          .trim();
    }

    if (!context.mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));

    setState(() {
      isLoading = false;
    });

    if (token.isNotEmpty) {
      context.pushAndRemoveAll(const Navbar());
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isCheckingSession) {
      return Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: Center(
          child: CircularProgressIndicator(
            color: AppColor.login,
            strokeWidth: 3.5,
          ),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF5F5F5),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              /// LOGO
              const SizedBox(height: 5),

              Center(
                child: Image.asset(
                  'assets/images/logo_geopresence.png',
                  height: 280,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 5),

              /// CARD FORM
              Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(24),

                  boxShadow: [
                    BoxShadow(
                      blurRadius: 12,
                      color: Colors.black.withOpacity(0.05),
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),

                child: Form(
                  key: _formKey,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      /// TITLE
                      Center(
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      /// EMAIL
                      CustomTextField(
                        controller: emailController,
                        hintText: 'Email',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        enableSuggestions: false,
                        autocorrect: false,
                        validator: (value) {
                          final email = (value ?? '').trim();

                          if (email.isEmpty) {
                            return 'Email tidak boleh kosong';
                          }

                          if (!email.contains('@')) {
                            return 'Email tidak valid';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      /// PASSWORD
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'Kata Sandi',
                        prefixIcon: Icons.lock_outline,
                        obscureText: isVisibility,
                        enableSuggestions: false,
                        autocorrect: false,

                        suffixIcon: InkWell(
                          onTap: _togglePasswordVisibility,
                          child: Icon(
                            size: 20,
                            isVisibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),

                        validator: (value) {
                          if ((value ?? '').isEmpty) {
                            return 'Kata sandi tidak boleh kosong';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      /// BUTTON LOGIN
                      CustomButtonLogin(
                        text: 'Masuk',
                        isLoading: isLoading,
                        onPressed: _handleLoginSubmit,
                      ),

                      const SizedBox(height: 14),

                      /// FORGOT PASSWORD
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            context.push(const ForgotPassword());
                          },
                          child: Text(
                            'Lupa kata sandi?',
                            style: TextStyle(
                              color: AppColor.login,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// REGISTER LINK
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Belum punya akun? ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.push(const Register());
                    },
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        color: AppColor.login,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
