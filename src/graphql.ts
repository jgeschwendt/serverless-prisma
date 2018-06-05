import { GraphQLServerLambda } from 'graphql-yoga'
import { Prisma } from './generated/prisma'
import resolvers from './resolvers/resolvers'
import typeDefs from './schema/schema.graphql'

export const handler = (event, ctx, callback) => {
  try {
    const server = new GraphQLServerLambda({
      context: (ctx: { prisma: Prisma }) => ({
        ...ctx,
        prisma: new Prisma({
          debug: process.env.PRISMA_DEBUG === 'true',
          endpoint: process.env.PRISMA_ENDPOINT,
          secret: process.env.PRISMA_SECRET
        })
      }),
      resolvers,
      typeDefs
    })

    server.graphqlHandler(event, ctx, (error, output) => {
      callback(error, { ...output, statusCode: 200 })
    })
  } catch (exception) {
    console.log(exception)
  }
}
