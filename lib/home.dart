import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'controller.dart';
import 'package:rate_calculator/configs/strings.dart';


class MyHomePage extends ConsumerStatefulWidget {
  String title;

  MyHomePage({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final TextEditingController _workStartController = TextEditingController();
  final TextEditingController _workEndController = TextEditingController();
  final TextEditingController _workDaysController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color(0xff5b0060),
              Color(0xff870160),
              Color(0xffac255e),
              Color(0xffca485c),
              Color(0xffe16b5c),
              Color(0xfff39060),
              Color(0xffffb56b),
            ])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    width: 220,
                    child:  Text(
                      workStarts,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 120,
                    child: TextField(
                      keyboardType: TextInputType.none,
                      cursorHeight: 26,
                      controller: _workStartController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: 2, bottom: 4, left: 6, right: 2),
                          border: OutlineInputBorder(),
                          fillColor: Colors.red),
                      onTap: () async {
                        TimeOfDay? _time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        ref.read(controllerProvider).updateStart(_time!);
                        _workStartController.text =
                            "${ref.watch(controllerProvider).start.hour}:${ref.watch(controllerProvider).start.minute}";
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    width: 220,
                    child: const Text(
                      workEnds,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 120,
                    child: TextField(
                      keyboardType: TextInputType.none,
                      cursorHeight: 26,
                      controller: _workEndController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: 2, bottom: 4, left: 6, right: 2),
                          border: OutlineInputBorder(),
                          fillColor: Colors.red),
                      onTap: () async {
                        TimeOfDay? _time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        ref.read(controllerProvider).updateEnd(_time!);
                        _workEndController.text =
                            "${ref.watch(controllerProvider).ends.hour}:${ref.watch(controllerProvider).ends.minute}";
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    width: 220,
                    child: const Text(
                      workDays,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 120,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      cursorHeight: 26,
                      controller: _workDaysController,
                      decoration: InputDecoration(
                          hintText:
                              ref.watch(controllerProvider).workDays.toString(),
                          contentPadding: EdgeInsets.only(
                              top: 2, bottom: 4, left: 6, right: 2),
                          border: OutlineInputBorder(),
                          fillColor: Colors.red),
                      onChanged: (_) {
                        if ( int.parse(_) > 31){
                         Fluttertoast.showToast(
                              msg: "Invalid work days",
                          );
                        }
                        ref
                            .read(controllerProvider)
                            .updateWorkDays(int.parse(_));
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 8),
                    width: 220,
                    child: const Text(
                      salary,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 120,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      cursorHeight: 26,
                      controller: _salaryController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: 2, bottom: 4, left: 6, right: 2),
                          border: OutlineInputBorder(),
                          fillColor: Colors.red),
                      onChanged: (_) {
                        ref.read(controllerProvider).updateSalary(int.parse(_));
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(controllerProvider).calculateRate();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 80,
                  child: const Text(
                    calculate,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                width: 200,
                child: Text(
                  '₹ ${ref.watch(controllerProvider).hourlyRate.toStringAsFixed(2)} per hour.',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
