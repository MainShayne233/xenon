import gleam/atom.{Atom}
import gleam/io
import gleam/result
import gleam/string

pub type XmlElement {
  XmlElement(name: String)
}

type RawDoc =
  tuple(Atom, Atom)

external fn do_scan(input: String) -> anything =
  "xenon_bridge" "scan_xml_string"

fn scan(input: String) -> Result(RawDoc, String) {
  case do_scan(input) {
    Ok(doc) -> Ok(doc)
    Error(_) -> Error("Invalid XML")
  }
}

fn parse_xml_element(doc: RawDoc) -> Result(XmlElement, String) {
  assert tuple(_, atom_name, _, _, _, _, _, _, _, _, _, _) = doc
  let name = atom.to_string(atom_name)
  Ok(XmlElement(name))
}

fn do_parse(doc: RawDoc) -> Result(XmlElement, String) {
  let xml_element_atom = atom.create_from_string("xmlElement")
  case doc {
    tuple(label, _, _, _, _, _, _, _, _, _, _, _) -> parse_xml_element(doc)
    other -> {
      io.debug(other)
      Error("Unhandled node type")
    }
  }
}

pub fn parse(input: String) -> Result(XmlElement, String) {
  input
  |> scan()
  |> result.then(do_parse)
}
