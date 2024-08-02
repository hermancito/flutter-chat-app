import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final usuarios = [
    Usuario(uid:'1',nombre: 'María', email: 'test1@test.com', online: true),
    Usuario(uid:'2',nombre: 'Juan', email: 'test2@test.com', online: true),
    Usuario(uid:'1',nombre: 'Pepe', email: 'test3@test.com', online: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Mi nombre',
            style: TextStyle(color: Colors.black87),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.exit_to_app),
            color: Colors.black87,
            onPressed: () {},
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(Icons.check_circle, color: Colors.green),
              //child:Icon(Icons.offline_bolt, color: Colors.red),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
          header: WaterDropHeader(
            complete: Icon(Icons.check,color: Colors.blue[400]),
            waterDropColor: Colors.blue,
          ),
          child: _listViewusuarios(),
          )
    );
  }

  ListView _listViewusuarios() {
    return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (_, i)=>_usuarioListTile(usuarios[i]),
          separatorBuilder: (_, i)=>Divider(),
          itemCount: usuarios.length);
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
            title: Text(usuario.nombre!),
            subtitle: Text(usuario.email!),
            leading: CircleAvatar(
              backgroundColor: Colors.blue[200],
              child: Text(usuario.nombre!.substring(0,2)),),
            trailing: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: usuario.online! ? Colors.green[300] : Colors.red[300],
                borderRadius: BorderRadius.circular(100) 
              ),
            ),
          );
  }

  void _cargarUsuarios() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
