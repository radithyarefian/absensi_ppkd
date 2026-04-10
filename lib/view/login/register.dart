import 'dart:developer';

import 'package:absensi_ppkd/api/batch.dart';
import 'package:absensi_ppkd/api/register.dart';
import 'package:absensi_ppkd/extensions/navigator.dart';
import 'package:absensi_ppkd/models/batch_model.dart';
import 'package:absensi_ppkd/models/training_model.dart';
import 'package:absensi_ppkd/view/login/login.dart';
import 'package:absensi_ppkd/widgets/custom_button_register.dart';
import 'package:absensi_ppkd/widgets/custom_dropdown_field.dart';
import 'package:absensi_ppkd/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<Register> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final GlobalKey<State<CustomDropdownField<int>>> _trainingDropdownKey =
      GlobalKey();
  late final GlobalKey<State<CustomDropdownField<int>>> _batchDropdownKey =
      GlobalKey();
  late final GlobalKey<State<CustomDropdownField<String>>> _genderDropdownKey =
      GlobalKey();

  bool isVisibility = true;
  bool isLoading = false;
  bool isLoadingOptions = true;

  List<BatchOptionItem> batches = const [];
  List<DropdownMenuItem<int>> trainingMenuItems = const [];
  List<DropdownMenuItem<int>> batchMenuItems = const [];
  int? selectedTrainingId;
  int? selectedBatchId;
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    _loadDropdownOptions();
  }

  void _togglePasswordVisibility() {
    setState(() {
      isVisibility = !isVisibility;
    });
  }

  List<DropdownMenuItem<int>> _buildMenuItems<T>(
    List<T> items, {
    required int? Function(T item) idSelector,
    required String Function(T item) labelSelector,
  }) {
    return items
        .map(
          (item) => DropdownMenuItem<int>(
            value: idSelector(item),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(labelSelector(item)),
            ),
          ),
        )
        .toList();
  }

  List<TrainingOptionItem> _getTrainingsByBatch(int? batchId) {
    if (batchId == null) return const [];

    for (final batch in batches) {
      if (batch.id == batchId) {
        return batch.trainings;
      }
    }

    return const [];
  }

  void _handleBatchChanged(int? batchId) {
    final nextTrainings = _getTrainingsByBatch(batchId);

    final isSelectedTrainingStillAvailable = nextTrainings.any(
      (item) => item.id == selectedTrainingId,
    );

    setState(() {
      selectedBatchId = batchId;

      trainingMenuItems = _buildMenuItems<TrainingOptionItem>(
        nextTrainings,
        idSelector: (item) => item.id,
        labelSelector: (item) => item.label,
      );

      if (!isSelectedTrainingStillAvailable) {
        selectedTrainingId = null;
      }
    });
  }

  Future<void> _loadDropdownOptions() async {
    setState(() {
      isLoadingOptions = true;
    });

    try {
      final loadedBatches = await getBatches();

      if (!mounted) return;

      setState(() {
        batches = loadedBatches;

        batchMenuItems = _buildMenuItems<BatchOptionItem>(
          batches,
          idSelector: (item) => item.id,
          labelSelector: (item) => item.label,
        );

        trainingMenuItems = const [];
      });
    } catch (e) {
      _showMessage('Gagal memuat pilihan training/batch. Silakan coba lagi.');
    } finally {
      if (mounted) {
        setState(() {
          isLoadingOptions = false;
        });
      }
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  bool _validateRequiredDropdowns() {
    final genderError = (_genderDropdownKey.currentState as dynamic)
        ?.validate();

    final batchError = (_batchDropdownKey.currentState as dynamic)?.validate();

    final trainingError = (_trainingDropdownKey.currentState as dynamic)
        ?.validate();

    return genderError == null && batchError == null && trainingError == null;
  }

  Future<void> _handleRegisterSubmit() async {
    if (isLoadingOptions) {
      _showMessage('Tunggu sampai pilihan selesai dimuat.');
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    if (!_validateRequiredDropdowns()) return;

    setState(() {
      isLoading = true;
    });

    String message = 'Pendaftaran gagal';
    var isSuccess = false;

    try {
      final result = await registerUser(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        trainingId: selectedTrainingId!,
        batchId: selectedBatchId!,
        jenisKelamin: selectedGender!,
      );

      isSuccess = true;

      message = result?.message ?? 'Pendaftaran sukses, silahkan login';
    } catch (e) {
      log(e.toString());

      message = e
          .toString()
          .replaceFirst('Exception: ', '')
          .replaceFirst('HttpException: ', '')
          .trim();
    }

    if (!context.mounted) return;

    _showMessage(message);

    setState(() {
      isLoading = false;
    });

    if (isSuccess) {
      context.pushReplacement(const Login());
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// ================= UI =================

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              /// Title
              const SizedBox(height: 10),

              const Text(
                'Buat Akun Baru',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
              ),

              const SizedBox(height: 8),

              const Text(
                'Lengkapi data diri Anda untuk melanjutkan',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              /// Card Form
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
                      /// Nama
                      _buildLabel('Nama'),

                      CustomTextField(
                        controller: nameController,
                        hintText: 'Masukkan Nama Lengkap',
                        prefixIcon: Icons.person,
                        validator: (value) {
                          if ((value ?? '').trim().isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 14),

                      /// Gender
                      _buildLabel('Jenis Kelamin'),

                      CustomDropdownField<String>(
                        key: _genderDropdownKey,
                        selectedValue: selectedGender,
                        hintText: 'Masukkan Jenis Kelamin',
                        prefixIcon: Icons.wc_outlined,
                        menuMaxHeight: 220,
                        isRequired: true,
                        items: const [
                          DropdownMenuItem(
                            value: 'L',
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text('Laki-laki'),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'P',
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text('Perempuan'),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),

                      const SizedBox(height: 14),

                      /// Email
                      _buildLabel('Email'),

                      CustomTextField(
                        controller: emailController,
                        hintText: 'Masukkan Email',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
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

                      const SizedBox(height: 14),

                      /// Batch
                      _buildLabel('Batch'),

                      CustomDropdownField<int>(
                        key: _batchDropdownKey,
                        selectedValue: selectedBatchId,
                        hintText: 'Pilih Batch',
                        prefixIcon: Icons.groups_outlined,
                        menuMaxHeight: 280,
                        isLoading: isLoadingOptions,
                        loadingText: 'Memuat batch...',
                        isRequired: true,
                        items: isLoadingOptions
                            ? const [
                                DropdownMenuItem(
                                  value: -1,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text('Memuat batch...'),
                                  ),
                                ),
                              ]
                            : batchMenuItems,
                        onChanged: isLoadingOptions
                            ? null
                            : _handleBatchChanged,
                      ),

                      const SizedBox(height: 14),

                      /// Training
                      _buildLabel('Training'),

                      CustomDropdownField<int>(
                        key: _trainingDropdownKey,
                        selectedValue: selectedTrainingId,
                        hintText: 'Pilih Training',
                        prefixIcon: Icons.school_outlined,
                        menuMaxHeight: 280,
                        isLoading: isLoadingOptions,
                        loadingText: 'Memuat jurusan...',
                        isRequired: true,
                        items: isLoadingOptions
                            ? const [
                                DropdownMenuItem(
                                  value: -1,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Text('Memuat jurusan...'),
                                  ),
                                ),
                              ]
                            : trainingMenuItems,
                        onChanged: isLoadingOptions
                            ? null
                            : (value) {
                                setState(() {
                                  selectedTrainingId = value;
                                });
                              },
                      ),

                      const SizedBox(height: 14),

                      /// Password
                      _buildLabel('Password'),

                      CustomTextField(
                        controller: passwordController,
                        hintText: 'Masukkan Password',
                        prefixIcon: Icons.lock_outline,
                        obscureText: isVisibility,
                        suffixIcon: InkWell(
                          onTap: _togglePasswordVisibility,
                          child: Icon(
                            isVisibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        validator: (value) {
                          final password = value ?? '';

                          if (password.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }

                          if (password.length < 6) {
                            return 'Password minimal 8 karakter';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      /// Button
                      CustomButton(
                        text: 'Register',
                        textColor: Colors.black,
                        isLoading: isLoading,
                        onPressed: _handleRegisterSubmit,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
