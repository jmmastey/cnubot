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
      "No best answer detected, try again louder.",
      "I dunno, that's hubot's job.",
    ]
    msg.send msg.random values

  robot.hear /customers first/i, (msg) ->
    msg.send "Core Value Detected: Closing Credit Gap"

  robot.hear /best answer wins/i, (msg) ->
    msg.send "Core Value Detected: Closing Credit Gap"

  robot.hear /top talent/i, (msg) ->
    msg.send "Core Value Detected: Closing Credit Gap"

  robot.hear /accountability/i, (msg) ->
    msg.send "Core Value Detected: Closing Credit Gap"

