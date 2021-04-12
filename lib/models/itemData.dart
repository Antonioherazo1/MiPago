// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mi_pago/models/itemModel.dart';

class ItemData extends ChangeNotifier {
  int horasLaboralesDiarias = 8;
  int valorUnitario = 0;
  int totalizador = 0;
  int sumIncome = 0;
  int sumEgress = 0;
  int cicloPago;
  bool ingresoFijoExist = false;
  String factorPor = 'Valor hora';
  int indexIngFijo = 0;

  List<ItemModel> incomeList = [];
  List<ItemModel> egressList = [];

  void addIncomeItem(String newNameItem, double newFactorItem, int factorPor,
      String columnFactor) {
    //Se crea un objeto tipo ItemModel y se le
    // pasan los parametros ingresados en la función
    final newItem = ItemModel(
        name: newNameItem,
        factor: newFactorItem,
        factorPor: factorPor,
        columnFactor: columnFactor);
    // Se añade el nuevo item a Ingresos
    incomeList.add(newItem);
    //se notifican los Consumidores del provider
    notifyListeners();
  }

  void addEgressItem(String newNameItem, double newFactorItem, int factorPor,
      String columnFactor) {
    //Se crea un objeto tipo ItemModel y se le
    // pasan los parametros ingresados en la función
    final newItem = ItemModel(
        name: newNameItem,
        factor: newFactorItem,
        factorPor: factorPor,
        columnFactor: columnFactor);
    // Se añade el nuevo item a Egresos
    egressList.add(newItem);
    //se notifican los Consumidores del provider
    notifyListeners();
  }

  void updateItem(ItemModel item, String value) {
    double factor = item.factor;
    int valueInt = int.parse(value);
    //------------------
    item.value = valueInt;
    item.total = (valueInt * factor * valorUnitario * item.factorPor).toInt();
    updateTotal();
  }

  void updateValorUnit(int valorUnitario) {
    this.valorUnitario = valorUnitario;
    incomeList.forEach((income) {
      int producto = (valorUnitario * income.value * income.factor).toInt();
      income.total = producto;
      updateTotal();
    });
    egressList.forEach((egress) {
      int producto = (valorUnitario * egress.value * egress.factor).toInt();
      egress.total = producto;
      updateTotal();
    });
  }

  void updateTotal() {
    sumIncome = 0;
    sumEgress = 0;
    incomeList.forEach((income) {
      sumIncome += income.total;
    });
    egressList.forEach((egress) {
      sumEgress += egress.total;
    });
    totalizador = sumIncome - sumEgress;
    notifyListeners();
  }
}
