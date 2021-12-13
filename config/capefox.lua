local screenConfigTable = {}
screenConfigTable["LG HDR WQHD+"] = {
    mode = {
        w = 3840,
        h = 1600,
        scale = 1.0,
        freq = 120,
        depth = 7,
    },
    origin = {
        x = 0,
        y = 0,
    },
}
screenConfigTable["LG ULTRAGEAR"] = {
    mode = {
        w = 2560,
        h = 1440,
        scale = 1.0,
        freq = 120,
        depth = 7,
    },
    origin = {
        x = -2560,
        y = 0,
    },
}

return {
    screens = screenConfigTable,
}
