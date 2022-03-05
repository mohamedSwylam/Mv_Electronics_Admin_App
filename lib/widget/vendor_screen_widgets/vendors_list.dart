import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mv_admin_app/services/firebase_services.dart';
import 'package:mv_admin_app/widget/vendor_screen_widgets/vendor_data_widget.dart';
import 'package:path/path.dart';
import 'package:mime_type/mime_type.dart';

import '../../models/vendor_model.dart';

class VendorsList extends StatelessWidget {
  final CollectionReference? reference;

  const VendorsList({Key? key, this.reference}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService service = FirebaseService();
    return StreamBuilder<QuerySnapshot>(
      stream: service.vendor.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        }
        if (snapshot.data!.size == 0) {
          return const Text("No Categories Addded");
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.size,
            itemBuilder: (context, index) {
              Vendor vendor = Vendor.fromJson(
                  snapshot.data!.docs[index].data() as Map<String, dynamic>);
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  VendorDataWidget(
                    flex: 1,
                    widget: Container(
                      height: 50,
                      width: 50,
                      child: Image.network(vendor.logo!),
                    ),
                  ),
                  VendorDataWidget(
                    flex: 3,
                    text: vendor.businessName,
                  ),
                  VendorDataWidget(
                    flex: 2,
                    text: vendor.city,
                  ),
                  VendorDataWidget(
                    flex: 2,
                    text: vendor.state,
                  ),
                  VendorDataWidget(
                    flex: 1,
                    widget: vendor.approved == true
                        ? ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                            child: FittedBox(
                              child: Text(
                                'Reject',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            onPressed: () {
                              EasyLoading.show();
                              service.updateData(
                                  data: {'approved': false},
                                  docName: vendor.uid,
                                  reference: service.vendor).then((value) {
                                EasyLoading.dismiss();
                              });
                            },
                          )
                        : ElevatedButton(
                            child: FittedBox(
                              child: Text(
                                'Approve',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            onPressed: () {
                              EasyLoading.show();
                              service.updateData(
                                  data: {'approved': true},
                                  docName: vendor.uid,
                                  reference: service.vendor).then((value) {
                                EasyLoading.dismiss();
                              });
                            },
                          ),
                  ),
                  VendorDataWidget(
                    flex: 1,
                    widget: ElevatedButton(
                      child: Text(
                        'View More',
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              );
            });
      },
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final CollectionReference? reference;

  CategoryWidget({
    Key? key,
    required this.data,
    required this.reference,
  }) : super(key: key);

  final QueryDocumentSnapshot<Object?> data;
  final FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 80,
              width: 80,
              child: Image.network(data['image']),
            ),
            Text(reference == service.categories
                ? data['catName']
                : data['subCatName']),
          ],
        ),
      ),
    );
  }
}
