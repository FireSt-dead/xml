"use strict";
var parser_1 = require("./parser");
describe("parser", function () {
    it("parses single element xml", function () {
        var xml = "<?xml version='1.1'?><!DOCTYPE note SYSTEM \"Note.dtd\">\n<Document url='somewhere.com' />";
        parser_1.parse(xml);
    });
    it("parses multiple elements xml", function () {
        var xml = "<?xml version='1.1'?><!DOCTYPE note SYSTEM \"Note.dtd\">\n<Document url='somewhere.com'><Child url=\"http2\"/><Child url='http1'></Child></Document>";
        parser_1.parse(xml);
    });
});
describe("parser visitor", function () {
    it("itterates processing instructions", function () {
        var xml = "<?xml version='1.1'?><?compile UI11?><Document url='test.page' />";
        parser_1.parse(xml, {
            pe: function (_a) {
                var target = _a.target, data = _a.data;
                console.log("PE: " + target + " " + data);
            }
        });
    });
});
