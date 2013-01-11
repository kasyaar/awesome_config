local io = require("io")
module("cli")
function run(command)
     local fh = io.popen(command)
     local str = ""
     for i in fh:lines() do
         str = str .. i
     end
     io.close(fh)
     return str
end
