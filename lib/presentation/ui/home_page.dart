
import 'package:clean_architecture/domain/usecase/authentication/get_current_user.dart';
import 'package:clean_architecture/presentation/ui/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../domain/usecase/chat_usecases.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import 'chat/chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatUseCase _chatUseCase = GetIt.I<ChatUseCase>();

  final GetCurrentUserUseCase _getCurrentUserUseCase = GetIt.I<GetCurrentUserUseCase>();

  void logout(BuildContext context) {
    context.read<HomeBloc>().add(LogoutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => logout(context),
          ),
        ],
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            Navigator.pushReplacementNamed(context, "/login");
          } else if (state is LogoutFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Logout Failed: ${state.error ?? 'Unknown error'}")),
            );
          }
        },
        child: _builderListUser(),
      ),
    );
  }

  Widget _builderListUser() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: _chatUseCase.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Waiting");
        }

        return ListView(
          children: snapshot.data!.map<Widget>((userdata) {
            return _buildUserListItem(userdata, context);
          }).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userdata, BuildContext context) {
    if (userdata['email'] != _getCurrentUserUseCase.call()) {
      return UserTile(
        text: userdata['email'],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userdata['email'],
                receiverID: userdata['uid'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
