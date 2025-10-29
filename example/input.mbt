///|
/// doc for pos
#json.schema
struct Pos {
  /// stirng with enum
  #json.enumerate(string("a", "b", "c"))
  tag : String
  /// array of int
  int_arr : Array[Int]
  /// Optional string.
  /// The type must be T?. A default value is not necessary.
  #json.default(string("*"))
  str_with_default : String?
  str : String?
  /// Optional Boolean
  #json.default(boolean(false))
  flag : Bool?
  /// Array of `Int | null`. Should be rare used.
  rare_arr : Array[Int?]
}
