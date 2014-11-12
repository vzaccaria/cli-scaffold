
{docopt} = require('docopt')
require! 'fs'

doc = """
Usage:
    __name__ [-f FILE]
    __name__ -h | --help 

Options:
    -f, --file FILE     If no <input> is passed, it is read from stdin
"""

get-option = (a, b, def, o) ->
    if not o[a] and not o[b]
        return def
    else 
        return o[b]

o = docopt(doc)


filename      = get-option('-f' , '--file'     , '/dev/stdin'  , o)
output        = get-option('-o' , '--output'   , '/dev/stdout' , o)

filename = o["<input>"]
filename ?= '/dev/stdin'





