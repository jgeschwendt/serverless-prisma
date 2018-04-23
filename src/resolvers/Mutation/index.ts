// https://medium.freecodecamp.org/how-to-reverse-a-string-in-javascript-in-3-different-ways-75e4763c68cb
function reverse (str) {
  return (str === '') ? '' : reverse(str.substr(1)) + str.charAt(0)
}

export default {
  ping (_, { id }) {
    return reverse(id)
  }
}
