import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mi_pago/models/itemData.dart';
import 'package:mi_pago/models/itemModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DroppDownCiclopago extends StatefulWidget {
  @override
  _DroppDownCiclopagoState createState() => _DroppDownCiclopagoState();
}

class _DroppDownCiclopagoState extends State<DroppDownCiclopago> {
  final List<String> cicloDePagoList = ['Semanal', 'Quincenal', 'Mensual'];

  String valueChoosen;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ' Periodo de Pago',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
          DropdownButton(
            hint: Text('Elige una opcion'),
            //---------------------
            value: valueChoosen,
            //---------------------
            items: cicloDePagoList.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Container(
                  width: 100.0,
                  child: Text(valueItem),
                ),
              );
            }).toList(),
            //---------------------
            onChanged: (newValue) {
              String descripFactor = '''Horas
$newValue${'es'}''';
              print('DescripFactor: $descripFactor');

              setState(() {
                ItemData data = Provider.of<ItemData>(context);
                newValue == 'Semanal'
                    ? Provider.of<ItemData>(context).cicloPago = 56
                    : newValue == 'Quincenal'
                        ? Provider.of<ItemData>(context).cicloPago = 112
                        : Provider.of<ItemData>(context).cicloPago = 224;
                //---------
                valueChoosen = newValue;
                if (Provider.of<ItemData>(context).ingresoFijoExist == false) {
                  final fixIncome = ItemModel(
                      name: 'Ingreso Fijo',
                      factor: 1,
                      factorPor: 1,
                      columnFactor: descripFactor,
                      fixItem: true);
                  data.indexIngFijo = data.incomeList.length;
                  Provider.of<ItemData>(context).ingresoFijoExist = true;
                  Provider.of<ItemData>(context).incomeList.add(fixIncome);
                } else {
                  int index = data.indexIngFijo;
                  print('valor index: $index');
                  data.incomeList[index].columnFactor = descripFactor;
                  data.updateItem(data.incomeList[index],
                      data.incomeList[index].value.toString());
                }
                // Incvocamos la funcion upDateItem de Provider para actualizar cambio de cicloPago
                Provider.of<ItemData>(context).updateItem(
                    Provider.of<ItemData>(context).incomeList[0],
                    Provider.of<ItemData>(context).cicloPago.toString());
                Provider.of<ItemData>(context).updateTotal();
              });
            },
            //---------------------
          ),
        ],
      ),
    );
  }
}
