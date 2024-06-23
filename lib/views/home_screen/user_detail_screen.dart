import 'package:flutter/material.dart';
import 'package:hivetest/views/home_screen/widgets/bottom_sheet_property_widget.dart';
import 'package:provider/provider.dart';
import '../../controllers/provider/user_details_provider.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            Provider.of<UserDataProvider>(context, listen: false)
                .initUserData(isrefresh: true),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Consumer<UserDataProvider>(
            builder: (context, userDataProvider, _) {
              if (userDataProvider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (userDataProvider.error != null &&
                  userDataProvider.userData.isEmpty) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.89,
                    child: Center(child: Text('${userDataProvider.error}')),
                  ),
                );
              } else if (userDataProvider.userData.isEmpty) {
                return const Center(child: Text('No data available'));
              } else {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: userDataProvider.userData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        leading: const CircleAvatar(
                          radius: 25,
                          child: Icon(Icons.person),
                        ),
                        title: Text(
                          userDataProvider.userData[index].name!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Email: ${userDataProvider.userData[index].email!}',
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Username: ${userDataProvider.userData[index].username!}',
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.69,
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'User Details',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    BottomSheetDetailRow(
                                        icon: Icons.person,
                                        label: 'Name',
                                        value: userDataProvider
                                            .userData[index].name!),
                                    BottomSheetDetailRow(
                                        icon: Icons.account_circle,
                                        label: 'Username',
                                        value: userDataProvider
                                            .userData[index].username!),
                                    BottomSheetDetailRow(
                                        icon: Icons.email,
                                        label: 'Email',
                                        value: userDataProvider
                                            .userData[index].email!),
                                    BottomSheetDetailRow(
                                        icon: Icons.phone,
                                        label: 'Phone',
                                        value: userDataProvider
                                            .userData[index].phone!),
                                    BottomSheetDetailRow(
                                        icon: Icons.language,
                                        label: 'Website',
                                        value: userDataProvider
                                            .userData[index].website!),
                                    BottomSheetDetailRow(
                                        icon: Icons.location_on,
                                        label: 'Address',
                                        value:
                                            '${userDataProvider.userData[index].address!.street}, ${userDataProvider.userData[index].address!.suite}, ${userDataProvider.userData[index].address!.city}, ${userDataProvider.userData[index].address!.zipcode}'),
                                    BottomSheetDetailRow(
                                        icon: Icons.business,
                                        label: 'Company',
                                        value: userDataProvider
                                            .userData[index].company!.name!),
                                    BottomSheetDetailRow(
                                        icon: Icons.work,
                                        label: 'Company Phrase',
                                        value: userDataProvider.userData[index]
                                            .company!.catchPhrase!),
                                    BottomSheetDetailRow(
                                        icon: Icons.article,
                                        label: 'Company Business',
                                        value: userDataProvider
                                            .userData[index].company!.bs!),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
