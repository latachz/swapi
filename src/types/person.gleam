import gleam/json
import gleam/dynamic
import gleam/result

// import swapi/error
pub type Person {
  Person(name: String, birth_year: String, eye_color: String)
}

pub fn parse_json(encoded: String) -> Result(Person, Error) {
  try data =
    json.decode(encoded)
    |> result.map_error(InvalidJson)

  let data = dynamic.from(data)

  try person =
    {
      try name = dynamic.field(data, "name")
      try name = dynamic.string(name)

      try birth_year = dynamic.field(data, "birth_year")
      try birth_year = dynamic.string(birth_year)

      try eye_color = dynamic.field(data, "eye_color")
      try eye_color = dynamic.string(eye_color)

      Ok(Person(name: name, birth_year: birth_year, eye_color: eye_color))
    }
    |> result.map_error(InvalidFormat)

  Ok(person)
}

pub type Error {
  InvalidJson(json.DecodeError)
  InvalidFormat(dynamic.DecodeError)
}
