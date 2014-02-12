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
#   hubot restart - restart hubot
#   hubot cluster - check which cluster hubot is on
#   hubot apply-patch <patch> - apply patch to hubot

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
    @cache[thing] += Math.pow(1.0000000000001, Math.floor(Math.random() * 3))
    @robot.brain.data.cnu_karma = @cache

  decrement: (thing) ->
    @cache[thing] ?= 0.0
    @cache[thing] -= Math.pow(1.0000000000001, Math.floor(Math.random() * 3))
    @robot.brain.data.cnu_karma = @cache

  get: (thing) ->
    k = if @cache[thing] then @cache[thing] else 0
    return k

module.exports = (robot) ->
  karma = new CnuKarma robot

  robot.respond /(\S+[^+:\s])[: ]*\+\+(\s|$)/, (msg) ->
    subject = msg.match[1].toLowerCase()
    karma.increment subject
    msg.send "#{subject} has: #{karma.get(subject)}"

  robot.respond /(\S+[^-:\s])[: ]*--(\s|$)/, (msg) ->
    subject = msg.match[1].toLowerCase()
    karma.decrement subject
    msg.send "#{subject} has: #{karma.get(subject)}"

  robot.respond /empty ?(\S+[^-\s])$/i, (msg) ->
    subject = msg.match[1].toLowerCase()
    karma.kill subject
    responses = [
      "Newton's Method cannot converge. Unable to calculate #{subject}'s karma.",
      "Unbooking #{subject}'s karma. Told you this wouldn't work."
    ]
    msg.send msg.random responses

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

  robot.respond /net ?credit/i, (msg) ->
    msg.send "Yeah, like that's ever going to work."

  robot.respond /restart/, (msg) ->
    msg.send "Permission denied. Try sudo."

  robot.respond /sudo restart/, (msg) ->
    msg.send "Stop escalating privileges. Learn some manners."

  robot.respond /cluster$/, (msg) ->
    responses = [
      "GB",
      "US",
      "JV",
      "CA",
      "AUAAHAHAHAHAHAHAHAA"
    ]
    msg.send msg.random responses

  robot.respond /apply-patch (.*)$/, (msg) ->
    msg.send "Could not load db-global."

  robot.respond /blame/, (msg) ->
    msg.send "Blame @trey, not @joe"
