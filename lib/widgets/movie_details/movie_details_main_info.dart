import 'package:flutter/material.dart';
import 'package:themoviedb/resources/resources.dart';
import 'package:themoviedb/widgets/elements/radial_percent_widget.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TopPosterWidget(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: _MovieNameWidget(),
        ),
        _ScoreWidget(),
        _SummaryWidget(),
        _OverviewWidget(),
        SizedBox(
          height: 30,
        ),
        _PeopleWidget(),
      ],
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: AssetImage(AppImages.topHeader),
        ),
        Positioned(
          top: 20,
          left: 20,
          bottom: 20,
          child: Image(
            image: AssetImage(AppImages.topHeaderSubImage),
          ),
        ),
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Tom Clansy s Without Remorse',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
          TextSpan(
            text: ' (2021)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
      maxLines: 3,
      textAlign: TextAlign.center,
    );
  }
}

class _SummaryWidget extends StatelessWidget {
  const _SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Color.fromRGBO(22, 21, 25, 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
        child: Text(
          'PG-13 13/08/2021 (US)Comedy 1h 55m    , Action, Adventure, Science Fiction ',
          maxLines: 3,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _OverviewWidget extends StatelessWidget {
  const _OverviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'A bank teller called Guy realizes he is a'
          ' background character in an open world video '
          'game called Free City that will soon go offline.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _PeopleWidget extends StatelessWidget {
  const _PeopleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
    final jobTitleStyleStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stefan Sollima',
                  style: nameStyle,
                ),
                Text(
                  'Director',
                  style: jobTitleStyleStyle,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stefan Sollima',
                  style: nameStyle,
                ),
                Text(
                  'Director',
                  style: jobTitleStyleStyle,
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stefan Sollima',
                  style: nameStyle,
                ),
                Text(
                  'Director',
                  style: jobTitleStyleStyle,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stefan Sollima',
                  style: nameStyle,
                ),
                Text(
                  'Director',
                  style: jobTitleStyleStyle,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: RadialPercentWidget(
                  child: Text('72%'),
                  percent: 0.72,
                  fillColor: Color.fromARGB(255, 10, 23, 25),
                  freeColor: Color.fromARGB(255, 25, 54, 31),
                  lineColor: Color.fromARGB(255, 37, 203, 103),
                  lineWidth: 3,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text('User Score'),
            ],
          ),
        ),
        Container(
          width: 1,
          height: 15,
          color: Colors.grey,
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Icon(Icons.play_arrow),
              Text('Play Trailer'),
            ],
          ),
        ),
      ],
    );
  }
}
