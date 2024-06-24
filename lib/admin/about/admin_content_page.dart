import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sauda_line/admin/about/about_content_page.dart';
import 'package:sauda_line/flutter_flow/flutter_flow_theme.dart';

class AdminContentPage extends StatefulWidget {
  const AdminContentPage({Key? key}) : super(key: key);

  @override
  State<AdminContentPage> createState() => _AdminContentPageState();
}

class _AdminContentPageState extends State<AdminContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        title: const Text('Контент',
          style: TextStyle(
            fontFamily: 'Futura',
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        elevation: 0.0,
        actions: [
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: ListTile(
                  title: Text("О КОМПАНИИ", style: TextStyle(
                    fontFamily: "Futura"
                  ),),
                  trailing: Icon(Icons.arrow_forward_ios_outlined, size: 25.0,),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return AboutContentPage(type: "ABOUT_COMPANY",);
                    }));
                  },
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: ListTile(
                  title: Text("Поставщикам".toUpperCase(), style: TextStyle(
                      fontFamily: "Futura"
                  ),),
                  trailing: Icon(Icons.arrow_forward_ios_outlined, size: 25.0,),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return AboutContentPage(type: "TO_PROVIDERS",);
                    }));
                  },
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: ListTile(
                  title: Text("Торговым точкам".toUpperCase(), style: TextStyle(
                      fontFamily: "Futura"
                  ),),
                  trailing: Icon(Icons.arrow_forward_ios_outlined, size: 25.0,),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return AboutContentPage(type: "TO_CUSTOMERS",);
                    }));
                  },
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: ListTile(
                  title: Text("Контакты".toUpperCase(), style: TextStyle(
                      fontFamily: "Futura"
                  ),),
                  trailing: Icon(Icons.arrow_forward_ios_outlined, size: 25.0,),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return AboutContentPage(type: "CONTACTS",);
                    }));
                  },
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: ListTile(
                  title: Text("Почты".toUpperCase(), style: TextStyle(
                      fontFamily: "Futura"
                  ),),
                  trailing: Icon(Icons.arrow_forward_ios_outlined, size: 25.0,),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return AboutContentPage(type: "EMAIL",);
                    }));
                  },
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white
                ),
                child: ListTile(
                  title: Text("ТЕЛЕФОНЫ", style: TextStyle(
                      fontFamily: "Futura"
                  ),),
                  trailing: Icon(Icons.arrow_forward_ios_outlined, size: 25.0,),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return AboutContentPage(type: "TEL",);
                    }));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
