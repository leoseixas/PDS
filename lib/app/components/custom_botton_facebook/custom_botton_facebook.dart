import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:works/app/stores/login_store.dart';

class CustomBottonFacebook extends StatelessWidget {
  const CustomBottonFacebook({this.onPressed, this.loading, this.loginStore});

  final VoidCallback onPressed;
  final bool loading;
  final LoginStore loginStore;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Container(
          height: 45,
          child: ElevatedButton(
            onPressed: onPressed,
            child: loginStore.loadingFace
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/icons/facebook.png',
                        width: 24,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Entrar com Facebook',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) =>
                    states.contains(MaterialState.disabled)
                        ? Colors.white
                        : Colors.white,
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) =>
                    states.contains(MaterialState.disabled)
                        ? Colors.blue
                        : Colors.blue,
              ),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              )),
              elevation: MaterialStateProperty.all<double>(0),
            ),
          ),
        );
      },
    );
  }
}
