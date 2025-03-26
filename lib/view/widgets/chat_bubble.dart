part of 'package:supa_chat/view/chat_page.dart';

class _ChatBubble extends StatefulWidget {
  const _ChatBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final Message message;

  @override
  State<_ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<_ChatBubble>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final Stream<List<Reaction>> _reactionsStream;
  List<String> reactions = [];

  @override
  void initState() {
    super.initState();
    _reactionsStream = supabase
        .from('reactions')
        .stream(primaryKey: ['id'])
        .eq('message_id', widget.message.id)
        .order('created_at')
        .map((maps) => maps.map((map) => Reaction.fromMap(map: map)).toList());
  }

  @override
  void didUpdateWidget(_ChatBubble oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.message.id != widget.message.id) {
      _reactionsStream = supabase
          .from('reactions')
          .stream(primaryKey: ['id'])
          .eq('message_id', widget.message.id)
          .order('created_at')
          .map(
              (maps) => maps.map((map) => Reaction.fromMap(map: map)).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<Widget> chatContents = [
      GestureDetector(
        onLongPress: () => Navigator.of(context).push(
          HeroDialogRoute(
            builder: (context) {
              return ReactionsDialogWidget(
                id: widget.message.id,
                messageWidget: MessageWidget(
                    key: ValueKey(widget.message.id),
                    widget.message,
                    _reactionsStream),
                onReactionTap: (reaction) async {
                  try {
                    await supabase.from("reactions").insert({
                      'message_id': widget.message.id,
                      'profile_id': widget.message.profileId,
                      'value': reaction
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                onContextMenuTap: (menuItem) {},
              );
            },
          ),
        ),
        child: Hero(
            tag: widget.message.id,
            child: MessageWidget(widget.message, _reactionsStream)),
      ),
    ];
    if (widget.message.isMine) {
      chatContents = chatContents.reversed.toList();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
      child: Row(
        mainAxisAlignment: widget.message.isMine
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: chatContents,
      ),
    );
  }
}

class MessageWidget extends StatefulWidget {
  const MessageWidget(this.message, this.stream, {super.key});
  final Stream<List<Reaction>> stream;

  final Message message;

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<String> reactions = [];
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Align(
      alignment:
          widget.message.isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
          minWidth: MediaQuery.of(context).size.width * 0.3,
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            buildMessage(context),
            buildReactions(widget.message.isMine),
          ],
        ),
      ),
    );
  }

  Widget buildReactions(bool isMine) {
    return Positioned(
      bottom: 4,
      left: isMine ? 8 : 20,
      child: StreamBuilder<List<Reaction>>(
        stream: widget.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final value = snapshot.data ?? [];

          reactions = value.map((e) => e.value).toList();

          return StackedReactions(
            reactions: reactions,
          );
        },
      ),
    );
  }

  Widget buildMessage(BuildContext context) {
    final padding = reactions.isNotEmpty
        ? widget.message.isMine
            ? const EdgeInsets.only(left: 30.0, bottom: 25.0)
            : const EdgeInsets.only(right: 30.0, bottom: 25.0)
        : const EdgeInsets.only(bottom: 0.0);

    final borderRadius = widget.message.isMine
        ? const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          );

    final cardColor = widget.message.isMine
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;

    final textColor = widget.message.isMine
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSecondary;

    return Padding(
      padding: padding,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: widget.message.isMine
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Text(
                  widget.message.content,
                  style: TextStyle(
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      format(widget.message.createdAt, locale: 'en_short'),
                      style: TextStyle(
                        fontSize: 12,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
