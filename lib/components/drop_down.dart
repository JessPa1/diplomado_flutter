import 'package:flutter/material.dart';
import 'package:pago_servicios/entities/catalogo.dart';

class DropDown extends StatefulWidget {
  final Function funcion;
  final String valor;
  final String pista;
  final Set<String> valoresSet;
  final double sizeHint;

  const DropDown({
    Key key,
    @required this.funcion,
    @required this.valor,
    @required this.pista,
    this.sizeHint,
    @required this.valoresSet,
  }) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      //padding: EdgeInsets.all(10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade400)),
      ),
      child: DropdownButton<String>(
        hint: Text(
          widget.pista,
          style: TextStyle(
              color: Colors.grey,
              fontSize: widget.sizeHint == null ? 15 : widget.sizeHint),
        ),
        value: widget.valor,
        icon: Icon(
          Icons.arrow_drop_down,
        ),
        iconSize: 24,
        elevation: 16,
        underline: Container(),
        style: TextStyle(color: Colors.black, fontSize: 20),
        onChanged: (String newValue) {
          widget.funcion(newValue);
        },
        isExpanded: true,
        items: widget.valoresSet.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
