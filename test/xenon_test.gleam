import xenon.{XmlElement}
import gleam/should
import gleam/io

pub fn parse_test() {
  let ok_input = "<hello/>"
  let error_input = "hello/>"

  ok_input
  |> xenon.parse()
  |> should.be_ok()

  error_input
  |> xenon.parse()
  |> should.be_error()
}
