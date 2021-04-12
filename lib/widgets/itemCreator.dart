import 'package:flutter/material.dart';
import 'package:mi_pago/models/itemData.dart';
import 'package:mi_pago/models/itemModel.dart';
import 'package:provider/provider.dart';

class ItemCreator extends StatefulWidget {
  final ItemModel item;
  final Function textFieldCallback;
  final String initValue;

  ItemCreator({this.item, this.textFieldCallback, this.initValue});

  @override
  _ItemCreatorState createState() => _ItemCreatorState();
}

class _ItemCreatorState extends State<ItemCreator> {
  var txtController = TextEditingController();

  @override
  void initState() {
    super.initState();
    txtController.text = this.widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          Container(
            height: 30.0,
            width: 300.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.yellow[50], Colors.yellow[200]]),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              border: Border.all(
                color: Colors.yellow[800],
                width: 2.0,
              ),
            ),
            child: Center(
              child: Text(
                '${widget.item.name}'.toUpperCase(),
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
          ),
          Container(
            height: 70.0,
            width: 350.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: <Color>[Colors.yellow[200], Colors.yellow[600]]),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Colors.yellow[800],
                width: 2.0,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                widget.item.fixItem
                    ? Text(
                        '${widget.item.value}',
                        style: TextStyle(fontSize: 30.0),
                      )
                    : TextFieldItem(
                        txtController: txtController, widget: widget),
                Text('${widget.item.columnFactor}'),
                Text("=", style: TextStyle(fontSize: 50.0)),
                Text('${widget.item.total}', style: TextStyle(fontSize: 40.0))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TextFieldItem extends StatelessWidget {
  const TextFieldItem({
    Key key,
    @required this.txtController,
    @required this.widget,
  }) : super(key: key);

  final TextEditingController txtController;
  final ItemCreator widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.0,
      height: 50.0,
      child: TextField(
        controller: txtController,
        style: TextStyle(fontSize: 30.0),
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(20)),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: widget.textFieldCallback,
      ),
    );
  }
}
