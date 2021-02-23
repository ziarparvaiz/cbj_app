import 'package:auto_route/auto_route.dart';
import 'package:clipboard/clipboard.dart';
import 'package:cybear_jinni/application/join_home_by_id/join_home_by_id_bloc.dart';
import 'package:cybear_jinni/presentation/routes/app_router.gr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JoinHomeByIdWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    String homeId = '';

    return BlocConsumer<JoinHomeByIdBloc, JoinHomeByIdState>(
      listener: (context, state) {
        state.map(
          (value) => null,
          loading: (_) {
            return const CircularProgressIndicator(
              backgroundColor: Colors.cyan,
              strokeWidth: 5,
            );
          },
          loaded: (l) {
            return const Text('Loaded');
          },
          error: (e) {
            return const Text('Failure');
          },
        );
      },
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            FlatButton(
              color: Colors.green,
              onPressed: () async {
                String fromClipboard = await FlutterClipboard.paste();

                context
                    .read<JoinHomeByIdBloc>()
                    .add(JoinHomeByIdEvent.addHomeById(fromClipboard));
              },
              child: const Text(
                'Paste and search',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                const Text('Home ID'),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.greenAccent.withOpacity(0.3),
                      prefixIcon: const Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                      labelText: 'Home ID',
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                    autocorrect: false,
                    onChanged: (value) {
                      homeId = value;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            FlatButton(
              color: Colors.pinkAccent,
              onPressed: () {
                context
                    .read<JoinHomeByIdBloc>()
                    .add(JoinHomeByIdEvent.addHomeById(homeId));
              },
              child: const Text(
                'Join Home from text form',
                style: TextStyle(color: Colors.white),
              ),
            ),
            state.map(
              (value) => const SizedBox(),
              loading: (_) {
                return const CircularProgressIndicator(
                  backgroundColor: Colors.cyan,
                  strokeWidth: 5,
                );
              },
              loaded: (l) {
                ExtendedNavigator.of(context).replace(Routes.homePage);
                return const Text('Loaded');
              },
              error: (e) {
                return const Text('Failure');
              },
            )
          ],
        );
      },
    );
  }
}
