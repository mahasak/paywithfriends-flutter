import 'package:flutter/material.dart';

void main() => runApp(new PayWithFriendsApp());


class PayWithFriendsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Pay With Friends",
      home: new PaymentScreen()
    );
  }
}

class PaymentScreen extends StatefulWidget {
  @override
  State createState() => new PaymentScreenState();
}

class PaymentScreenState extends State<PaymentScreen> {
  final List<PaymentItem> _messages = <PaymentItem>[]; 
  final TextEditingController _itemEditor = new TextEditingController(); //new
  final TextEditingController _priceEditor = new TextEditingController(); //new

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Pay with Friends")),
      body: new Column(                                        //modified
        children: <Widget>[                                         //new
          new Flexible(                                             //new
            child: new ListView.builder(                            //new 
              padding: new EdgeInsets.all(8.0),                     //new
              reverse: false,                                        //new
              itemBuilder: (_, int index) => _messages[index],      //new
              itemCount: _messages.length,                          //new
            ),                                                      //new
          ),                                                        //new
          new Divider(height: 1.0),                                 //new
          new Container(                                            //new
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor),                  //new
            child: _buildTextComposer(),                       //modified
          ),                                                        //new
        ],                                                          //new
      ),                                                            //new
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(                                            //new
      data: new IconThemeData(color: Theme.of(context).accentColor), //new
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _itemEditor,
                decoration: new InputDecoration.collapsed(
                  hintText: "Item"),
              ),
            ),
            new Flexible(
              child: new TextField(
                controller: _priceEditor,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration.collapsed(
                  hintText: "Price"),
              ),
            ),
            new Container(                                                 //new
              margin: new EdgeInsets.symmetric(horizontal: 4.0),           //new
              child: new IconButton(                                       //new
                icon: new Icon(Icons.create),                                //new
                onPressed: () => _handleSubmitted(_itemEditor.text, _priceEditor.text)),  //new
            ),                                                             //new
          ],
        ),
      )
    );
  }


  void _handleSubmitted(String name, String price) {
    _itemEditor.clear();
    _priceEditor.clear();
    PaymentItem message = new PaymentItem(   
      name: name,                      //new
      price: price,                                                  //new
    );                                                             //new
    setState(() {                                                  //new
      _messages.insert(0, message);                                //new
    });  
  }
}

class PaymentItem extends StatelessWidget {
  PaymentItem({this.name, this.price});
  final String name;
  final String price;
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(child: new Text(name)),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(name, style: Theme.of(context).textTheme.subhead),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(price),
              ),
            ],
          ),
        ],
      ),
    );
  }
}