import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnlab/features/chat/model/chat_message_model.dart';
import 'package:lottie/lottie.dart';

import '../bloc/chat_bloc.dart';

class AiChatPage extends StatefulWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => const AiChatPage());
  const AiChatPage({super.key});

  @override
  State<AiChatPage> createState() => _AiChatPageState();
}

class _AiChatPageState extends State<AiChatPage> {
  TextEditingController controller = TextEditingController();
  final ChatBloc chatBloc = ChatBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: chatBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case ChatSuccess:
              List<ChatMessageModel> messages = (state as ChatSuccess).message;
              return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      height: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ila',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Colors.black45)),
                          Icon(
                            Icons.broadcast_on_personal_outlined,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1.5,
                      color: Colors.black,
                      indent: 60,
                      endIndent: 60,
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 12, left: 16, right: 16),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17),
                                    color: Colors.amber.withOpacity(0.2),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        messages[index].role == "user"
                                            ? "User"
                                            : "Ila",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color:
                                                messages[index].role == "user"
                                                    ? Colors.amber
                                                    : Colors.purple.shade200),
                                      ),
                                      Text(messages[index].parts.first.text,
                                          style: TextStyle(
                                              height: 1.2, color: Colors.black))
                                    ],
                                  ));
                            })),
                    if (chatBloc.isGenerating)
                      Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: Lottie.asset("assets/loaders.json"),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Loading..')
                        ],
                      ),
                    Container(
                      height: 120,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                      child: Row(
                        children: [
                          Expanded(
                              child: TextField(
                                  controller: controller,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    fillColor: Colors.white,
                                    hintText: 'Ask Something to Ai',
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade400),
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        borderSide: BorderSide(
                                            color: Theme.of(context)
                                                .primaryColor)),
                                  ))),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              print(controller.text);
                              if (controller.text.isNotEmpty) {
                                String text = controller.text;
                                controller.clear();

                                chatBloc.add(ChatGenerateNewTextMessageEvent(
                                    inputMessage: text));
                              }
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.black,
                              child: Center(
                                child: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );

            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
