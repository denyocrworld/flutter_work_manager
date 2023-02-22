import 'package:flutter/material.dart';
import 'package:flutter_work_manager/state_util.dart';
import '../view/user_list_view.dart';

class UserListController extends State<UserListView> implements MvcController {
  static late UserListController instance;
  late UserListView view;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}