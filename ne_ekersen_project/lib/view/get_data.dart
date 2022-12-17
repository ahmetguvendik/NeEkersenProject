import 'package:flutter/material.dart';
import 'package:ne_ekersen_project/service/Interfaces/post_service.dart';
import 'package:ne_ekersen_project/view/home_page.dart';
import '../constant/project_text.dart';
import '../service/model/activity_model.dart';

class GetData extends StatefulWidget {
  const GetData({Key? key}) : super(key: key);

  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
  List<ActivityModel>? _items;
  ActivityModel? model;
  late final IPostService _postService;

  @override
  void initState() {
    super.initState();
    _postService = PostService();
    postItemsAdvance();
  }

  Future<void> postItemsAdvance() async {
    _items = await _postService.postItemsAdvance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(),
      floatingActionButton: AddFloatingActionButton(context),
      body: Column(
        children: [Expanded(child: buildListView())],
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
        itemCount: _items?.length ?? 0,
        itemBuilder: (context, index) {
          return  _MyListTileWidget(models: _items![index],);
       });  }

  FloatingActionButton AddFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        child: Text(ProjectText.add));
  }

  ElevatedButton GetUserButton() {
    return ElevatedButton(
        onPressed: () {
          //getUser();
        },
        child: Text(ProjectText.get));
  }
}

class _MyListTileWidget extends StatelessWidget {
  final ActivityModel models;
  _MyListTileWidget({required this.models});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(models.city ?? ''),
      subtitle: Text(models.description ?? ''),
      trailing: ElevatedButton(
          onPressed: (() async {

          }),
          child: Text("Sil")),
      leading: ElevatedButton(
          onPressed: (() async {

          }),
          child: Text("Güncelle"))
    );
  }
}
