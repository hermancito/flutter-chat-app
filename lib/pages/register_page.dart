import 'package:flutter/material.dart';

import '../widgets/custom_input.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const _Logo(),
                  _Form(),
                  const _Labels(),
                  const Text('Terminos y condiciones de uso',
                      style: TextStyle(fontWeight: FontWeight.w200))
                ],
              ),
            ),
          ),
        ));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: const EdgeInsets.only(top: 50),
        child: const Column(
          children: [
            Image(image: AssetImage('assets/tag-logo.png')),
            SizedBox(
              height: 20,
            ),
            Text(
              'Registro',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
              icon: Icons.perm_identity,
              placeholder: 'Nombre',
              textController: nameController,
              keyboardType: TextInputType.text),
          CustomInput(
              icon: Icons.mail_outline,
              placeholder: 'Correo',
              textController: emailController,
              keyboardType: TextInputType.emailAddress),
          CustomInput(
            icon: Icons.password,
            placeholder: 'Contraseña',
            textController: passController,
            keyboardType: TextInputType.text,
            isPassword: true,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:  Colors.blueAccent,
              shadowColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16),
            ), 
            child: const Text('Enviar'), 
            onPressed: () {}),
        ],
      ),
    );
  }
}

class _Labels extends StatelessWidget {
  const _Labels({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        const Text(
          'Ya tienes cuenta?',
          style: TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          child: Text('Login',
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.pushReplacementNamed(context, 'login');
          },
        )
      ]),
    );
  }
}