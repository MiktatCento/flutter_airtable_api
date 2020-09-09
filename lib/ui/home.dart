import 'package:flutter/material.dart';
import 'package:flutter_api_project/backend/api.dart';
import 'package:flutter_api_project/widgets/destination_carousel.dart';
import 'package:flutter_api_project/widgets/hotel_carousel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*
    StreamController<List> _dataController;

    _dataController = StreamController();
    Timer.periodic(Duration(seconds: 1), (_) {
      API().fetchData().then((value) => _dataController.add(value));
    });

    StreamBuilder<List>(
        stream: _dataController.stream,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            var document = snapshot.data;
            //Text(document[0]["fields"]["icerik"])
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: document.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(document[index]["fields"]["baslik"]),
                    subtitle: Text(document[index]["fields"]["icerik"]),
                    trailing: Image.network(document[index]["fields"]["resim"]),
                    onTap: () => print("${document[index]["id"]} tıklandı"),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),*/
  int _selectedIndex = 0;
  int _currentTab = 0;
  @override
  Widget build(BuildContext context) {
    List<IconData> _icons = [
      FontAwesomeIcons.plane,
      FontAwesomeIcons.bed,
      FontAwesomeIcons.walking,
      FontAwesomeIcons.biking,
    ];

    Widget _buildIcon(int index) {
      return GestureDetector(
        onTap: () async {
          setState(() {
            _selectedIndex = index;
          });
          var activities = await API().fetchDestination();
          print(activities.first.city);
        },
        child: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            color: _selectedIndex == index
                ? Theme.of(context).accentColor
                : Color(0xFFE7EBEE),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Icon(
            _icons[index],
            size: 25.0,
            color: _selectedIndex == index
                ? Theme.of(context).primaryColor
                : Color(0xFFB4C1C4),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                'What would you like to find?',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _icons
                  .asMap()
                  .entries
                  .map(
                    (MapEntry map) => _buildIcon(map.key),
                  )
                  .toList(),
            ),
            SizedBox(height: 20.0),
            DestinationCarousel(),
            SizedBox(height: 20.0),
            HotelCarousel(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30.0,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_pizza,
              size: 30.0,
            ),
            title: SizedBox.shrink(),
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 15.0,
              backgroundImage: NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/220px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg'),
            ),
            title: SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
