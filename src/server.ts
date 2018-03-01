import { GraphQLServerLambda } from 'graphql-yoga'
import { Prisma } from './generated/prisma'

import resolvers from './resolvers/resolvers'
import typeDefs from './schema/schema.graphql'

const context = ctx => ({ ...ctx,
  db: new Prisma({
    debug: process.env.PRISMA_DEBUG === 'true',
    endpoint: process.env.PRISMA_ENDPOINT,
    secret: process.env.PRISMA_SECRET,
  })
});

export const { graphqlHandler, playgroundHandler } = (
  new GraphQLServerLambda({ context, resolvers, typeDefs })
)
