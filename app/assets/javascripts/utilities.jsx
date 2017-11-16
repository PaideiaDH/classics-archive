function createDataArray(arr) {
  arr = arr.split(',')
  var output = []
  for(var i=0; i < arr.length; i++) {
    n = {
      id: `${arr[i]}`,
      value: `${arr[i]}`,
      name: `${arr[i]}`,
      text: `${arr[i]}`,
      selected: 'selected'
    }
    output.push(n)
  }
  return output
}
