var parser = require("./parser");

describe("parser", () => {
    it("parses single element xml", () => {
        const xml = "<?xml version='1.1'?><!DOCTYPE note SYSTEM \"Note.dtd\">\n<Document url='somewhere.com' />";
        var result = parser.parse(xml);
        // console.log(result.toString());
    });

    it("parses multiple elements xml", () => {
        const xml = "<?xml version='1.1'?><!DOCTYPE note SYSTEM \"Note.dtd\">\n<Document url='somewhere.com'><Child url=\"http2\"/><Child url='http1'></Child></Document>";
        var result = parser.parse(xml);
        // console.log(result.toString());
    });
});