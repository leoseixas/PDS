import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:works/app/components/error_box.dart';
import 'package:works/app/helpers/colors.dart';
import 'package:works/app/models/uf.dart';
import 'package:works/app/stores/uf_city_store.dart';

class UfCityScreen extends StatefulWidget {
  UfCityScreen({this.uf, this.showAll = false});

  final UF uf;
  final bool showAll;

  @override
  _UfCityScreenState createState() => _UfCityScreenState(uf, showAll);
}

class _UfCityScreenState extends State<UfCityScreen> {
  _UfCityScreenState(UF uf, bool showAll)
      : ufCityStore = UfCityStore(uf, showAll);

  final UfCityStore ufCityStore;

  final TextEditingController controller = TextEditingController();

  ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();

    disposer = autorun((_) {
      if (ufCityStore.uf != null && ufCityStore.city != null)
        Navigator.of(context)
            .pop({"uf": ufCityStore.uf, "city": ufCityStore.city});
      else if (ufCityStore.uf.id == -1)
        Navigator.of(context).pop({"uf": ufCityStore.uf});
    });
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Observer(
            builder: (_) {
              if (ufCityStore.uf == null)
                return Text('Selecionar Estado');
              else
                return Text('Selecionar Cidade');
            },
          ),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          padding: EdgeInsets.all(8),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Observer(builder: (_) {
                    if (ufCityStore.uf != null)
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Estado: ${ufCityStore.uf.name}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: AppColors.kPrimaryColor,
                              ),
                            ),
                            flex: 5,
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              ufCityStore.setItem(null);
                              controller.clear();
                            },
                          ),
                        ],
                      );
                    else
                      return Container();
                  }),
                  TextField(
                    controller: controller,
                    cursorColor: AppColors.kPrimaryColor,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      isDense: true,
                      labelText: 'Pesquisar',
                    ),
                    onChanged: ufCityStore.setSearch,
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: Observer(
                      builder: (_) {
                        if (ufCityStore.error != null)
                          return ErrorBox(
                            message: ufCityStore.error,
                          );
                        return ListView.separated(
                          itemCount: ufCityStore.outFiltered.length,
                          itemBuilder: (_, index) {
                            return Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  ufCityStore
                                      .setItem(ufCityStore.outFiltered[index]);
                                  controller.clear();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    ufCityStore.outFiltered[index].name,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight:
                                          ufCityStore.outFiltered[index].id ==
                                                  -1
                                              ? FontWeight.w900
                                              : FontWeight.w400,
                                      color: AppColors.kPrimaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => Divider(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
