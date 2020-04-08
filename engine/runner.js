const fs = require("fs");
const readline = require("readline");

const records = [];
const reader = readline.createInterface({
  input: fs.createReadStream("data/words.json"),
  console: false,
});

reader.on("line", (line) => {
  const record = JSON.parse(line);
  const filteredRecord = {
    word: record.word,
    difficulty: record.difficultyScore["$numberInt"],
    definitions: record.definitions,
    reading: record.reading,
    isNoun: record.isNoun,
  };
  records.push(filteredRecord);
});

reader.on("close", () => {
  fs.writeFile("data/records.json", JSON.stringify(records), () => {
    console.log("Writing...");
  });
});
