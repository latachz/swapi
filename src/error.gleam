import gleam/json
import gleam/dynamic
import gleam/hackney

pub type ParseError {
  InvalidJson(json.DecodeError)
  InvalidFormat(dynamic.DecodeError)
  HttpError(hackney.Error)
}
