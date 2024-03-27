# scribe

This is the source code for my bot `scribe`, which I use to test my Discord library [Glyph](https://github.com/grottohub/glyph).

If you want to know how to implement something in Glyph, this is probably the best place to look. I'll do my best to keep this up to date with new examples and features in cadence with Glyph releases.

If you're developing for Glyph, feel free to use this repo (since the `gleam.toml` points to a local version of Glyph), just remember to set your `DISCORD_TOKEN` to be that of your personal testing bot.

Further documentation for Glyph can be found at <https://hexdocs.pm/glyph>.

## Basic Example

```gleam
import gleam/erlang/process
import envoy
import logging
import glyph/clients/bot
import glyph/models/discord

pub type LogLevel {
  Debug
}

pub type Log {
  Level
}

@external(erlang, "logger", "set_primary_config")
fn set_logger_level(log: Log, level: LogLevel) -> Nil

pub fn message_handler(
  b: bot.Bot,
  m: discord.Message,
) -> Result(Nil, discord.DiscordError) {
  case m.content {
    "!ping" -> {
      let _ =
        b
        |> bot.send(m.channel_id, discord.MessagePayload("Pong!"))
      Nil
    }
    _ -> Nil
  }

  Ok(Nil)
}

pub fn main() {
  logging.configure()
  set_logger_level(Level, Debug)

  let discord_token = case envoy.get("DISCORD_TOKEN") {
    Ok(token) -> token
    Error(_) -> ""
  }

  let assert Ok(scribe) =
    bot.new(discord_token, "https://github.com/grottohub/scribe", "1.0.0")
    |> bot.set_intents([discord.GuildMessages, discord.MessageContent])
    |> bot.on_message_create(message_handler)
    |> bot.initialize

  let _ =
    scribe
    |> bot.send("CHANNEL_ID", discord.MessagePayload("Hello!"))

  process.sleep_forever()
}
```
