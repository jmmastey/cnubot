# Description:
#   Live the values, bruh. Listens for common phrases and adds snark.
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

  robot.hear /operat(e|ing) as an owner/i, (msg) ->
    msg.send "Core Value Detected: Closing Credit Gap"

  robot.hear /operat(e|ing) as (joe decosmo|dave fisher)/i, (msg) ->
    msg.send "Core Owner Detected: Operating as a Value"

  robot.hear /^ncbot core value me/, (msg) ->
    msg.send "Oh come on, I was kidding. Did you seriously just try that?"

  robot.hear /kill(s|ed|ing)?( off)? cnuapp/, (msg) ->
    msg.send "Don't hate."

  robot.hear /order(ing|s|ed)? food/, (msg) ->
    msg.send "Remember to put in a JIRA ticket. Twenty-four hours advance notice is required."
