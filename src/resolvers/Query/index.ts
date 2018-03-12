export default {
  feed: (parent, args, ctx, info) => (
    ctx.prisma.query.posts({ where: { isPublished: true } }, info)
  ),
}
