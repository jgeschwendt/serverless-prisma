import GraphQLPlayground from 'graphql-playground-middleware-lambda'
export const handler = GraphQLPlayground({ endpoint: process.env.IS_OFFLINE ? '/' : '/dev/' })
