return {
    parse({
        trig = "zbb",
        wordTrig = false,
        snippetType = "autosnippet"
    }, [[
    **$1**$0
    ]]),
    parse({
        trig = "zb",
        wordTrig = false,
    }, [[
    **$1**$0
    ]]),
    parse({
        trig = "ee",
        wordTrig = false,
    }, [[
    $$1$ $0
    ]]),
}
