import { QueryResolvers } from '../generated/graphqlgen'

export const Query: QueryResolvers.Type = {
  node: () => true,
  feed: (parent, args, ctx) => ctx.db.posts({ where: { isPublished: true } })
}
