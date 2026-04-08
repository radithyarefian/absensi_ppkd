import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// MODEL TRAINING
class Training {
  final int id;
  final String title;

  Training({required this.id, required this.title});

  factory Training.fromJson(Map<String, dynamic> json) {
    return Training(id: json['id'], title: json['title']);
  }
}

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isPasswordHidden = true;
  final TextEditingController namaRegisterController = TextEditingController();
  final TextEditingController emailRegisterController = TextEditingController();
  final TextEditingController batchRegisterController = TextEditingController();
  final TextEditingController trainingRegisterController =
      TextEditingController();
  final TextEditingController passwordRegisterController =
      TextEditingController();

  String? selectedBatch;
  Training? selectedTraining;

  // Inisialisasi awal agar tidak null
  late Future<List<Training>> trainingList = Future.value([]);

  @override
  void initState() {
    super.initState();
    trainingList = fetchTraining();
  }

  Future<List<Training>> fetchTraining() async {
    try {
      final response = await http.get(
        Uri.parse("https://api.example.com/training"),
      ); // ganti URL API kamu
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> data = jsonResponse['data'];
        return data.map((e) => Training.fromJson(e)).toList();
      } else {
        return []; // fallback kosong kalau status bukan 200
      }
    } catch (e) {
      return []; // fallback kosong kalau terjadi error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),

              /// TITLE
              const Text(
                "Buat Akun Baru",
                style: TextStyle(
                  fontFamily: 'ADLaMDisplay',
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),

              /// SUBTITLE
              Text(
                "Lengkapi data diri Anda untuk melanjutkan",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 30),

              /// MAIN BOX
              Container(
                width: 300,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6D9097).withOpacity(0.15),
                      blurRadius: 100,
                      offset: const Offset(0, 20),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// =========================
                      /// NAMA
                      /// =========================
                      const Text(
                        "Nama",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 325,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            Image.asset(
                              "assets/images/register/nama.png",
                              width: 18,
                              height: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: namaRegisterController,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  hintText: "Masukkan Nama Lengkap",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  border: InputBorder.none,
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      /// =========================
                      /// EMAIL
                      /// =========================
                      const Text(
                        "Email",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 325,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            Image.asset(
                              "assets/images/register/email.png",
                              width: 18,
                              height: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: emailRegisterController,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  hintText: "Masukkan Email",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  border: InputBorder.none,
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      /// =========================
                      /// BATCH
                      /// =========================
                      const Text(
                        "Batch",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 325,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            Image.asset(
                              "assets/images/register/batch.png",
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "Pilih Batch",
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.keyboard_arrow_down, size: 22),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      /// =========================
                      /// TRAINING DROPDOWN
                      /// =========================
                      SizedBox(
  width: 325,
  height: 40,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.black.withOpacity(0.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      elevation: 0,
    ),
    onPressed: () async {
      // cari posisi tombol
      final RenderBox button = context.findRenderObject() as RenderBox;
      final RenderBox overlay =
          Overlay.of(context).context.findRenderObject() as RenderBox;
      final RelativeRect position = RelativeRect.fromRect(
        Rect.fromPoints(
          button.localToGlobal(Offset.zero, ancestor: overlay),
          button.localToGlobal(button.size.bottomRight(Offset.zero),
              ancestor: overlay),
        ),
        Offset.zero & overlay.size,
      );

      // tampilkan menu
      final Training? selected = await showMenu<Training>(
        context: context,
        position: position,
        items: trainings.map((training) {
          return PopupMenuItem<Training>(
            value: training,
            child: Text(training.title),
          );
        }).toList(),
      );

      if (selected != null) {
        setState(() {
          selectedTraining = selected;
        });
      }
    },
    child: Row(
      children: [
        Image.asset(
          "assets/images/register/training.png",
          width: 18,
          height: 20,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            selectedTraining?.title ?? "Pilih Training",
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: selectedTraining != null
                  ? Colors.black
                  : Colors.black.withOpacity(0.5),
            ),
          ),
        ),
        const Icon(
          Icons.keyboard_arrow_down,
          size: 22,
        ),
      ],
    ),
  ),
),
                      const SizedBox(height: 14),

                      /// =========================
                      /// PASSWORD
                      /// =========================
                      const Text(
                        "Password",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 325,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            Image.asset(
                              "assets/images/register/password.png",
                              width: 18,
                              height: 20,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: passwordRegisterController,
                                obscureText: isPasswordHidden,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  hintText: "Masukkan Password",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  border: InputBorder.none,
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPasswordHidden = !isPasswordHidden;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Icon(
                                  isPasswordHidden
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 20,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),

                      /// =========================
                      /// REGISTER BUTTON
                      /// =========================
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            /// aksi register
                          },
                          child: Container(
                            width: 270,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2C94C),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Register",
                                  style: TextStyle(
                                    fontFamily: 'Fredoka',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
