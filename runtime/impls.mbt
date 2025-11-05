///|
pub impl Encode for Int with encode(self) {
  Json::number(self.to_double())
}

///|
pub impl Decode for Int with decode(self, path) {
  match self {
    Number(n, ..) => n.to_int()
    _ => fail(path, self)
  }
}

///|
pub impl Encode for Double with encode(self) {
  Json::number(self)
}

///|
pub impl Decode for Double with decode(self, path) {
  match self {
    Number(n, ..) => n
    _ => fail(path, self)
  }
}

///|
pub impl Encode for String with encode(self) {
  Json::string(self)
}

///|
pub impl Decode for String with decode(self, path) {
  match self {
    String(s) => s
    _ => fail(path, self)
  }
}

///|
pub impl Encode for Bool with encode(self) {
  Json::boolean(self)
}

///|
pub impl Decode for Bool with decode(self, path) {
  match self {
    True => true
    False => false
    _ => fail(path, self)
  }
}

///|
pub impl Encode for Int16 with encode(self) {
  Json::number(self.to_int().to_double())
}

///|
pub impl Decode for Int16 with decode(self, path) {
  match self {
    Number(n, ..) => {
      let i = n.to_int()
      if i >= -32768 && i <= 32767 {
        i.to_int16()
      } else {
        fail(path, self)
      }
    }
    _ => fail(path, self)
  }
}

///|
pub impl Encode for Int64 with encode(self) {
  Json::number(self.to_double())
}

///|
pub impl Decode for Int64 with decode(self, path) {
  match self {
    Number(n, ..) => n.to_int64()
    _ => fail(path, self)
  }
}

///|
pub impl Encode for UInt with encode(self) {
  Json::number(self.to_double())
}

///|
pub impl Decode for UInt with decode(self, path) {
  match self {
    Number(n, ..) => if n >= 0.0 { n.to_uint() } else { fail(path, self) }
    _ => fail(path, self)
  }
}

///|
pub impl Encode for UInt64 with encode(self) {
  Json::number(self.to_double())
}

///|
pub impl Decode for UInt64 with decode(self, path) {
  match self {
    Number(n, ..) => if n >= 0.0 { n.to_uint64() } else { fail(path, self) }
    _ => fail(path, self)
  }
}

///|
pub impl Encode for Float with encode(self) {
  Json::number(self.to_double())
}

///|
pub impl Decode for Float with decode(self, path) {
  match self {
    Number(n, ..) => n.to_float()
    _ => fail(path, self)
  }
}

///|
pub impl[T : Encode] Encode for T? with encode(self) {
  match self {
    None => Json::null()
    Some(x) => x.encode()
  }
}

///|
pub impl[T : Decode] Decode for T? with decode(self, path) {
  match self {
    Null => None
    _ => Some(Decode::decode(self, path))
  }
}

///|
pub impl[T : Encode, E : Encode] Encode for Result[T, E] with encode(self) {
  match self {
    Ok(v) => { "type": "Ok", "0": v.encode() }
    Err(e) => { "type": "Err", "0": e.encode() }
  }
}

///|
pub impl[T : Decode, E : Decode] Decode for Result[T, E] with decode(self, path) {
  match self {
    { "type": "Ok", "0": v, .. } => Ok(decode(v, path=Key(path, "0")))
    { "type": "Err", "0": e, .. } => Err(decode(e, path=Key(path, "0")))
    _ => fail(path, self)
  }
}

///|
pub impl[T : Encode] Encode for Array[T] with encode(self) {
  Json::array(self.map(Encode::encode))
}

///|
pub impl[T : Decode] Decode for Array[T] with decode(self, path) {
  match self {
    Array(jsons) => {
      let r = []
      for i, json in jsons {
        r.push(Decode::decode(json, Index(path, i)))
      }
      r
    }
    _ => fail(path, self)
  }
}
