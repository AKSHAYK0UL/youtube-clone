import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youtube/bloc/supabasebloc/bloc/supabase_bloc.dart';

final clientprofileimage =
    Supabase.instance.client.auth.currentUser!.userMetadata!["userprofile"];

Widget buildAccountOptions(
    {required BuildContext context,
    required String optiontext,
    required String text,
    required IconData icon}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          optiontext,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          tileColor: Colors.lightBlue.shade50,
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(icon),
          ),
          title: Text(
            text,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    ),
  );
}

Widget buildUpdateProfile(BuildContext context) {
  return BlocBuilder<SupabaseBloc, SupabaseState>(
    builder: (context, state) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CircleAvatar(
              backgroundColor: Colors.blueGrey.shade100,
              radius: 80,
              child: state is ImageUrlState && state.url.isNotEmpty
                  ? Image.network(
                      state.url,
                      fit: BoxFit.fill,
                    )
                  : clientprofileimage != ""
                      ? Image.network(
                          clientprofileimage,
                          fit: BoxFit.fill,
                        )
                      : const Icon(
                          Icons.person,
                          size: 50,
                        ),
            ),
          ),
          Positioned(
            left: 112,
            bottom: 0,
            child: CircleAvatar(
              backgroundColor: Colors.lightBlue.shade50,
              child: IconButton(
                  onPressed: () {
                    context.read<SupabaseBloc>().add(UploadImage(context));
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 25,
                  )),
            ),
          ),
        ],
      );
    },
  );
}
