import 'package:findmyplace/backend/provider/filter_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterPage extends StatefulWidget {
  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool selectAll = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          "Select All",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                        value:
                            Provider.of<FilterService>(context, listen: false)
                                .getSelectAll,
                        onChanged: (value) {
                          setState(() {
                            selectAll = value!;
                            Provider.of<FilterService>(context, listen: false)
                                .selectAllBox(value);
                          });
                        }),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectAll = false;
                        Provider.of<FilterService>(context, listen: false)
                            .clearAll();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Text(
                        "Clear All",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          decoration: TextDecoration.underline,
                          color: Color(0xff0FC874),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        "Gym",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                      value: Provider.of<FilterService>(context, listen: false)
                          .getFilters[0],
                      onChanged: (value) {
                        setState(() {
                          Provider.of<FilterService>(context, listen: false)
                              .getFilters[0] = value!;
                        });
                      }),
                  CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        "Cafe",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                      value: Provider.of<FilterService>(context, listen: false)
                          .getFilters[1],
                      onChanged: (value) {
                        setState(() {
                          Provider.of<FilterService>(context, listen: false)
                              .getFilters[1] = value!;
                        });
                      }),
                  CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        "Restaurant",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                      value: Provider.of<FilterService>(context, listen: false)
                          .getFilters[2],
                      onChanged: (value) {
                        setState(() {
                          Provider.of<FilterService>(context, listen: false)
                              .getFilters[2] = value!;
                        });
                      }),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Provider.of<FilterService>(context, listen: false).getCount();
                  Provider.of<FilterService>(context, listen: false).setQuery();
                  Navigator.pop(context);
                },
                child: Container(
                  height: 50,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff0FC874),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                      child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
