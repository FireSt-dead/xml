var parser = require("./parser");
describe("parser", () => {
    it("file01.xml", () => {
        var result = parser.parse("<?xml version=\"1.0\" encoding=\"UTF-8\"?><!DOCTYPE note SYSTEM \"Note.dtd\">\n<Document url='somewhere.com' />");
        console.log(JSON.stringify(result));
    });
});