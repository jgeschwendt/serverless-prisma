import { ApolloServer } from 'apollo-server-lambda'
import { prisma } from './generated/prisma-client'
import { resolvers } from './resolvers'
import typeDefs from './schema/schema.graphql'

const apiServerWorker = async () => {
  const server = new ApolloServer({
    context: (ctx) => ({ ...ctx, db: prisma }),
    resolvers,
    typeDefs
  })

  return server.createHandler({ cors: { origin: '*' } })
}

const apiServer = apiServerWorker()
export const handler = (event, context, callback) => {
  apiServer
    .then(server => server(event, context, callback))
    .catch(error => callback(error))
}
