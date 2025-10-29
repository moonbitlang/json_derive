///|
#json.generated
pub fn Pos::get_schema() -> Json {
  {
    "type": "object",
    "properties": {
      "tag": {
        "type": "string",
        "description": "stirng with enum",
        "enum": ["a", "b", "c"],
      },
      "int_arr": { "type": "array", "items": { "type": "integer" } },
      "str_with_default": {
        "type": "string",
        "description": "Optional string.\nThe type must be T?. A default value is not necessary.",
        "default": "*",
      },
      "str": { "type": "string" },
      "flag1": {
        "type": "boolean",
        "description": "Optional Boolean",
        "default": false,
      },
      "flag2": { "type": "integer", "default": 1 },
      "flag3": { "type": "number", "default": 1.2 },
      "rare_arr": { "type": "array", "items": { "type": ["integer", "null"] } },
    },
    "required": ["tag", "int_arr", "rare_arr"],
  }
}

