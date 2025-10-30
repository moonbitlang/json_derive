///|
fn main {
  try {
    guard @wasi.args_get() is [_, input, "-o", output] else {
      fail(
        "Invalid arguments. Usage: derive_json_schema input.mbt -o output.mbt",
      )
    }
    guard input.has_suffix(".mbt") else {
      fail("Invalid argument: \{input} is not a .mbt file")
    }
    let source = read_text_file(input) catch { e => reraise(e) }
    let (ast, report) = @parser.parse_string(source)
    guard report is [] else {
      fail("Parse error in \{input}: \{report.to_json().stringify(indent=2)}")
    }
    let ast = derive_json_schema(ast)
    let result = @formatter.impls_to_string(ast)
    write_text_file(output, result) catch {
      e => reraise(e)
    }
  } catch {
    e => {
      eprintln(e.to_string())
      exit(1)
    }
  }
}
