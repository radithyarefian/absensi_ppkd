import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isPasswordVisible = false;

  // ================= STYLE GLOBAL =================

  final TextStyle labelStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  final TextStyle hintStyle = const TextStyle(
    fontSize: 14,
    color: Colors.black54,
  );

  OutlineInputBorder inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(color: Colors.grey.shade400),
    );
  }

  SizedBox spaceLabel() => const SizedBox(height: 6);
  SizedBox spaceField() => const SizedBox(height: 14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ================= TITLE =================
              const SizedBox(height: 10),

              const Center(
                child: Text(
                  "Buat Akun Baru",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              const Center(
                child: Text(
                  "Lengkapi data diri Anda untuk melanjutkan",
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 24),

              /// ================= CARD FORM =================
              Container(
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ================= NAMA =================
                    Text("Nama", style: labelStyle),

                    spaceLabel(),

                    TextField(
                      style: const TextStyle(color: Colors.black),

                      decoration: InputDecoration(
                        hintText: "Masukkan Nama Lengkap",
                        hintStyle: hintStyle,

                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: Icon(Icons.person),
                        ),

                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 40,
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 14,
                        ),

                        border: inputBorder(),
                        enabledBorder: inputBorder(),
                        focusedBorder: inputBorder(),
                      ),
                    ),

                    spaceField(),

                    /// ================= JENIS KELAMIN =================
                    Text("Jenis Kelamin", style: labelStyle),

                    spaceLabel(),

                    DropdownButtonFormField(
                      style: const TextStyle(color: Colors.black),

                      decoration: InputDecoration(
                        hintText: "Masukkan Jenis Kelamin",
                        hintStyle: hintStyle,

                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Image.asset(
                            "assets/images/register/jenis_kelamin.png",
                            width: 20,
                          ),
                        ),

                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 40,
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 14,
                        ),

                        border: inputBorder(),
                        enabledBorder: inputBorder(),
                        focusedBorder: inputBorder(),
                      ),

                      items: const [
                        DropdownMenuItem(
                          value: "L",
                          child: Text(
                            "Laki-laki",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "P",
                          child: Text(
                            "Perempuan",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],

                      onChanged: (value) {},
                    ),

                    spaceField(),

                    /// ================= EMAIL =================
                    Text("Email", style: labelStyle),

                    spaceLabel(),

                    TextField(
                      style: const TextStyle(color: Colors.black),

                      decoration: InputDecoration(
                        hintText: "Masukkan Email",
                        hintStyle: hintStyle,

                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: Icon(Icons.email),
                        ),

                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 40,
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 14,
                        ),

                        border: inputBorder(),
                        enabledBorder: inputBorder(),
                        focusedBorder: inputBorder(),
                      ),
                    ),

                    spaceField(),

                    /// ================= BATCH =================
                    Text("Batch", style: labelStyle),

                    spaceLabel(),

                    DropdownButtonFormField(
                      style: const TextStyle(color: Colors.black),

                      decoration: InputDecoration(
                        hintText: "Pilih Batch",
                        hintStyle: hintStyle,

                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: Icon(Icons.layers),
                        ),

                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 40,
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 14,
                        ),

                        border: inputBorder(),
                        enabledBorder: inputBorder(),
                        focusedBorder: inputBorder(),
                      ),

                      items: const [],

                      onChanged: (value) {},
                    ),

                    spaceField(),

                    /// ================= TRAINING =================
                    Text("Training", style: labelStyle),

                    spaceLabel(),

                    DropdownButtonFormField(
                      style: const TextStyle(color: Colors.black),

                      decoration: InputDecoration(
                        hintText: "Pilih Training",
                        hintStyle: hintStyle,

                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: Icon(Icons.school),
                        ),

                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 40,
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 14,
                        ),

                        border: inputBorder(),
                        enabledBorder: inputBorder(),
                        focusedBorder: inputBorder(),
                      ),

                      items: const [],

                      onChanged: (value) {},
                    ),

                    spaceField(),

                    /// ================= PASSWORD =================
                    Text("Password", style: labelStyle),

                    spaceLabel(),

                    TextField(
                      obscureText: !isPasswordVisible,

                      style: const TextStyle(color: Colors.black),

                      decoration: InputDecoration(
                        hintText: "Masukkan Password",
                        hintStyle: hintStyle,

                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: Icon(Icons.lock),
                        ),

                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),

                        prefixIconConstraints: const BoxConstraints(
                          minWidth: 40,
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 14,
                        ),

                        border: inputBorder(),
                        enabledBorder: inputBorder(),
                        focusedBorder: inputBorder(),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// ================= BUTTON =================
                    SizedBox(
                      width: double.infinity,
                      height: 50,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE6BE49),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),

                        onPressed: () {},

                        child: const Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
