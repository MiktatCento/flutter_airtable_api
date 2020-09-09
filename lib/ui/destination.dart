import 'package:flutter/material.dart';
import 'package:flutter_api_project/animation/bottomAnimation.dart';
import 'package:flutter_api_project/backend/api.dart';
import 'package:flutter_api_project/models/destination_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DestinationScreen extends StatefulWidget {
  final Destination destination;

  DestinationScreen({this.destination});

  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                iconSize: 30.0,
                color: Colors.black,
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  iconSize: 30.0,
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.sortAmountDown),
                  iconSize: 25.0,
                  color: Colors.black,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Stack(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                    ),
                    Container(
                      height: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Hero(
                        tag: widget.destination.imageUrl +
                            widget.destination.city,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          child: Image(
                            image: NetworkImage(widget.destination.imageUrl),
                            width: width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20.0,
                      bottom: 20.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.destination.city,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.locationArrow,
                                size: 15.0,
                                color: Colors.white70,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                widget.destination.country,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 20.0,
                      bottom: 20.0,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white70,
                        size: 25.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
                itemCount: widget.destination.activities.length,
                itemBuilder: (BuildContext context, int index) {
                  return FutureBuilder(
                      future: API().fetchActivityWithID(
                          widget.destination.activities[index]),
                      builder: (context, activity) {
                        if (activity.hasData) {
                          return WidgetAnimator(
                            Stack(
                              children: <Widget>[
                                Container(
                                  margin:
                                      EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
                                  height: 170.0,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        100.0, 20.0, 20.0, 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 120.0,
                                              child: Text(
                                                activity.data.name,
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  '\$${activity.data.price}',
                                                  style: TextStyle(
                                                    fontSize: 22.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Text(
                                                  'per pax',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          activity.data.type,
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        _buildRatingStars(activity.data.rating),
                                        SizedBox(height: 10.0),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(5.0),
                                              width: 70.0,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                activity.data.startTimes[0],
                                              ),
                                            ),
                                            SizedBox(width: 10.0),
                                            Container(
                                              padding: EdgeInsets.all(5.0),
                                              width: 70.0,
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                activity.data.startTimes[1],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 20.0,
                                  top: 15.0,
                                  bottom: 15.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image(
                                      width: 110.0,
                                      image: NetworkImage(
                                        activity.data.imageUrl,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
