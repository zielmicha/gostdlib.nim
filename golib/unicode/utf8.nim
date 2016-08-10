include gosupport
const 
  runeError* = runelit(0xFFFD)
  runeSelf* = 0x80
  maxRune* = runelit(0x0010FFFF)
  UTFMax* = 4
const 
  surrogateMin = 0xD800
  surrogateMax = 0xDFFF
const 
  t1 = 0x00
  tx = 0x80
  t2 = 0xC0
  t3 = 0xE0
  t4 = 0xF0
  t5 = 0xF8
  maskx = 0x3F
  mask2 = 0x1F
  mask3 = 0x0F
  mask4 = 0x07
  rune1Max = ((1 shl 7) - 1)
  rune2Max = ((1 shl 11) - 1)
  rune3Max = ((1 shl 16) - 1)
  locb = 0x80
  hicb = 0xBF
  xx = 0xF1
  `as` = 0xF0
  s1 = 0x02
  s2 = 0x13
  s3 = 0x03
  s4 = 0x23
  s5 = 0x34
  s6 = 0x04
  s7 = 0x44

exttypes:
  type
    AcceptRange* = struct((lo: uint8, hi: uint8))

proc fullRune*(p: GoSlice[byte]): bool {.gofunc.}
proc fullRuneInString*(s: string): bool {.gofunc.}
proc decodeRune*(p: GoSlice[byte]): tuple[r: Rune, size: int] {.gofunc.}
proc decodeRuneInString*(s: string): tuple[r: Rune, size: int] {.gofunc.}
proc decodeLastRune*(p: GoSlice[byte]): tuple[r: Rune, size: int] {.gofunc.}
proc decodeLastRuneInString*(s: string): tuple[r: Rune, size: int] {.gofunc.}
proc runeLen*(r: Rune): int {.gofunc.}
proc encodeRune*(p: GoSlice[byte], r: Rune): int {.gofunc.}
proc runeCount*(p: GoSlice[byte]): int {.gofunc.}
proc runeCountInString*(s: string): int {.gofunc.}
proc runeStart*(b: byte): bool {.gofunc.}
proc valid*(p: GoSlice[byte]): bool {.gofunc.}
proc validString*(s: string): bool {.gofunc.}
proc validRune*(r: Rune): bool {.gofunc.}
var first = [uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(`as`), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s1), uint8(s2), uint8(s3), uint8(s3), uint8(s3), uint8(s3), uint8(s3), uint8(s3), uint8(s3), uint8(s3), uint8(s3), uint8(s3), uint8(s3), uint8(s3), uint8(s4), uint8(s3), uint8(s3), uint8(s5), uint8(s6), uint8(s6), uint8(s6), uint8(s7), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx), uint8(xx)].make(GoArray[uint8, 256])
var acceptRanges = {0: make((locb, hicb), AcceptRange), 1: make((0xA0, hicb), AcceptRange), 2: make((locb, 0x9F), AcceptRange), 3: make((0x90, hicb), AcceptRange), 4: make((locb, 0x8F), AcceptRange)}.make(GoAutoArray[AcceptRange])


proc fullRune(p: GoSlice[byte]): bool =
  var n = len(p)
  if (n == 0):
    return false
  var x = first[p[0]]
  if (n >= convert(int, (x and 7))):
    return true
  var accept = acceptRanges[(x shr 4)]
  if (n > 1):
    if (var c = p[1]; ((c < accept.lo) or (accept.hi < c))):
      return true
    elif ((n > 2) and (((p[2] < locb) or (hicb < p[2])))):
      return true
  return false

proc fullRuneInString(s: string): bool =
  var n = len(s)
  if (n == 0):
    return false
  var x = first[s[0]]
  if (n >= convert(int, (x and 7))):
    return true
  var accept = acceptRanges[(x shr 4)]
  if (n > 1):
    if (var c = s[1]; ((c < accept.lo) or (accept.hi < c))):
      return true
    elif ((n > 2) and (((s[2] < locb) or (hicb < s[2])))):
      return true
  return false

proc decodeRune(p: GoSlice[byte]): tuple[r: Rune, size: int] =
  var n = len(p)
  if (n < 1):
    (result.r, result.size) = (runeError, 0)
    return
  var p0 = p[0]
  var x = first[p0]
  if (x >= `as`):
    var mask = ((convert(Rune, x) shl 31) shr 31)
    (result.r, result.size) = (((convert(Rune, p[0]) and (not mask)) or (runeError and mask)), 1)
    return
  var sz = (x and 7)
  var accept = acceptRanges[(x shr 4)]
  if (n < convert(int, sz)):
    (result.r, result.size) = (runeError, 1)
    return
  var b1 = p[1]
  if ((b1 < accept.lo) or (accept.hi < b1)):
    (result.r, result.size) = (runeError, 1)
    return
  if (sz == 2):
    (result.r, result.size) = (((convert(Rune, (p0 and mask2)) shl 6) or convert(Rune, (b1 and maskx))), 2)
    return
  var b2 = p[2]
  if ((b2 < locb) or (hicb < b2)):
    (result.r, result.size) = (runeError, 1)
    return
  if (sz == 3):
    (result.r, result.size) = ((((convert(Rune, (p0 and mask3)) shl 12) or (convert(Rune, (b1 and maskx)) shl 6)) or convert(Rune, (b2 and maskx))), 3)
    return
  var b3 = p[3]
  if ((b3 < locb) or (hicb < b3)):
    (result.r, result.size) = (runeError, 1)
    return
  (result.r, result.size) = (((((convert(Rune, (p0 and mask4)) shl 18) or (convert(Rune, (b1 and maskx)) shl 12)) or (convert(Rune, (b2 and maskx)) shl 6)) or convert(Rune, (b3 and maskx))), 4)
  return

proc decodeRuneInString(s: string): tuple[r: Rune, size: int] =
  var n = len(s)
  if (n < 1):
    (result.r, result.size) = (runeError, 0)
    return
  var s0 = s[0]
  var x = first[s0]
  if (x >= `as`):
    var mask = ((convert(Rune, x) shl 31) shr 31)
    (result.r, result.size) = (((convert(Rune, s[0]) and (not mask)) or (runeError and mask)), 1)
    return
  var sz = (x and 7)
  var accept = acceptRanges[(x shr 4)]
  if (n < convert(int, sz)):
    (result.r, result.size) = (runeError, 1)
    return
  var s1 = s[1]
  if ((s1 < accept.lo) or (accept.hi < s1)):
    (result.r, result.size) = (runeError, 1)
    return
  if (sz == 2):
    (result.r, result.size) = (((convert(Rune, (s0 and mask2)) shl 6) or convert(Rune, (s1 and maskx))), 2)
    return
  var s2 = s[2]
  if ((s2 < locb) or (hicb < s2)):
    (result.r, result.size) = (runeError, 1)
    return
  if (sz == 3):
    (result.r, result.size) = ((((convert(Rune, (s0 and mask3)) shl 12) or (convert(Rune, (s1 and maskx)) shl 6)) or convert(Rune, (s2 and maskx))), 3)
    return
  var s3 = s[3]
  if ((s3 < locb) or (hicb < s3)):
    (result.r, result.size) = (runeError, 1)
    return
  (result.r, result.size) = (((((convert(Rune, (s0 and mask4)) shl 18) or (convert(Rune, (s1 and maskx)) shl 12)) or (convert(Rune, (s2 and maskx)) shl 6)) or convert(Rune, (s3 and maskx))), 4)
  return

proc decodeLastRune(p: GoSlice[byte]): tuple[r: Rune, size: int] =
  var `end` = len(p)
  if (`end` == 0):
    (result.r, result.size) = (runeError, 0)
    return
  var start = (`end` - 1)
  result.r = convert(Rune, p[start])
  if (result.r < runeSelf):
    (result.r, result.size) = (result.r, 1)
    return
  var lim = (`end` - UTFMax)
  if (lim < 0):
    lim = 0
  block loop0:
    start -= 1
    while (start >= lim):
      block loop0Continue:
        if runeStart(p[start]):
          break loop0
      start -= 1
  if (start < 0):
    start = 0
  (result.r, result.size) = decodeRune(slice(p, low=start, high=`end`))
  if ((start + result.size) != `end`):
    (result.r, result.size) = (runeError, 1)
    return
  (result.r, result.size) = (result.r, result.size)
  return

proc decodeLastRuneInString(s: string): tuple[r: Rune, size: int] =
  var `end` = len(s)
  if (`end` == 0):
    (result.r, result.size) = (runeError, 0)
    return
  var start = (`end` - 1)
  result.r = convert(Rune, s[start])
  if (result.r < runeSelf):
    (result.r, result.size) = (result.r, 1)
    return
  var lim = (`end` - UTFMax)
  if (lim < 0):
    lim = 0
  block loop0:
    start -= 1
    while (start >= lim):
      block loop0Continue:
        if runeStart(s[start]):
          break loop0
      start -= 1
  if (start < 0):
    start = 0
  (result.r, result.size) = decodeRuneInString(slice(s, low=start, high=`end`))
  if ((start + result.size) != `end`):
    (result.r, result.size) = (runeError, 1)
    return
  (result.r, result.size) = (result.r, result.size)
  return

proc runeLen(r: Rune): int =
  if true == (r < 0):
    return -1
  elif true == (r <= rune1Max):
    return 1
  elif true == (r <= rune2Max):
    return 2
  elif true == ((surrogateMin <= r) and (r <= surrogateMax)):
    return -1
  elif true == (r <= rune3Max):
    return 3
  elif true == (r <= maxRune):
    return 4
  
  return -1

proc encodeRune(p: GoSlice[byte], r: Rune): int =
  var r = r
  block:
    var i = convert(uint32, r)
    let condition = true
    if true == (i <= rune1Max):
      p[0] = convert(byte, r)
      return 1
    elif true == (i <= rune2Max):
      p[0] = (t2 or convert(byte, (r shr 6)))
      p[1] = (tx or (convert(byte, r) and maskx))
      return 2
    elif true == (i > maxRune) or true == ((surrogateMin <= i) and (i <= surrogateMax)):
      r = runeError
      p[0] = (t3 or convert(byte, (r shr 12)))
      p[1] = (tx or (convert(byte, (r shr 6)) and maskx))
      p[2] = (tx or (convert(byte, r) and maskx))
      return 3
    elif true == (i <= rune3Max):
      p[0] = (t3 or convert(byte, (r shr 12)))
      p[1] = (tx or (convert(byte, (r shr 6)) and maskx))
      p[2] = (tx or (convert(byte, r) and maskx))
      return 3
    else:
      p[0] = (t4 or convert(byte, (r shr 18)))
      p[1] = (tx or (convert(byte, (r shr 12)) and maskx))
      p[2] = (tx or (convert(byte, (r shr 6)) and maskx))
      p[3] = (tx or (convert(byte, r) and maskx))
      return 4

proc runeCount(p: GoSlice[byte]): int =
  var np = len(p)
  var n: int
  block loop0:
    var i = 0
    while (i < np):
      n += 1
      var c = p[i]
      if (c < runeSelf):
        i += 1
        continue
      var x = first[c]
      if (x == xx):
        i += 1
        continue
      var size = convert(int, (x and 7))
      if ((i + size) > np):
        i += 1
        continue
      var accept = acceptRanges[(x shr 4)]
      if (var c = p[(i + 1)]; ((c < accept.lo) or (accept.hi < c))):
        size = 1
      elif (size == 2):
        discard
      
      elif (var c = p[(i + 2)]; ((c < locb) or (hicb < c))):
        size = 1
      elif (size == 3):
        discard
      
      elif (var c = p[(i + 3)]; ((c < locb) or (hicb < c))):
        size = 1
      i += size
  return n

proc runeCountInString(s: string): int =
  var ns = len(s)
  block loop0:
    var i = 0
    while (i < ns):
      block loop0Continue:
        var c = s[i]
        if (c < runeSelf):
          i += 1
          break loop0Continue
        var x = first[c]
        if (x == xx):
          i += 1
          break loop0Continue
        var size = convert(int, (x and 7))
        if ((i + size) > ns):
          i += 1
          break loop0Continue
        var accept = acceptRanges[(x shr 4)]
        if (var c = s[(i + 1)]; ((c < accept.lo) or (accept.hi < c))):
          size = 1
        elif (size == 2):
          discard
        
        elif (var c = s[(i + 2)]; ((c < locb) or (hicb < c))):
          size = 1
        elif (size == 3):
          discard
        
        elif (var c = s[(i + 3)]; ((c < locb) or (hicb < c))):
          size = 1
        i += size
      result += 1
  return result

proc runeStart(b: byte): bool =
  return ((b and 0xC0) != 0x80)

proc valid(p: GoSlice[byte]): bool =
  var n = len(p)
  block loop0:
    var i = 0
    while (i < n):
      var pi = p[i]
      if (pi < runeSelf):
        i += 1
        continue
      var x = first[pi]
      if (x == xx):
        return false
      var size = convert(int, (x and 7))
      if ((i + size) > n):
        return false
      var accept = acceptRanges[(x shr 4)]
      if (var c = p[(i + 1)]; ((c < accept.lo) or (accept.hi < c))):
        return false
      elif (size == 2):
        discard
      
      elif (var c = p[(i + 2)]; ((c < locb) or (hicb < c))):
        return false
      elif (size == 3):
        discard
      
      elif (var c = p[(i + 3)]; ((c < locb) or (hicb < c))):
        return false
      i += size
  return true

proc validString(s: string): bool =
  var n = len(s)
  block loop0:
    var i = 0
    while (i < n):
      var si = s[i]
      if (si < runeSelf):
        i += 1
        continue
      var x = first[si]
      if (x == xx):
        return false
      var size = convert(int, (x and 7))
      if ((i + size) > n):
        return false
      var accept = acceptRanges[(x shr 4)]
      if (var c = s[(i + 1)]; ((c < accept.lo) or (accept.hi < c))):
        return false
      elif (size == 2):
        discard
      
      elif (var c = s[(i + 2)]; ((c < locb) or (hicb < c))):
        return false
      elif (size == 3):
        discard
      
      elif (var c = s[(i + 3)]; ((c < locb) or (hicb < c))):
        return false
      i += size
  return true

proc validRune(r: Rune): bool =
  if true == (r < 0):
    return false
  elif true == ((surrogateMin <= r) and (r <= surrogateMax)):
    return false
  elif true == (r > maxRune):
    return false
  
  return true


when isMainModule:
  main()
