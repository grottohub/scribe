//// This contains some example functions showcasing how to build messages

import gleam/string
import glyph/builders/message
import glyph/clients/bot
import glyph/models/discord

/// This uses `reply_to`, which is Glyph's indicator that the message being
/// sent should be a direct reply to the given message
pub fn direct_reply(bot: discord.BotClient, msg: discord.Message) {
  let response =
    message.new()
    |> message.content("gleam mention")
    |> message.reply_to(msg)

  case string.contains(msg.content, "gleam") {
    True -> {
      let _ = bot.send(bot, msg.channel_id, response)
      Nil
    }
    False -> Nil
  }
}

/// This uses the `mentions_everyone` function, which is necessary when using @everyone
pub fn at_everyone(bot: discord.BotClient, channel_id: discord.Snowflake) {
  let important_message =
    message.new()
    |> message.content("@everyone y'all should check out gleam")
    |> message.mentions_everyone

  let _ = bot.send(bot, channel_id, important_message)

  Nil
}

/// This shows how to format a message to @ someone based on the message received
pub fn at_someone(bot: discord.BotClient, msg: discord.Message) {
  let welcome =
    message.new()
    |> message.content("welcome <@" <> msg.author.id <> ">!")

  case string.contains(msg.content, "im new here") {
    True -> {
      let _ = bot.send(bot, msg.channel_id, welcome)
      Nil
    }
    False -> Nil
  }
}
