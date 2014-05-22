# Description:
#   Utility commands surrounding Hubot uptime.
#
# Commands:
#   hubot ping - regular ping
#   hubot pyong - improved ping

module.exports = (robot) ->
  robot.respond /PING$/i, (msg) ->
    msg.send "PONG"

   robot.respond /PYONG$/i, (msg) ->
    msg.send "YANG"

  robot.respond /ECHO (.*)$/i, (msg) ->
    msg.send msg.match[1]

  robot.respond /TIME$/i, (msg) ->
    msg.send "Server time is: #{new Date()}"

  robot.respond /DIE$/i, (msg) ->
    msg.send "Goodbye, cruel world."
    process.exit 0

