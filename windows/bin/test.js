str =
  "@@@@@@@@   @@      @@    @@@@@@@@    @@@@@@@@@@@   @@@    @@@   @@@@@@@@@@   @@@ @@@       @@@    @@@   @@@    @@@   @@@  @@       @@@    @@@   @@@    @@@   @@@   @@      @@@@@@@@@@   @@@    @@@   @@@  @@@      @@@@@@@@@@   @@@    @@@   @@@@@@@       @@@    @@@   @@@    @@@   @@@@@@@       @@@    @@@   @@@    @@@       @@@@@@@   @@@    @@@   @@@    @@@   @@@";

let i = 0;
let j = 0;

let list = str
  .split("")
  .map((c) => (c === "@" ? "1" : "0"))
  .reduce(
    (arr, c) => {
      let mini = arr[arr.length - 1];
      if (mini.length == 32) {
        arr.push(c);
      } else {
        arr[arr.length - 1] = `${mini}${c}`;
      }
      return arr;
    },
    [""]
  )
  .map((string) => parseInt(string.split("").reverse().join(""), 2))
  .reduce((list, number) => `${list} ${number.toString(16)}`, "(");

console.log(`${list})`);
