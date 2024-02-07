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
                icon: Icons.local_bar, // Un ícono sugerido para representar la interacción de preguntas y respuestas.
                title: 'Descubre la Cultura Chupística', // Título que invita a los usuarios a aprender sobre el juego.
                text: ' Conduce a una serie de preguntas que deben ser respondidas en turno. Responde correctamente y '
                      'pasa al siguiente jugador en sentido horario, pero si te equivocas, bebe un sorbo y pasa a la siguiente pregunta.'
              ),
                _buildPageContent(
                  icon: Icons.flash_on, // Ícono que representa rapidez o acción inmediata.
                  title: 'Modo Rápido', // Título que indica al usuario que esta página es para el juego rápido.
                  text: 'Selecciona una categoría y empieza a jugar de inmediato. '
                        'En este modo, las preguntas aparecerán una tras otra sin demora, '
                        'permitiéndote disfrutar del juego de forma ágil y dinámica. '
                        'Ideal para cuando quieres una partida rápida o estás corto de tiempo.', // Descripción detallada del modo rápido.
                ),
              _buildPageContent(
                icon: Icons.people, // Ícono sugerido para el modo personalizado.
                title: 'Modo Personalizado', // Título para la instrucción del modo personalizado.
                text: 'Crea tu grupo y cada jugador inicia con tres vidas. '
                      'Responde a las preguntas correctamente para sobrevivir. '
                      'Elige a quien falló para restarle una vida. '
                      '¡El último en pie se corona campeón!', // Descripción de cómo jugar en el modo personalizado.
              ),
              ],
            ),
            Positioned(
              right: 30,
              bottom: 35,
              child: _buildNextButton(),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
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
            textAlign: TextAlign.center,
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
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
