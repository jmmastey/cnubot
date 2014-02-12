# Description:
#   Live the values, bruh.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot core value me - select an appropriate core value

module.exports = (robot) ->
  robot.respond /core value me/, (msg) ->
    values = [
      "Customers fo life",
      "Operate as an owner. Pick one yourself.",
      "#{msg.message.user.name} is clearly not top talent.",
      "No best answer detected, try again more loudly.",
      "I have no idea, ask ncbot. Not my job",
    ]
    msg.send msg.random values

  robot.hear /customer'?s? first/i, (msg) ->
    msg.send "Core Value Detected: Closing Credit Gap"

  robot.hear /best answers?( wins?)?/i, (msg) ->
    msg.send "Core Value Detected: Closing Credit Gap"

  robot.hear /top (teamwork|talent)/i, (msg) ->
    msg.send "Core Value Detected: Closing Credit Gap"

  robot.hear /(accountability|accountable)/i, (msg) ->
    msg.send "Core Value Detected: Closing Credit Gap"

  robot.hear /^ncbot core value me/, (msg) ->
    msg.send "Oh come on, I was kidding. Did you seriously just try that?"
