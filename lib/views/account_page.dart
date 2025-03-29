import 'package:flutter/material.dart';
import 'package:viayage_app/services/auth_service.dart';
import 'package:viayage_app/views/edit_profile_page.dart';
import 'package:viayage_app/widgets/custom_loader.dart';



class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String nombre = "";
  String email = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    final data = await AuthService.getUserProfile();
    setState(() {
      nombre = data?["nombre"]??"";
      email = data?["email"]??"";
      isLoading = false;
    });
  }

  void logout() async {
    await AuthService.logout();
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CustomLoader()),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Cuenta", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(height: 30),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditProfilePage()),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.account_circle, size: 48),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nombre, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("Editar perfil", style: TextStyle(color: Colors.grey[600])),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),

              Divider(),

              Spacer(),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: logout,
                  icon: Icon(Icons.logout, color: Colors.black),
                  label: Text("Cerrar sesión", style: TextStyle(color: Colors.black, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE0EBF6),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
