// Testing new webpack loader
const { importSchema, parseSDL } = require('graphql-import')
const { dirname, resolve } = require('path')

module.exports = function(source) {
  const callback = this.async()

  this.cacheable()

  parseSDL(source).forEach(rawModule => {
    this.addDependency(resolve(dirname(this.resourcePath), rawModule.from))
  })

  callback(null, `module.exports = \`${importSchema(this.resourcePath).replace(/`/g, '\\`')}\``)
}
