import 'package:flutter/material.dart';
import 'package:pago_servicios/models/menu_item.dart';

class CustomListTile extends StatefulWidget {
  final String option;
  final IconData icon;
  final List<MenuItem> widgets;
  final String rutaPrincipal;

  const CustomListTile(
      {Key key,
      @required this.option,
      @required this.icon,
      this.widgets,
      this.rutaPrincipal})
      : super(key: key);

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  bool _showData = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: Column(
          children: [
            InkWell(
              splashColor: Colors.lightBlue,
              onTap: () {
                if (widget.widgets != null) {
                  setState(() {
                    _showData = !_showData;
                  });
                } else {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, widget.rutaPrincipal);
                }
              },
              child: Container(
                height: 50,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            Icon(
                              widget.icon,
                              size: 30,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.option,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_right,
                          size: 30,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _showData
                ? Column(
                    children: widget.widgets
                        .map((widget) => ItemMenu(
                              widget: widget,
                            ))
                        .toList(),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

class ItemMenu extends StatelessWidget {
  final MenuItem widget;

  const ItemMenu({Key key, @required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Container(
        child: InkWell(
          splashColor: Colors.lightBlue,
          onTap: () => {
            Navigator.of(context).pop(),
            Navigator.pushNamed(context, widget.id)
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border(bottom: BorderSide(color: Colors.grey[350])),
            ),
            height: 40,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.texto,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
