# Description:
#   Cnuapp just don't understand.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot <name>++ - add some karma
#   hubot <name>-- - subtract some karma
#   hubot empty <name> - reset karma
#   hubot tests - check on test suite status

class CnuKarma

  constructor: (@robot) ->
    @cache = {}
    @robot.brain.on 'loaded', =>
      if @robot.brain.data.cnu_karma
        @cache = @robot.brain.data.cnu_karma

  kill: (thing) ->
    delete @cache[thing]
    @robot.brain.data.cnu_karma = @cache

  increment: (thing) ->
    @cache[thing] ?= 0.0
    @cache[thing] += Math.pow(1.0000000000001, Math.floor(Math.random() * 6))
    @robot.brain.data.cnu_karma = @cache

  decrement: (thing) ->
    @cache[thing] ?= 0.0
    @cache[thing] -= Math.pow(1.0000000000001, Math.floor(Math.random() * 6))
    @robot.brain.data.cnu_karma = @cache

  get: (thing) ->
    k = if @cache[thing] then @cache[thing] else 0
    return k

module.exports = (robot) ->
  karma = new CnuKarma robot

  robot.hear /(\S+[^+:\s])[: ]*\+\+(\s|$)/, (msg) ->
    subject = msg.match[1].toLowerCase()
    karma.increment subject
    msg.send "#{subject} has: #{karma.get(subject)}"

  robot.hear /(\S+[^-:\s])[: ]*--(\s|$)/, (msg) ->
    subject = msg.match[1].toLowerCase()
    karma.decrement subject
    msg.send "#{subject} has: #{karma.get(subject)}"

  robot.respond /empty ?(\S+[^-\s])$/i, (msg) ->
    subject = msg.match[1].toLowerCase()
    karma.kill subject
    msg.send "Newton's Method cannot converge. Unable to calculate #{subject}'s karma."

  robot.respond /tests?$/i, (msg) ->
    responses = [
      "Pass! No, fail!",
      "Fail! No, pass!",
      "Fails on Saturdays and Labor Day.",
      "All green."
      "Current time: 12:30:00 14 June 2124"
      "Cannot connect to cnubot.qa: certificate expired"
    ]
    msg.send msg.random responses
