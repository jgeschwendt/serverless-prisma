import { Prisma } from '../../generated/prisma'

export default {
  node: () => {
    return true
  },
  feed: (parent, args, ctx: { prisma: Prisma }, info) => {
    console.log(info)
    return ctx.prisma.query.posts({ where: { isPublished: true } }, info)
  }
}
