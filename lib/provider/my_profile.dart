import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sauda_line/app_state.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_theme.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_util.dart';
import 'package:sauda_line/provider/profile_edit.dart';
import 'package:sauda_line/svg_icons.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: true,
        title: const Text(
          'Мой профиль',
          style: TextStyle(
            fontFamily: 'Futura',
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const ProfileEdit();
            }));
          }, icon: Icon(Icons.edit))
        ],
        centerTitle: true,
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            children: [

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("Название организации: ", style: TextStyle(
                    fontFamily: "Futura",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87.withOpacity(0.8)
                )),
                subtitle: Text("${getJsonField(FFAppState().accountInfo, r'''$.name''',)}", style: const TextStyle(
                    fontFamily: "Futura",
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54
                )),
              ),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("Фамилия", style: TextStyle(
                    fontFamily: "Futura",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87.withOpacity(0.8)
                )),
                subtitle: Text("${getJsonField(FFAppState().accountInfo, r'''$.surname''',)}", style: const TextStyle(
                    fontFamily: "Futura",
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54
                )),
              ),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("Имя", style: TextStyle(
                    fontFamily: "Futura",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87.withOpacity(0.8)
                )),
                subtitle: Text("${getJsonField(FFAppState().accountInfo, r'''$.patronymic''',)}", style: const TextStyle(
                    fontFamily: "Futura",
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54
                )),
              ),



              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("Почта: ", style: TextStyle(
                    fontFamily: "Futura",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87.withOpacity(0.8)
                )),
                subtitle: Text("${getJsonField(FFAppState().accountInfo, r'''$.email''',)}", style: const TextStyle(
                    fontFamily: "Futura",
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54
                )),
              ),

              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text("Телефон номер: ", style: TextStyle(
                    fontFamily: "Futura",
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87.withOpacity(0.8)
                )),
                subtitle: Text("${getJsonField(FFAppState().accountInfo, r'''$.phoneNumber''',)}", style: const TextStyle(
                    fontFamily: "Futura",
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
