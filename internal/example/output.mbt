///|
#json.generated
pub fn Params::get_schema() -> Json {
  {
    "type": "object",
    "required": ["kind", "path", "regex"],
    "properties": {
      "kind": {
        "type": "string",
        "enum": ["regex", "moonbit_definition", "moonbit_references"],
        "description": "The kind of search to perform. \n'regex' performs traditional regex-based file content search. \n'moonbit_definition' performs fuzzy symbolic search to find MoonBit symbol definitions \n- note that when using 'moonbit_definition', \nthe regex parameter can be imprecise as the system will perform fuzzy search \nto find the most relevant symbols. 'moonbit_references' finds all references \nto a MoonBit symbol using the moon IDE tool.\",",
      },
      "path": {
        "type": "string",
        "description": "The path of the directory or file to search in, relative to the current working directory.",
      },
      "file_pattern": {
        "type": "string",
        "default": "*",
        "description": "Glob pattern to filter files (e.g., '*.ts', '*.js', '*.py', etc.). Defaults to '*' to search all files.",
      },
      "context_lines": {
        "type": "integer",
        "default": 2,
        "description": "Number of context lines to show before and after each match. Defaults to 2.",
      },
      "regex": {
        "type": "string",
        "description": "The search pattern. \nFor 'regex' kind: regular expression pattern with full regex syntax. \nFor 'moonbit_definition' kind: symbol name or partial name (can be imprecise) for fuzzy symbolic search.",
      },
    },
  }
}

///|
#json.generated
pub impl @moonbitlang/json_deriving.Decode for Params with decode(self, path) {
  match self {
    {
      "kind": x0,
      "path": x1,
      "file_pattern"? : x2,
      "context_lines"? : x3,
      "regex": x4,
      ..
    } =>
      {
        kind: @moonbitlang/json_deriving.Decode::decode(x0, Key(path, "x0")),
        path: @moonbitlang/json_deriving.Decode::decode(x1, Key(path, "x1")),
        file_pattern: match x2 {
          Some(value) =>
            Some(
              @moonbitlang/json_deriving.Decode::decode(value, Key(path, "x2")),
            )
          None => Some("*")
        },
        context_lines: match x3 {
          Some(value) =>
            Some(
              @moonbitlang/json_deriving.Decode::decode(value, Key(path, "x3")),
            )
          None => Some(2)
        },
        regex: @moonbitlang/json_deriving.Decode::decode(x4, Key(path, "x4")),
      }
    _ => @moonbitlang/json_deriving.fail(path, self)
  }
}

///|
#json.generated
pub impl @moonbitlang/json_deriving.Encode for Params with encode(self) {
  let result = {}
  result["kind"] = @moonbitlang/json_deriving.Encode::encode(self.kind)
  result["path"] = @moonbitlang/json_deriving.Encode::encode(self.path)
  if self.file_pattern is Some(value) {
    result["file_pattern"] = @moonbitlang/json_deriving.Encode::encode(value)
  }
  if self.context_lines is Some(value) {
    result["context_lines"] = @moonbitlang/json_deriving.Encode::encode(value)
  }
  result["regex"] = @moonbitlang/json_deriving.Encode::encode(self.regex)
  Json::object(result)
}

///|
#json.generated
pub fn Table::get_schema() -> Json {
  {
    "type": "object",
    "required": ["head", "tail", "tail2"],
    "properties": {
      "head": { "$ref": "#/definitions/Params" },
      "tail": { "type": "array", "items": { "type": "integer" } },
      "tail2": { "type": "array", "items": { "type": ["number", "null"] } },
    },
    "definitions": { "Params": Params::get_schema() },
  }
}

///|
#json.generated
pub impl @moonbitlang/json_deriving.Decode for Table with decode(self, path) {
  match self {
    { "head": x0, "tail": x1, "tail2": x2, .. } =>
      {
        head: @moonbitlang/json_deriving.Decode::decode(x0, Key(path, "x0")),
        tail: @moonbitlang/json_deriving.Decode::decode(x1, Key(path, "x1")),
        tail2: @moonbitlang/json_deriving.Decode::decode(x2, Key(path, "x2")),
      }
    _ => @moonbitlang/json_deriving.fail(path, self)
  }
}

///|
#json.generated
pub impl @moonbitlang/json_deriving.Encode for Table with encode(self) {
  let result = {}
  result["head"] = @moonbitlang/json_deriving.Encode::encode(self.head)
  result["tail"] = @moonbitlang/json_deriving.Encode::encode(self.tail)
  result["tail2"] = @moonbitlang/json_deriving.Encode::encode(self.tail2)
  Json::object(result)
}
