import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nunkxdos/presentation/screens/category_screen.dart';
import 'package:nunkxdos/presentation/screens/games_screen.dart';
import 'package:nunkxdos/presentation/screens/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
        builder: (BuildContext context, GoRouterState state) => PlayerSelectionScreen(),
        


    ),
     GoRoute(
      path: '/games',
        builder: (BuildContext context, GoRouterState state) => GamesScreen(),
      
        


    ),

    GoRoute(
      path: '/questions',
      builder: (BuildContext context, GoRouterState state) {
        // Obtenemos la categoría pasada como parámetro extra.
        final category = state.extra as String;
        // Luego, pasamos esta categoría a la pantalla correspondiente.
        return QuestionsScreen(category: category);
      },
    ),


  ]




);
