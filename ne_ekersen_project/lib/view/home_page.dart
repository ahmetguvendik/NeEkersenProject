import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ne_ekersen_project/service/model/activity_model.dart';

import '../service/Interfaces/post_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ActivityModel>? _items;
  late final Dio _network;
  final _baseUrl = "https://localhost:7123/api/Activity/";
  String? message;
  TextEditingController _titleControler = TextEditingController();
  TextEditingController _datecontoller = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _venueController = TextEditingController();
  late final IPostService _postService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _postService = PostService();
    _network = Dio(BaseOptions(baseUrl: _baseUrl));
  }

  Future<void> AddPostAdvance(ActivityModel model) async {
    final response = _postService.AddPostAdvance(model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children:  [
          _ContainerWidget(text: "Title",labelText: "Title",controller: _titleControler,),
          _ContainerWidget(text: "Date",labelText: "Date",controller: _datecontoller,),
          _ContainerWidget(text: "Description",labelText: "Description",controller: _descController,),
          _ContainerWidget(text: "Category",labelText: "Category",controller: _categoryController,),
          _ContainerWidget(text: "City",labelText: "City",controller: _cityController,),
          _ContainerWidget(text: "Venue",labelText: "Venue",controller: _venueController,),
         ElevatedButton(onPressed: (){
           final model = ActivityModel(
             title: _titleControler.text,
             date: _datecontoller.text,
             description: _descController.text,
             category: _categoryController.text,
             city: _cityController.text,
             venue: _venueController.text
           );
           AddPostAdvance(model);
         }, child: Text("Kaydet"))
        ],
      ),
    );
  }
}




class _ContainerWidget extends StatelessWidget {
   String text;
   String labelText;
   TextEditingController controller;
  _ContainerWidget({required this.text,required this.labelText,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.88,
              child: Form(
                child: TextFormField(
                   controller: controller,
                  decoration: InputDecoration(
                    hintText: text,
                    hintStyle: TextStyle(color: Colors.blue),
                    labelText: labelText,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
