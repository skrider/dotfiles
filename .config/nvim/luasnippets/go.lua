return {
    parse({
        trig = "enn",
        wordTrig = false,
    }, [[
    if err != nil {
        $1
    }$0
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
