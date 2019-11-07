import 'package:flutter/material.dart';
import 'package:preferenciasusuario/src/preferencias/preferencias_usuario.dart';
import 'package:preferenciasusuario/src/widgets/menu_widget.dart';

class SettingsPage extends StatefulWidget {

  static final String routeName = 'settings';
  const SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _colorSecundario;
  int _genero;
  String _nombre;
  TextEditingController _textController;

  final prefs = new PreferenciasUsuario();

  @override
  void initState() {  
    super.initState();
    _genero = prefs.genero;
    _colorSecundario = prefs.colorSecundario;
    _nombre = prefs.nombreUsuario;
    prefs.ultimaPagina = SettingsPage.routeName;

    _textController = new TextEditingController( text: _nombre );
  }

  _setSelectedRadio( int valor ) {
    prefs.genero = valor;
    _genero = valor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        backgroundColor: (prefs.colorSecundario) ? Colors.teal : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text('Configuración', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),),
          ),
          
          Divider(),
          SwitchListTile(
            value: _colorSecundario,
            title: Text('Color secundario'),
            onChanged: (value) {
              setState(() {
                _colorSecundario = value;
                prefs.colorSecundario = value;
              });
            },
          ),

          RadioListTile(
            value: 1,
            title: Text('Masculino'),
            groupValue: _genero,
            onChanged: _setSelectedRadio
          ),

          RadioListTile(
            value: 2,
            title: Text('Femenino'),
            groupValue: _genero,
            onChanged: _setSelectedRadio
          ),

          Divider(),

          Container(
            padding: EdgeInsets.symmetric( horizontal: 20.0 ),
            child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                helperText: 'Nombre de la persona con el telefono'
              ),
              onChanged: ( value ) {
                prefs.nombreUsuario = value;
              },
            ),
          )

        ],
      ),
    );
  }
}
