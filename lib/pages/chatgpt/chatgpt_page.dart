import 'package:dart_openai/src/core/models/model/model.dart';
import 'package:flareline/components/buttons/button_widget.dart';
import 'package:flareline/components/card/common_card.dart';
import 'package:flareline/components/forms/checkbox_widget.dart';
import 'package:flareline/components/forms/outborder_text_form_field.dart';
import 'package:flareline/core/theme/global_colors.dart';
import 'package:flareline/pages/chatgpt/chatgpt_provider.dart';
import 'package:flareline/pages/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:provider/provider.dart';

class ChatGptPage extends LayoutWidget {
  @override
  // TODO: implement isContentScroll
  bool get isContentScroll => false;

  @override
  Widget contentDesktopWidget(BuildContext context) {
    return ChangeNotifierProvider(
        create: (ctx) => ChatGptProvider(ctx),
        builder: (ctx, widget) {
          return Column(
            children: [
              Text('Use OpenAI'),
              SizedBox(
                height: 20,
              ),
              CommonCard(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: ctx
                            .watch<ChatGptProvider>()
                            .models
                            .map((e) => checkBoxWidget(e, ctx))
                            .toList(),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 80,
                child: CommonCard(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: OutBorderTextFormField(
                        hintText: 'enter your text',
                        controller: ctx.read<ChatGptProvider>().controller,
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 100,
                        child: ButtonWidget(
                          btnText: 'Send',
                          onTap: () {
                            ctx.read<ChatGptProvider>().startScrapy(ctx);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    CommonCard(
                        padding: EdgeInsets.all(10),
                        child: SingleChildScrollView(
                            child: MarkdownBlock(
                                data: ctx.watch<ChatGptProvider>().text))),
                    if (ctx.watch<ChatGptProvider>().isLoading)
                      Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          width: 100,
                          height: 100,
                        ),
                      )
                  ],
                ),
              )
            ],
          );
        });
  }

  CheckBoxWidget checkBoxWidget(OpenAIModelModel e, BuildContext ctx) {
    bool isChecked = ctx
        .select<ChatGptProvider, bool>((provider) => provider.isChecked(e.id));
    return CheckBoxWidget(
      size: 30,
      text: e.id,
      value: e.id,
      color: GlobalColors.green,
      checked: isChecked,
      onChanged: (checked, v) {
        ctx.read<ChatGptProvider>().checkedId = v;
      },
    );
  }

  @override
  String breakTabTitle(BuildContext context) {
    return 'ChatGpt';
  }
}