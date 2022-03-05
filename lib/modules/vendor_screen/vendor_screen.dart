import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mv_admin_app/layout/cubit/cubit.dart';
import 'package:mv_admin_app/layout/cubit/states.dart';
import 'package:mv_admin_app/modules/vendor_screen/cubit/cubit.dart';
import 'package:mv_admin_app/modules/vendor_screen/cubit/states.dart';
import 'package:mv_admin_app/widget/vendor_screen_widgets/vendors_list.dart';

import '../../widget/vendor_screen_widgets/row_header.dart';

class VendorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VendorCubit, VendorStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = VendorCubit.get(context);
        return Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Registered Vendor',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              cubit.selectedButton == true
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.shade500,
                            ),
                          ),
                          child: Text('Approved'),
                          onPressed: () {
                            cubit.selectApproved();
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              cubit.selectedButton == false
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.shade500,
                            ),
                          ),
                          child: Text('Not Approved'),
                          onPressed: () {
                            cubit.selectRejected();
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              cubit.selectedButton == null
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey.shade500,
                            ),
                          ),
                          child: Text('All'),
                          onPressed: () {
                            cubit.selectAll();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  rowHeader(flex: 1, text: 'LOGO'),
                  rowHeader(flex: 3, text: 'BUSINESS NAME'),
                  rowHeader(flex: 2, text: 'CITY'),
                  rowHeader(flex: 2, text: 'STATE'),
                  rowHeader(flex: 1, text: 'ACTION'),
                  rowHeader(flex: 1, text: 'VIEW MORE'),
                ],
              ),
              VendorsList(
                approveStatus: cubit.selectedButton,
              ),
            ],
          ),
        );
      },
    );
  }
}
