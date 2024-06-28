import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youtube/UI/widget/account_options.dart';

class Account extends StatelessWidget {
  const Account({super.key});
  Future<void> _signOut(BuildContext context) async {
    final supabaseInstance = Supabase.instance.client;
    await supabaseInstance.auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final supabaseInstance = Supabase.instance.client.auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(
                        "Logout",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      content: Text(
                        "Are you sure you want to logout?",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "No",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.blue),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            _signOut(context);
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Yes",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.red),
                          ),
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.login),
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: buildUpdateProfile(context),
          ),
          buildAccountOptions(
              context: context,
              icon: Icons.alarm,
              optiontext: "Last updated on",
              text: DateFormat("dd-MMM-yyyy").format(
                DateTime.parse(supabaseInstance!.updatedAt!),
              )),
          buildAccountOptions(
              context: context,
              icon: Icons.person,
              optiontext: "Username",
              text: supabaseInstance.userMetadata!["username"]),
          buildAccountOptions(
              context: context,
              icon: Icons.email,
              optiontext: "E-mail",
              text: supabaseInstance.email!),
          buildAccountOptions(
              context: context,
              icon: Icons.alarm,
              optiontext: "Register on",
              text: DateFormat("dd-MMM-yyyy").format(
                DateTime.parse(supabaseInstance.createdAt),
              )),
        ],
      ),
    );
  }
}
