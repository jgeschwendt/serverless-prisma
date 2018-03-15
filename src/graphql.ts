import { GraphQLServerLambda } from 'graphql-yoga'
import { Prisma } from './generated/prisma'
import resolvers from './resolvers/resolvers'
import typeDefs from './schema/schema.graphql'

export const handler = (event, ctx, callback) => {
  (new GraphQLServerLambda({
    context: ctx => ({
      ...ctx,
      prisma: new Prisma({
        debug: process.env.PRISMA_DEBUG === 'true',
        endpoint: process.env.PRISMA_ENDPOINT,
        secret: process.env.PRISMA_SECRET
      })
    }),
    resolvers,
    typeDefs
  })).graphqlHandler(event, ctx, callback)
}
