///|
using @codegen {derive_json}

///|
fn main {
  try {
    let source = read_input() catch { e => reraise(e) }
    let (ast, report) = @parser.parse_string(source)
    guard report is [] else {
      fail("Parse error: \{report.to_json().stringify(indent=2)}")
    }
    let ast = derive_json(ast)
    let result = @formatter.impls_to_string(ast)
    println(result)
  } catch {
    e => {
      eprintln(e.to_string())
      exit(1)
    }
  }
}
