import gleam/erlang/process
import envoy
import logging
import glyph/clients/bot
import glyph/models/discord
import examples/embeds
import examples/messages

pub type LogLevel {
  Debug
}

pub type Log {
  Level
}

@external(erlang, "logger", "set_primary_config")
fn set_logger_level(log: Log, level: LogLevel) -> Nil

pub fn message_handler(
  b: discord.BotClient,
  m: discord.Message,
) -> Result(Nil, discord.DiscordError) {
  messages.direct_reply(b, m)
  messages.at_someone(b, m)

  Ok(Nil)
}

pub fn main() {
  logging.configure()
  set_logger_level(Level, Debug)

  let assert Ok(discord_token) = envoy.get("DISCORD_TOKEN")
  let assert Ok(channel_id) = envoy.get("CHANNEL_ID")

  let assert Ok(scribe) =
    bot.new(discord_token, "https://github.com/grottohub/scribe", "1.0.0")
    |> bot.set_intents([discord.GuildMessages, discord.MessageContent])
    |> bot.on_message_create(message_handler)
    |> bot.initialize

  scribe
  |> embeds.example_tumblr_post(channel_id)

  scribe
  |> embeds.example_fields(channel_id)

  process.sleep_forever()
}
