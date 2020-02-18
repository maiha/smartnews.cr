### stdlib
require "file_utils"

### shard
require "clickhouse"
require "cmds"
require "json"
require "opts"
require "protobuf-storage"
require "shell"
require "toml-config"

### lib
require "../smartnews"

### app
require "./ext/**"
require "./lib/**"
# require "./data/**"
require "./smartnews/**"
require "./helpers/**"
require "./cmds/**"
