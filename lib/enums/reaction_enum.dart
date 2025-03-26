enum ReactionEmoji {
  nothing(''),
  like('👍'),
  love('❤️'),
  laugh('😂'),
  wow('😮'),
  sad('😢'),
  angry('😡');

  final String icon;
  const ReactionEmoji(this.icon);
}
