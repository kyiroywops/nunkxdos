import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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


  ]




);
