import {parse} from "./parser";

declare var describe, it;

describe("parser", () => {
    it("parses single element xml", () => {
        const xml = "<?xml version='1.1'?><!DOCTYPE note SYSTEM \"Note.dtd\">\n<Document url='somewhere.com' />";
        parse(xml);
    });

    it("parses multiple elements xml", () => {
        const xml = "<?xml version='1.1'?><!DOCTYPE note SYSTEM \"Note.dtd\">\n<Document url='somewhere.com'><Child url=\"http2\"/><Child url='http1'></Child></Document>";
        parse(xml);
    });
});

describe("parser visitor", () => {
    it("itterates processing instructions", () => {
        const xml = "<?xml version='1.1'?><?compile UI11?><Document url='test.page' />";
        parse(xml, {
            pe({target, data}) { console.log(`PE: ${target} ${data}`); }
        });
    });
})