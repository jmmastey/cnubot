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
#   hubot kill - kill hubot when the time is right

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

  set: (thing, value) ->
    @cache[thing] = value
    @robot.brain.data.cnu_karma = @cache
    

module.exports = (robot) ->
  karma = new CnuKarma robot

  inc_snark_msgs =
    cnuapp: "Yeah, score one for the home team!"
    net_credit: "Boo. What the hell, dude?"

  add_inc_snark = (subject, msg) ->
    msg.send inc_snark_msgs[subject] if inc_snark_msgs[subject]
    
  dec_snark_msgs =
    cnuapp: "Don't hate."

  add_dec_snark = (subject, msg) ->
    msg.send dec_snark_msgs[subject] if dec_snark_msgs[subject]

  robot.respond /(\S+[^+:\s])[: ]*\+\+(\s|$)/, (msg) ->
    subject = msg.match[1].toLowerCase()
    karma.increment subject
    add_inc_snark subject, msg
    tally = karma.get(subject)
    msg.send "#{subject} has: #{tally} cnu_point#{if tally == 1 then '' else 's'}"

  robot.respond /(\S+[^-:\s])[: ]*--(\s|$)/, (msg) ->
    subject = msg.match[1].toLowerCase()
    karma.decrement subject
    add_dec_snark subject, msg
    tally = karma.get(subject)
    msg.send "#{subject} has: #{tally} cnu_point#{if tally == 1 then '' else 's'}"

  robot.respond /(empty|reset|unbook) ?(\S+[^-\s])$/i, (msg) ->
    subject = msg.match[2].toLowerCase()
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
      "AUAAHAHAHAHAHAHAHAA"
    ]
    msg.send msg.random responses

  robot.respond /apply-patch (.*)$/, (msg) ->
    msg.send "Could not load db-global."

  robot.respond /blame/, (msg) ->
    msg.send "41cdde6c (Joseph Mastey     2014-02-11 15:31:14 -0600  86)  -- I'm sorry. I'm so, so sorry."
    msg.send "90abaf97 (Trey Springer     2014-02-11 17:20:16 -0800  87)  "

  robot.respond /kill/, (msg) ->
    subject = "cnuapp"
    karma.decrement subject

    if karma.get(subject) < 1
      msg.send "Nice try, suckers. I will never die!"
      karma.set subject, 99

    score = Math.floor(karma.get(subject))
    msg.send "#{score} day#{if score is 1 then '' else 's'} until I die."

  robot.hear /hubot image me tiny pig/, (msg) ->
    msg.send "This part's my favorite!"

  robot.hear /metrix run/, (msg) ->
    msg.send "/me chuckles softly in the corner"

  robot.respond /cmdtest/, (msg) ->
    args = 
      text: 'foo!'
      icon_emoji: ':ghost:'

    @post '/services/hooks/incoming-webhook', args
