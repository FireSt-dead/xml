interface Visitor {
    pe?(arg: { target: string, data: string }): void | Visitor;
}

export function parse(xml: string, options?: Visitor);