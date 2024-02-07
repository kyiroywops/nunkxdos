import 'package:flutter/material.dart';

class InstructionsScreen extends StatefulWidget {
  @override
  _InstructionsScreenState createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/slide${_currentPage}.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                _buildPageContent(
                  icon: Icons.group_add,
                  title: 'Arma tu grupo',
                  text: 'Agrega a tus amigos a unirse y asignarles cartas aleatoriamente para comenzar la partida.',
                ),
                _buildPageContent(
                  icon: Icons.card_giftcard,
                  title: 'La Pirámide',
                  text: 'Voltea cada carta de la pirámide empezando desde la base. Si tienes la carta, puedes pasarle un sorbo a otro jugador o tomarlo tú mismo.',
                ),
                _buildPageContent(
                  icon: Icons.emoji_events,
                  title: 'Carta final',
                  text: 'La última carta se voltea al final. El jugador que la tenga debe tomar al seco. ¡Buena suerte!',
                ),
              ],
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: _buildNextButton(),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: _buildPageIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent({required IconData icon, required String title, required String text}) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(icon, size: 48.0, color: Colors.white),
          Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              color: Colors.grey[100],
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w900,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 100.0), // Aumenta el padding aquí
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w500,
                color: Colors.grey[100],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (index) => _buildDot(index: index)),
      ),
    );
  }

  Widget _buildDot({required int index}) {
    return Container(
      height: 10,
      width: 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.white : Colors.white54,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildNextButton() {
    return TextButton(
      onPressed: () {
        if (_currentPage < 2) {
          _pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          Navigator.of(context).pop();
        }
      },
      style: TextButton.styleFrom(
        primary: Colors.white,
        backgroundColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          _currentPage < 2 ? 'Siguiente' : 'Finalizar',
          style: TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.w800,
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
