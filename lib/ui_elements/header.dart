import 'package:flutter/material.dart';

import '../helper/ultility.dart';

class Header extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final String coverImageUrl;
  final String appbarTitle;
  final String openButtonText;
  final ScrollController scrollController;
  final String heroTag;
  final bool backButton;

  Header(
      {@required this.minHeight,
      @required this.maxHeight,
      @required this.scrollController,
      this.backButton: false,
      this.coverImageUrl: 'assets/meteors.jpg',
      this.appbarTitle: 'My Portfolio',
      this.openButtonText: 'See my works',
      this.heroTag: ''});

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  Widget _buildCoverImage() {
    return Hero(
      tag: heroTag,
      child: Image.asset(coverImageUrl, fit: BoxFit.cover),
    );
  }

  Widget _buildHeaderTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 30, top: 10),
      child: Text(
        appbarTitle,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          padding: EdgeInsets.only(top: 10, left: 20),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          iconSize: 36,
          onPressed: () => Navigator.of(context).pop(),
        ),
        _buildHeaderTitle(),
      ],
    );
  }

  Widget _buildOpenButton(double shrinkOffset, double deviceHeight) {
    return shrinkOffset >= maxHeight - minHeight - 60
        ? Container()
        : Expanded(
            child: Center(
              child: RaisedButton(
                color: Colors.redAccent,
                textColor: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Text(
                  openButtonText,
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () => Utility.scrollTo(deviceHeight - minHeight,
                    controller: scrollController),
              ),
            ),
          );
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double deviceHeight = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.clip,
      children: <Widget>[
        _buildCoverImage(),
        Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            backButton ? _buildAppBar(context) : _buildHeaderTitle(),
            _buildOpenButton(shrinkOffset, deviceHeight),
          ],
        )
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
