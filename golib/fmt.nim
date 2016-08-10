include gosupport
import golib/strconv
import golib/unicode/utf8
import golib/errors
import golib/io
import golib/os
import golib/reflect
import golib/sync
import golib/unicode/utf8
import golib/errors
import golib/io
import golib/math
import golib/os
import golib/reflect
import golib/strconv
import golib/sync
import golib/unicode/utf8
const 
  ldigits = "0123456789abcdefx"
  udigits = "0123456789ABCDEFX"
const 
  signed = true
  unsigned = false
const 
  commaSpaceString = ", "
  nilAngleString = "<nil>"
  nilParenString = "(nil)"
  nilString = "nil"
  mapString = "map["
  percentBangString = "%!"
  missingString = "(MISSING)"
  badIndexString = "(BADINDEX)"
  panicString = "(PANIC="
  extraString = "%!(EXTRA "
  badWidthString = "%!(BADWIDTH)"
  badPrecString = "%!(BADPREC)"
  noVerbString = "%!(NOVERB)"
  invReflectString = "<invalid reflect.Value>"
const eof = -1
const 
  binaryDigits = "01"
  octalDigits = "01234567"
  decimalDigits = "0123456789"
  hexadecimalDigits = "0123456789aAbBcCdDeEfF"
  sign = "+-"
  period = "."
  exponent = "eEp"
const 
  floatVerbs = "beEfFgGv"
  hugeWid = (1 shl 30)
  intBits = (32 shl ((not convert(uint, 0) shr 63)))
  uintptrBits = (32 shl ((not convert(uintptr, 0) shr 63)))

exttypes:
  type
    FmtFlags* = struct((widPresent: bool, precPresent: bool, minus: bool, plus: bool, sharp: bool, space: bool, zero: bool, plusV: bool, sharpV: bool))
    Fmt* = struct((buf: gcptr[Buffer], inline fmtFlags: FmtFlags, wid: int, prec: int, intbuf: GoArray[byte, 68]))
    State* = iface((write(b: GoSlice[byte]): (int, Error), width(): (int, bool), precision(): (int, bool), flag(c: int): bool))
    Formatter* = iface((format(f: State, c: Rune): void))
    Stringer* = iface((toString(): string))
    GoStringer* = iface((goString(): string))
    Buffer* = GoSlice[byte]
    Pp* = struct((buf: Buffer, arg: EmptyInterface, value: reflect.Value, fmt: Fmt, reordered: bool, goodArgNum: bool, panicking: bool, erroring: bool))
    ScanState* = iface((readRune(): (Rune, int, Error), unreadRune(): Error, skipSpace(): void, token(skipSpaceInternal: bool, f: (proc(arg0: Rune): bool)): (GoSlice[byte], Error), width(): (int, bool), read(buf: GoSlice[byte]): (int, Error)))
    Scanner* = iface((scan(state: ScanState, verb: Rune): Error))
    StringReader* = string
    ScanError* = struct((err: Error))
    Ss* = struct((rs: io.RuneScanner, buf: Buffer, count: int, atEOF: bool, inline ssave: Ssave))
    Ssave* = struct((validSave: bool, nlIsEnd: bool, nlIsSpace: bool, argLimit: int, limit: int, maxWid: int))
    ReadRune* = struct((reader: io.Reader, buf: GoArray[byte, utf8.UTFMax], pending: int, pendBuf: GoArray[byte, utf8.UTFMax], peekRune: Rune))

proc clearflags(f: gcptr[Fmt]): void {.gofunc, gomethod.}
proc init(f: gcptr[Fmt], buf: gcptr[Buffer]): void {.gofunc, gomethod.}
proc writePadding(f: gcptr[Fmt], n: int): void {.gofunc, gomethod.}
proc pad(f: gcptr[Fmt], b: GoSlice[byte]): void {.gofunc, gomethod.}
proc padString(f: gcptr[Fmt], s: string): void {.gofunc, gomethod.}
proc fmt_boolean(f: gcptr[Fmt], v: bool): void {.gofunc, gomethod.}
proc fmt_unicode(f: gcptr[Fmt], u: uint64): void {.gofunc, gomethod.}
proc fmt_integer(f: gcptr[Fmt], u: uint64, base: int, isSigned: bool, digits: string): void {.gofunc, gomethod.}
proc truncate(f: gcptr[Fmt], s: string): string {.gofunc, gomethod.}
proc fmt_s(f: gcptr[Fmt], s: string): void {.gofunc, gomethod.}
proc fmt_sbx(f: gcptr[Fmt], s: string, b: GoSlice[byte], digits: string): void {.gofunc, gomethod.}
proc fmt_sx(f: gcptr[Fmt], s: string, digits: string): void {.gofunc, gomethod.}
proc fmt_bx(f: gcptr[Fmt], b: GoSlice[byte], digits: string): void {.gofunc, gomethod.}
proc fmt_q(f: gcptr[Fmt], s: string): void {.gofunc, gomethod.}
proc fmt_c(f: gcptr[Fmt], c: uint64): void {.gofunc, gomethod.}
proc fmt_qc(f: gcptr[Fmt], c: uint64): void {.gofunc, gomethod.}
proc fmt_float(f: gcptr[Fmt], v: float64, size: int, verb: Rune, prec: int): void {.gofunc, gomethod.}
proc write*(b: gcptr[Buffer], p: GoSlice[byte]): void {.gofunc, gomethod.}
proc writeString*(b: gcptr[Buffer], s: string): void {.gofunc, gomethod.}
proc writeByte*(b: gcptr[Buffer], c: byte): void {.gofunc, gomethod.}
proc writeRune*(bp: gcptr[Buffer], r: Rune): void {.gofunc, gomethod.}
proc newPrinter(): gcptr[Pp] {.gofunc.}
proc free(p: gcptr[Pp]): void {.gofunc, gomethod.}
proc width*(p: gcptr[Pp]): tuple[wid: int, ok: bool] {.gofunc, gomethod.}
proc precision*(p: gcptr[Pp]): tuple[prec: int, ok: bool] {.gofunc, gomethod.}
proc flag*(p: gcptr[Pp], b: int): bool {.gofunc, gomethod.}
proc write*(p: gcptr[Pp], b: GoSlice[byte]): tuple[ret: int, err: Error] {.gofunc, gomethod.}
proc fprintf*(w: io.Writer, format: string, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] {.gofunc.}
proc printf*(format: string, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] {.gofunc.}
proc sprintf*(format: string, a: GoVarArgs[EmptyInterface]): string {.gofunc.}
proc errorf*(format: string, a: GoVarArgs[EmptyInterface]): Error {.gofunc.}
proc fprint*(w: io.Writer, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] {.gofunc.}
proc print*(a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] {.gofunc.}
proc sprint*(a: GoVarArgs[EmptyInterface]): string {.gofunc.}
proc fprintln*(w: io.Writer, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] {.gofunc.}
proc println*(a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] {.gofunc.}
proc sprintln*(a: GoVarArgs[EmptyInterface]): string {.gofunc.}
proc getField(v: reflect.Value, i: int): reflect.Value {.gofunc.}
proc tooLarge(x: int): bool {.gofunc.}
proc parsenum(s: string, start: int, `end`: int): tuple[num: int, isnum: bool, newi: int] {.gofunc.}
proc unknownType(p: gcptr[Pp], v: reflect.Value): void {.gofunc, gomethod.}
proc badVerb(p: gcptr[Pp], verb: Rune): void {.gofunc, gomethod.}
proc fmtBool(p: gcptr[Pp], v: bool, verb: Rune): void {.gofunc, gomethod.}
proc fmt0x64(p: gcptr[Pp], v: uint64, leading0x: bool): void {.gofunc, gomethod.}
proc fmtInteger(p: gcptr[Pp], v: uint64, isSigned: bool, verb: Rune): void {.gofunc, gomethod.}
proc fmtFloat(p: gcptr[Pp], v: float64, size: int, verb: Rune): void {.gofunc, gomethod.}
proc fmtComplex(p: gcptr[Pp], v: complex128, size: int, verb: Rune): void {.gofunc, gomethod.}
proc fmtString(p: gcptr[Pp], v: string, verb: Rune): void {.gofunc, gomethod.}
proc fmtBytes(p: gcptr[Pp], v: GoSlice[byte], verb: Rune, typeString: string): void {.gofunc, gomethod.}
proc fmtPointer(p: gcptr[Pp], value: reflect.Value, verb: Rune): void {.gofunc, gomethod.}
proc catchPanic(p: gcptr[Pp], arg: EmptyInterface, verb: Rune): void {.gofunc, gomethod.}
proc handleMethods(p: gcptr[Pp], verb: Rune): bool {.gofunc, gomethod.}
proc printArg(p: gcptr[Pp], arg: EmptyInterface, verb: Rune): void {.gofunc, gomethod.}
proc printValue(p: gcptr[Pp], value: reflect.Value, verb: Rune, depth: int): void {.gofunc, gomethod.}
proc intFromArg(a: GoSlice[EmptyInterface], argNum: int): tuple[num: int, isInt: bool, newArgNum: int] {.gofunc.}
proc parseArgNumber(format: string): tuple[index: int, wid: int, ok: bool] {.gofunc.}
proc argNumber(p: gcptr[Pp], argNum: int, format: string, i: int, numArgs: int): tuple[newArgNum: int, newi: int, found: bool] {.gofunc, gomethod.}
proc badArgNum(p: gcptr[Pp], verb: Rune): void {.gofunc, gomethod.}
proc missingArg(p: gcptr[Pp], verb: Rune): void {.gofunc, gomethod.}
proc doPrintf(p: gcptr[Pp], format: string, a: GoSlice[EmptyInterface]): void {.gofunc, gomethod.}
proc doPrint(p: gcptr[Pp], a: GoSlice[EmptyInterface]): void {.gofunc, gomethod.}
proc doPrintln(p: gcptr[Pp], a: GoSlice[EmptyInterface]): void {.gofunc, gomethod.}
proc scan*(a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] {.gofunc.}
proc scanln*(a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] {.gofunc.}
proc scanf*(format: string, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] {.gofunc.}
proc read*(r: gcptr[StringReader], b: GoSlice[byte]): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc sscan*(str: string, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] {.gofunc.}
proc sscanln*(str: string, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] {.gofunc.}
proc sscanf*(str: string, format: string, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] {.gofunc.}
proc fscan*(r: io.Reader, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] {.gofunc.}
proc fscanln*(r: io.Reader, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] {.gofunc.}
proc fscanf*(r: io.Reader, format: string, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] {.gofunc.}
proc read*(s: gcptr[Ss], buf: GoSlice[byte]): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc readRune*(s: gcptr[Ss]): tuple[r: Rune, size: int, err: Error] {.gofunc, gomethod.}
proc width*(s: gcptr[Ss]): tuple[wid: int, ok: bool] {.gofunc, gomethod.}
proc getRune(s: gcptr[Ss]): Rune {.gofunc, gomethod.}
proc mustReadRune(s: gcptr[Ss]): Rune {.gofunc, gomethod.}
proc unreadRune*(s: gcptr[Ss]): Error {.gofunc, gomethod.}
proc error(s: gcptr[Ss], err: Error): void {.gofunc, gomethod.}
proc errorString(s: gcptr[Ss], err: string): void {.gofunc, gomethod.}
proc token*(s: gcptr[Ss], skipSpaceInternal: bool, f: (proc(arg0: Rune): bool)): tuple[tok: GoSlice[byte], err: Error] {.gofunc, gomethod.}
proc isSpace(r: Rune): bool {.gofunc.}
proc notSpace(r: Rune): bool {.gofunc.}
proc skipSpace*(s: gcptr[Ss]): void {.gofunc, gomethod.}
proc readByte(r: gcptr[ReadRune]): tuple[b: byte, err: Error] {.gofunc, gomethod.}
proc readRune*(r: gcptr[ReadRune]): tuple[rr: Rune, size: int, err: Error] {.gofunc, gomethod.}
proc unreadRune*(r: gcptr[ReadRune]): Error {.gofunc, gomethod.}
proc newScanState(r: io.Reader, nlIsSpace: bool, nlIsEnd: bool): tuple[s: gcptr[Ss], old: Ssave] {.gofunc.}
proc free(s: gcptr[Ss], old: Ssave): void {.gofunc, gomethod.}
proc skipSpaceInternal*(s: gcptr[Ss], stopAtNewline: bool): void {.gofunc, gomethod.}
proc tokenInternal*(s: gcptr[Ss], skipSpaceInternal: bool, f: (proc(arg0: Rune): bool)): GoSlice[byte] {.gofunc, gomethod.}
proc indexRune(s: string, r: Rune): int {.gofunc.}
proc consume(s: gcptr[Ss], ok: string, accept: bool): bool {.gofunc, gomethod.}
proc peek(s: gcptr[Ss], ok: string): bool {.gofunc, gomethod.}
proc notEOF(s: gcptr[Ss]): void {.gofunc, gomethod.}
proc accept(s: gcptr[Ss], ok: string): bool {.gofunc, gomethod.}
proc okVerb(s: gcptr[Ss], verb: Rune, okVerbs: string, typ: string): bool {.gofunc, gomethod.}
proc scanBool(s: gcptr[Ss], verb: Rune): bool {.gofunc, gomethod.}
proc getBase(s: gcptr[Ss], verb: Rune): tuple[base: int, digits: string] {.gofunc, gomethod.}
proc scanNumber(s: gcptr[Ss], digits: string, haveDigits: bool): string {.gofunc, gomethod.}
proc scanRune(s: gcptr[Ss], bitSize: int): int64 {.gofunc, gomethod.}
proc scanBasePrefix(s: gcptr[Ss]): tuple[base: int, digits: string, found: bool] {.gofunc, gomethod.}
proc scanInt(s: gcptr[Ss], verb: Rune, bitSize: int): int64 {.gofunc, gomethod.}
proc scanUint(s: gcptr[Ss], verb: Rune, bitSize: int): uint64 {.gofunc, gomethod.}
proc floatToken(s: gcptr[Ss]): string {.gofunc, gomethod.}
proc complexTokens(s: gcptr[Ss]): tuple[real: string, imag: string] {.gofunc, gomethod.}
proc convertFloat(s: gcptr[Ss], str: string, n: int): float64 {.gofunc, gomethod.}
proc scanComplex(s: gcptr[Ss], verb: Rune, n: int): complex128 {.gofunc, gomethod.}
proc convertString(s: gcptr[Ss], verb: Rune): string {.gofunc, gomethod.}
proc quotedString(s: gcptr[Ss]): string {.gofunc, gomethod.}
proc hexDigit(d: Rune): tuple[arg0: int, arg1: bool] {.gofunc.}
proc hexByte(s: gcptr[Ss]): tuple[b: byte, ok: bool] {.gofunc, gomethod.}
proc hexString(s: gcptr[Ss]): string {.gofunc, gomethod.}
proc scanOne(s: gcptr[Ss], verb: Rune, arg: EmptyInterface): void {.gofunc, gomethod.}
proc errorHandler(errp: gcptr[Error]): void {.gofunc.}
proc doScan(s: gcptr[Ss], a: GoSlice[EmptyInterface]): tuple[numProcessed: int, err: Error] {.gofunc, gomethod.}
proc advance(s: gcptr[Ss], format: string): int {.gofunc, gomethod.}
proc doScanf(s: gcptr[Ss], format: string, a: GoSlice[EmptyInterface]): tuple[numProcessed: int, err: Error] {.gofunc, gomethod.}
var ppFree = sync.Pool(new: (proc(): EmptyInterface =
  return gcnew(Pp)))
var byteType = reflect.typeOf(convert(byte, 0))
var spaceF = [GoArray[uint16, 2]([uint16(0x0009), uint16(0x000d)].make(GoArray[uint16, 2])), GoArray[uint16, 2]([uint16(0x0020), uint16(0x0020)].make(GoArray[uint16, 2])), GoArray[uint16, 2]([uint16(0x0085), uint16(0x0085)].make(GoArray[uint16, 2])), GoArray[uint16, 2]([uint16(0x00a0), uint16(0x00a0)].make(GoArray[uint16, 2])), GoArray[uint16, 2]([uint16(0x1680), uint16(0x1680)].make(GoArray[uint16, 2])), GoArray[uint16, 2]([uint16(0x2000), uint16(0x200a)].make(GoArray[uint16, 2])), GoArray[uint16, 2]([uint16(0x2028), uint16(0x2029)].make(GoArray[uint16, 2])), GoArray[uint16, 2]([uint16(0x202f), uint16(0x202f)].make(GoArray[uint16, 2])), GoArray[uint16, 2]([uint16(0x205f), uint16(0x205f)].make(GoArray[uint16, 2])), GoArray[uint16, 2]([uint16(0x3000), uint16(0x3000)].make(GoArray[uint16, 2]))].make(GoSlice[GoArray[uint16, 2]])
var ssFree = sync.Pool(new: (proc(): EmptyInterface =
  return gcnew(Ss)))
var complexError = errors.new("syntax error scanning complex number")
var boolError = errors.new("syntax error scanning boolean")




proc clearflags(f: gcptr[Fmt]): void =
  f.fmtFlags = make((), FmtFlags)

proc init(f: gcptr[Fmt], buf: gcptr[Buffer]): void =
  f.buf = buf
  f.clearflags()

proc writePadding(f: gcptr[Fmt], n: int): void =
  if (n <= 0):
    return
  var buf = f.buf[]
  var oldLen = len(buf)
  var newLen = (oldLen + n)
  if (newLen > cap(buf)):
    buf = make(Buffer, ((cap(buf) * 2) + n))
    copy(buf, f.buf[])
  var padByte = convert(byte, runelit(' '))
  if f.zero:
    padByte = convert(byte, runelit('0'))
  var padding = slice(buf, low=oldLen, high=newLen)
  for i in 0..<len(padding):
    padding[i] = padByte
  f.buf[] = slice(buf, high=newLen)

proc pad(f: gcptr[Fmt], b: GoSlice[byte]): void =
  if (not f.widPresent or (f.wid == 0)):
    f.buf.write(b)
    return
  var widthInternal = (f.wid - utf8.runeCount(b))
  if not f.minus:
    f.writePadding(widthInternal)
    f.buf.write(b)
  else:
    f.buf.write(b)
    f.writePadding(widthInternal)

proc padString(f: gcptr[Fmt], s: string): void =
  if (not f.widPresent or (f.wid == 0)):
    f.buf.writeString(s)
    return
  var widthInternal = (f.wid - utf8.runeCountInString(s))
  if not f.minus:
    f.writePadding(widthInternal)
    f.buf.writeString(s)
  else:
    f.buf.writeString(s)
    f.writePadding(widthInternal)

proc fmt_boolean(f: gcptr[Fmt], v: bool): void =
  if v:
    f.padString("true")
  else:
    f.padString("false")

proc fmt_unicode(f: gcptr[Fmt], u: uint64): void =
  var u = u
  var buf = slice(f.intbuf, low=0)
  var prec = 4
  if (f.precPresent and (f.prec > 4)):
    prec = f.prec
    var widthInternal = ((((2 + prec) + 2) + utf8.UTFMax) + 1)
    if (widthInternal > len(buf)):
      buf = make(GoSlice[byte], widthInternal)
  var i = len(buf)
  if ((f.sharp and (u <= utf8.maxRune)) and strconv.isPrint(convert(Rune, u))):
    i -= 1
    buf[i] = runelit('\'')
    i -= utf8.runeLen(convert(Rune, u))
    utf8.encodeRune(slice(buf, low=i), convert(Rune, u))
    i -= 1
    buf[i] = runelit('\'')
    i -= 1
    buf[i] = runelit(' ')
  while (u >= 16):
    i -= 1
    buf[i] = udigits[(u and 0xF)]
    prec -= 1
    u = u shr (4)
  i -= 1
  buf[i] = udigits[u]
  prec -= 1
  while (prec > 0):
    i -= 1
    buf[i] = runelit('0')
    prec -= 1
  i -= 1
  buf[i] = runelit('+')
  i -= 1
  buf[i] = runelit('U')
  var oldZero = f.zero
  f.zero = false
  f.pad(slice(buf, low=i))
  f.zero = oldZero

proc fmt_integer(f: gcptr[Fmt], u: uint64, base: int, isSigned: bool, digits: string): void =
  var u = u
  var negative = (isSigned and (convert(int64, u) < 0))
  if negative:
    u = -u
  var buf = slice(f.intbuf, low=0)
  if (f.widPresent or f.precPresent):
    var widthInternal = ((3 + f.wid) + f.prec)
    if (widthInternal > len(buf)):
      buf = make(GoSlice[byte], widthInternal)
  var prec = 0
  if f.precPresent:
    prec = f.prec
    if ((prec == 0) and (u == 0)):
      var oldZero = f.zero
      f.zero = false
      f.writePadding(f.wid)
      f.zero = oldZero
      return
  elif (f.zero and f.widPresent):
    prec = f.wid
    if ((negative or f.plus) or f.space):
      prec -= 1
  var i = len(buf)
  block:
    let condition = base
    if condition == 10:
      while (u >= 10):
        i -= 1
        var next = `go/`(u, 10)
        buf[i] = convert(byte, ((runelit('0') + u) - (next * 10)))
        u = next
    elif condition == 16:
      while (u >= 16):
        i -= 1
        buf[i] = digits[(u and 0xF)]
        u = u shr (4)
    elif condition == 8:
      while (u >= 8):
        i -= 1
        buf[i] = convert(byte, (runelit('0') + (u and 7)))
        u = u shr (3)
    elif condition == 2:
      while (u >= 2):
        i -= 1
        buf[i] = convert(byte, (runelit('0') + (u and 1)))
        u = u shr (1)
    else:
      panic("fmt: unknown base; can't happen")
  i -= 1
  buf[i] = digits[u]
  while ((i > 0) and (prec > (len(buf) - i))):
    i -= 1
    buf[i] = runelit('0')
  if f.sharp:
    block:
      let condition = base
      if condition == 8:
        if (buf[i] != runelit('0')):
          i -= 1
          buf[i] = runelit('0')
      elif condition == 16:
        i -= 1
        buf[i] = digits[16]
        i -= 1
        buf[i] = runelit('0')
  
  if negative:
    i -= 1
    buf[i] = runelit('-')
  elif f.plus:
    i -= 1
    buf[i] = runelit('+')
  elif f.space:
    i -= 1
    buf[i] = runelit(' ')
  var oldZero = f.zero
  f.zero = false
  f.pad(slice(buf, low=i))
  f.zero = oldZero

proc truncate(f: gcptr[Fmt], s: string): string =
  if f.precPresent:
    var n = f.prec
    for i in 0..<len(s):
      n -= 1
      if (n < 0):
        return slice(s, high=i)
  return s

proc fmt_s(f: gcptr[Fmt], s: string): void =
  var s = s
  s = f.truncate(s)
  f.padString(s)

proc fmt_sbx(f: gcptr[Fmt], s: string, b: GoSlice[byte], digits: string): void =
  var length = len(b)
  if (b == null):
    length = len(s)
  if (f.precPresent and (f.prec < length)):
    length = f.prec
  var widthInternal = (2 * length)
  if (widthInternal > 0):
    if f.space:
      if f.sharp:
        widthInternal *= 2
      widthInternal += (length - 1)
    elif f.sharp:
      widthInternal += 2
  else:
    if f.widPresent:
      f.writePadding(f.wid)
    return
  if ((f.widPresent and (f.wid > widthInternal)) and not f.minus):
    f.writePadding((f.wid - widthInternal))
  var buf = f.buf[]
  if f.sharp:
    buf = append(buf, runelit('0'), digits[16])
  var c: byte
  block loop0:
    var i = 0
    while (i < length):
      block loop0Continue:
        if (f.space and (i > 0)):
          buf = append(buf, runelit(' '))
          if f.sharp:
            buf = append(buf, runelit('0'), digits[16])
        if (b != null):
          c = b[i]
        else:
          c = s[i]
        buf = append(buf, digits[(c shr 4)], digits[(c and 0xF)])
      i += 1
  f.buf[] = buf
  if ((f.widPresent and (f.wid > widthInternal)) and f.minus):
    f.writePadding((f.wid - widthInternal))

proc fmt_sx(f: gcptr[Fmt], s: string, digits: string): void =
  f.fmt_sbx(s, null, digits)

proc fmt_bx(f: gcptr[Fmt], b: GoSlice[byte], digits: string): void =
  f.fmt_sbx("", b, digits)

proc fmt_q(f: gcptr[Fmt], s: string): void =
  var s = s
  s = f.truncate(s)
  if (f.sharp and strconv.canBackquote(s)):
    f.padString((("`" + s) + "`"))
    return
  var buf = slice(f.intbuf, high=0)
  if f.plus:
    f.pad(strconv.appendQuoteToASCII(buf, s))
  else:
    f.pad(strconv.appendQuote(buf, s))

proc fmt_c(f: gcptr[Fmt], c: uint64): void =
  var r = convert(Rune, c)
  if (c > utf8.maxRune):
    r = utf8.runeError
  var buf = slice(f.intbuf, high=0)
  var w = utf8.encodeRune(slice(buf, high=utf8.UTFMax), r)
  f.pad(slice(buf, high=w))

proc fmt_qc(f: gcptr[Fmt], c: uint64): void =
  var r = convert(Rune, c)
  if (c > utf8.maxRune):
    r = utf8.runeError
  var buf = slice(f.intbuf, high=0)
  if f.plus:
    f.pad(strconv.appendQuoteRuneToASCII(buf, r))
  else:
    f.pad(strconv.appendQuoteRune(buf, r))

proc fmt_float(f: gcptr[Fmt], v: float64, size: int, verb: Rune, prec: int): void =
  var prec = prec
  if f.precPresent:
    prec = f.prec
  var num = strconv.appendFloat(slice(f.intbuf, high=1), v, convert(byte, verb), prec, size)
  if ((num[1] == runelit('-')) or (num[1] == runelit('+'))):
    num = slice(num, low=1)
  else:
    num[0] = runelit('+')
  if ((f.space and (num[0] == runelit('+'))) and not f.plus):
    num[0] = runelit(' ')
  if ((num[1] == runelit('I')) or (num[1] == runelit('N'))):
    var oldZero = f.zero
    f.zero = false
    if (((num[1] == runelit('N')) and not f.space) and not f.plus):
      num = slice(num, low=1)
    f.pad(num)
    f.zero = oldZero
    return
  if (f.plus or (num[0] != runelit('+'))):
    if ((f.zero and f.widPresent) and (f.wid > len(num))):
      f.buf.writeByte(num[0])
      f.writePadding((f.wid - len(num)))
      f.buf.write(slice(num, low=1))
      return
    f.pad(num)
    return
  f.pad(slice(num, low=1))



proc write(b: gcptr[Buffer], p: GoSlice[byte]): void =
  b[] = append(b[], govarargs(p))

proc writeString(b: gcptr[Buffer], s: string): void =
  b[] = append(b[], govarargs(s))

proc writeByte(b: gcptr[Buffer], c: byte): void =
  b[] = append(b[], c)

proc writeRune(bp: gcptr[Buffer], r: Rune): void =
  if (r < utf8.runeSelf):
    bp[] = append(bp[], convert(byte, r))
    return
  var b = bp[]
  var n = len(b)
  while ((n + utf8.UTFMax) > cap(b)):
    b = append(b, 0)
  var w = utf8.encodeRune(slice(b, low=n, high=(n + utf8.UTFMax)), r)
  bp[] = slice(b, high=(n + w))

proc newPrinter(): gcptr[Pp] =
  var p = castInterface(ppFree.get(), to=gcptr[Pp])
  p.panicking = false
  p.erroring = false
  p.fmt.init(gcaddr p.buf)
  return p

proc free(p: gcptr[Pp]): void =
  p.buf = slice(p.buf, high=0)
  p.arg = null
  p.value = make((), reflect.Value)
  ppFree.put(p)

proc width(p: gcptr[Pp]): tuple[wid: int, ok: bool] =
  (result.wid, result.ok) = (p.fmt.wid, p.fmt.widPresent)
  return

proc precision(p: gcptr[Pp]): tuple[prec: int, ok: bool] =
  (result.prec, result.ok) = (p.fmt.prec, p.fmt.precPresent)
  return

proc flag(p: gcptr[Pp], b: int): bool =
  block:
    let condition = b
    if condition == runelit('-'):
      return p.fmt.minus
    elif condition == runelit('+'):
      return (p.fmt.plus or p.fmt.plusV)
    elif condition == runelit('#'):
      return (p.fmt.sharp or p.fmt.sharpV)
    elif condition == runelit(' '):
      return p.fmt.space
    elif condition == runelit('0'):
      return p.fmt.zero
  
  return false

proc write(p: gcptr[Pp], b: GoSlice[byte]): tuple[ret: int, err: Error] =
  p.buf.write(b)
  (result.ret, result.err) = (len(b), null)
  return

proc fprintf(w: io.Writer, format: string, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] =
  var p = newPrinter()
  p.doPrintf(format, a)
  (result.n, result.err) = w.write(p.buf)
  p.free()
  return

proc printf(format: string, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] =
  (result.n, result.err) = fprintf(os.stdout, format, govarargs(a))
  return

proc sprintf(format: string, a: GoVarArgs[EmptyInterface]): string =
  var p = newPrinter()
  p.doPrintf(format, a)
  var s = convert(string, p.buf)
  p.free()
  return s

proc errorf(format: string, a: GoVarArgs[EmptyInterface]): Error =
  return errors.new(sprintf(format, govarargs(a)))

proc fprint(w: io.Writer, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] =
  var p = newPrinter()
  p.doPrint(a)
  (result.n, result.err) = w.write(p.buf)
  p.free()
  return

proc print(a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] =
  (result.n, result.err) = fprint(os.stdout, govarargs(a))
  return

proc sprint(a: GoVarArgs[EmptyInterface]): string =
  var p = newPrinter()
  p.doPrint(a)
  var s = convert(string, p.buf)
  p.free()
  return s

proc fprintln(w: io.Writer, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] =
  var p = newPrinter()
  p.doPrintln(a)
  (result.n, result.err) = w.write(p.buf)
  p.free()
  return

proc println(a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] =
  (result.n, result.err) = fprintln(os.stdout, govarargs(a))
  return

proc sprintln(a: GoVarArgs[EmptyInterface]): string =
  var p = newPrinter()
  p.doPrintln(a)
  var s = convert(string, p.buf)
  p.free()
  return s

proc getField(v: reflect.Value, i: int): reflect.Value =
  var val = v.field(i)
  if ((val.kind() == reflect.Kind.`interface`) and not val.isNil()):
    val = val.elem()
  return val

proc tooLarge(x: int): bool =
  const max: int = 1000000
  return ((x > max) or (x < -max))

proc parsenum(s: string, start: int, `end`: int): tuple[num: int, isnum: bool, newi: int] =
  if (start >= `end`):
    (result.num, result.isnum, result.newi) = (0, false, `end`)
    return
  block loop0:
    result.newi = start
    while (((result.newi < `end`) and (runelit('0') <= s[result.newi])) and (s[result.newi] <= runelit('9'))):
      block loop0Continue:
        if tooLarge(result.num):
          (result.num, result.isnum, result.newi) = (0, false, `end`)
          return
        result.num = ((result.num * 10) + convert(int, (s[result.newi] - runelit('0'))))
        result.isnum = true
      result.newi += 1
  return

proc unknownType(p: gcptr[Pp], v: reflect.Value): void =
  if not v.isValid():
    p.buf.writeString(nilAngleString)
    return
  p.buf.writeByte(runelit('?'))
  p.buf.writeString(v.getType().toString())
  p.buf.writeByte(runelit('?'))

proc badVerb(p: gcptr[Pp], verb: Rune): void =
  p.erroring = true
  p.buf.writeString(percentBangString)
  p.buf.writeRune(verb)
  p.buf.writeByte(runelit('('))
  if true == (p.arg != null):
    p.buf.writeString(reflect.typeOf(p.arg).toString())
    p.buf.writeByte(runelit('='))
    p.printArg(p.arg, runelit('v'))
  elif true == p.value.isValid():
    p.buf.writeString(p.value.getType().toString())
    p.buf.writeByte(runelit('='))
    p.printValue(p.value, runelit('v'), 0)
  else:
    p.buf.writeString(nilAngleString)
  p.buf.writeByte(runelit(')'))
  p.erroring = false

proc fmtBool(p: gcptr[Pp], v: bool, verb: Rune): void =
  block:
    let condition = verb
    if condition == runelit('t') or condition == runelit('v'):
      p.fmt.fmt_boolean(v)
    else:
      p.badVerb(verb)

proc fmt0x64(p: gcptr[Pp], v: uint64, leading0x: bool): void =
  var sharp = p.fmt.sharp
  p.fmt.sharp = leading0x
  p.fmt.fmt_integer(v, 16, unsigned, ldigits)
  p.fmt.sharp = sharp

proc fmtInteger(p: gcptr[Pp], v: uint64, isSigned: bool, verb: Rune): void =
  block:
    let condition = verb
    if condition == runelit('v'):
      if (p.fmt.sharpV and not isSigned):
        p.fmt0x64(v, true)
      else:
        p.fmt.fmt_integer(v, 10, isSigned, ldigits)
    elif condition == runelit('d'):
      p.fmt.fmt_integer(v, 10, isSigned, ldigits)
    elif condition == runelit('b'):
      p.fmt.fmt_integer(v, 2, isSigned, ldigits)
    elif condition == runelit('o'):
      p.fmt.fmt_integer(v, 8, isSigned, ldigits)
    elif condition == runelit('x'):
      p.fmt.fmt_integer(v, 16, isSigned, ldigits)
    elif condition == runelit('X'):
      p.fmt.fmt_integer(v, 16, isSigned, udigits)
    elif condition == runelit('c'):
      p.fmt.fmt_c(v)
    elif condition == runelit('q'):
      if (v <= utf8.maxRune):
        p.fmt.fmt_qc(v)
      else:
        p.badVerb(verb)
    elif condition == runelit('U'):
      p.fmt.fmt_unicode(v)
    else:
      p.badVerb(verb)

proc fmtFloat(p: gcptr[Pp], v: float64, size: int, verb: Rune): void =
  block:
    let condition = verb
    if condition == runelit('v'):
      p.fmt.fmt_float(v, size, runelit('g'), -1)
    elif condition == runelit('b') or condition == runelit('g') or condition == runelit('G'):
      p.fmt.fmt_float(v, size, verb, -1)
    elif condition == runelit('f') or condition == runelit('e') or condition == runelit('E'):
      p.fmt.fmt_float(v, size, verb, 6)
    elif condition == runelit('F'):
      p.fmt.fmt_float(v, size, runelit('f'), 6)
    else:
      p.badVerb(verb)

proc fmtComplex(p: gcptr[Pp], v: complex128, size: int, verb: Rune): void =
  block:
    let condition = verb
    if condition == runelit('v') or condition == runelit('b') or condition == runelit('g') or condition == runelit('G') or condition == runelit('f') or condition == runelit('F') or condition == runelit('e') or condition == runelit('E'):
      var oldPlus = p.fmt.plus
      p.buf.writeByte(runelit('('))
      p.fmtFloat(real(v), `go/`(size, 2), verb)
      p.fmt.plus = true
      p.fmtFloat(imag(v), `go/`(size, 2), verb)
      p.buf.writeString("i)")
      p.fmt.plus = oldPlus
    else:
      p.badVerb(verb)

proc fmtString(p: gcptr[Pp], v: string, verb: Rune): void =
  block:
    let condition = verb
    if condition == runelit('v'):
      if p.fmt.sharpV:
        p.fmt.fmt_q(v)
      else:
        p.fmt.fmt_s(v)
    elif condition == runelit('s'):
      p.fmt.fmt_s(v)
    elif condition == runelit('x'):
      p.fmt.fmt_sx(v, ldigits)
    elif condition == runelit('X'):
      p.fmt.fmt_sx(v, udigits)
    elif condition == runelit('q'):
      p.fmt.fmt_q(v)
    else:
      p.badVerb(verb)

proc fmtBytes(p: gcptr[Pp], v: GoSlice[byte], verb: Rune, typeString: string): void =
  block:
    let condition = verb
    if condition == runelit('v') or condition == runelit('d'):
      if p.fmt.sharpV:
        p.buf.writeString(typeString)
        if (v == null):
          p.buf.writeString(nilParenString)
          return
        p.buf.writeByte(runelit('{'))
        for i, c in v:
          if (i > 0):
            p.buf.writeString(commaSpaceString)
          p.fmt0x64(convert(uint64, c), true)
        p.buf.writeByte(runelit('}'))
      else:
        p.buf.writeByte(runelit('['))
        for i, c in v:
          if (i > 0):
            p.buf.writeByte(runelit(' '))
          p.fmt.fmt_integer(convert(uint64, c), 10, unsigned, ldigits)
        p.buf.writeByte(runelit(']'))
    elif condition == runelit('s'):
      p.fmt.fmt_s(convert(string, v))
    elif condition == runelit('x'):
      p.fmt.fmt_bx(v, ldigits)
    elif condition == runelit('X'):
      p.fmt.fmt_bx(v, udigits)
    elif condition == runelit('q'):
      p.fmt.fmt_q(convert(string, v))
    else:
      p.printValue(reflect.valueOf(v), verb, 0)

proc fmtPointer(p: gcptr[Pp], value: reflect.Value, verb: Rune): void =
  var u: uintptr
  block:
    let condition = value.kind()
    if condition == reflect.Kind.chan or condition == reflect.Kind.`func` or condition == reflect.Kind.map or condition == reflect.Kind.`ptr` or condition == reflect.Kind.slice or condition == reflect.Kind.unsafePointer:
      u = value.toPointer()
    else:
      p.badVerb(verb)
      return
  block:
    let condition = verb
    if condition == runelit('v'):
      if p.fmt.sharpV:
        p.buf.writeByte(runelit('('))
        p.buf.writeString(value.getType().toString())
        p.buf.writeString(")(")
        if (u == 0):
          p.buf.writeString(nilString)
        else:
          p.fmt0x64(convert(uint64, u), true)
        p.buf.writeByte(runelit(')'))
      else:
        if (u == 0):
          p.fmt.padString(nilAngleString)
        else:
          p.fmt0x64(convert(uint64, u), not p.fmt.sharp)
    elif condition == runelit('p'):
      p.fmt0x64(convert(uint64, u), not p.fmt.sharp)
    elif condition == runelit('b') or condition == runelit('o') or condition == runelit('d') or condition == runelit('x') or condition == runelit('X'):
      p.fmtInteger(convert(uint64, u), unsigned, verb)
    else:
      p.badVerb(verb)

proc catchPanic(p: gcptr[Pp], arg: EmptyInterface, verb: Rune): void =
  if (var err = recover(); (err != null)):
    if (var v = reflect.valueOf(arg); ((v.kind() == reflect.Kind.`ptr`) and v.isNil())):
      p.buf.writeString(nilAngleString)
      return
    if p.panicking:
      panic(err)
    p.fmt.clearflags()
    p.buf.writeString(percentBangString)
    p.buf.writeRune(verb)
    p.buf.writeString(panicString)
    p.panicking = true
    p.printArg(err, runelit('v'))
    p.panicking = false
    p.buf.writeByte(runelit(')'))

proc handleMethods(p: gcptr[Pp], verb: Rune): bool =
  if p.erroring:
    return
  if (var (formatter, ok) = maybeCastInterface(p.arg, to=Formatter); ok):
    result = true
    godefer(p.catchPanic(p.arg, verb))
    formatter.format(p, verb)
    return
  if p.fmt.sharpV:
    if (var (stringer, ok) = maybeCastInterface(p.arg, to=GoStringer); ok):
      result = true
      godefer(p.catchPanic(p.arg, verb))
      p.fmt.fmt_s(stringer.goString())
      return
  else:
    block:
      let condition = verb
      if condition == runelit('v') or condition == runelit('s') or condition == runelit('x') or condition == runelit('X') or condition == runelit('q'):
        block:
          let typeSwitchOn = p.arg
          let condition = typeId(typeSwitchOn)
          if condition == typeId(Error):
            let v = castInterface(typeSwitchOn, to=Error)
            result = true
            godefer(p.catchPanic(p.arg, verb))
            p.fmtString(v.error(), verb)
            return
          elif condition == typeId(Stringer):
            let v = castInterface(typeSwitchOn, to=Stringer)
            result = true
            godefer(p.catchPanic(p.arg, verb))
            p.fmtString(v.toString(), verb)
            return
      
  
  return false

proc printArg(p: gcptr[Pp], arg: EmptyInterface, verb: Rune): void =
  p.arg = arg
  p.value = make((), reflect.Value)
  if (arg == null):
    block:
      let condition = verb
      if condition == runelit('T') or condition == runelit('v'):
        p.fmt.padString(nilAngleString)
      else:
        p.badVerb(verb)
    return
  block:
    let condition = verb
    if condition == runelit('T'):
      p.fmt.fmt_s(reflect.typeOf(arg).toString())
      return
    elif condition == runelit('p'):
      p.fmtPointer(reflect.valueOf(arg), runelit('p'))
      return
  
  block:
    let typeSwitchOn = arg
    let condition = typeId(typeSwitchOn)
    if condition == typeId(bool):
      let f = castInterface(typeSwitchOn, to=bool)
      p.fmtBool(f, verb)
    elif condition == typeId(float32):
      let f = castInterface(typeSwitchOn, to=float32)
      p.fmtFloat(float64(f), 32, verb)
    elif condition == typeId(float64):
      let f = castInterface(typeSwitchOn, to=float64)
      p.fmtFloat(f, 64, verb)
    elif condition == typeId(complex64):
      let f = castInterface(typeSwitchOn, to=complex64)
      p.fmtComplex(convert(complex128, f), 64, verb)
    elif condition == typeId(complex128):
      let f = castInterface(typeSwitchOn, to=complex128)
      p.fmtComplex(f, 128, verb)
    elif condition == typeId(int):
      let f = castInterface(typeSwitchOn, to=int)
      p.fmtInteger(convert(uint64, f), signed, verb)
    elif condition == typeId(int8):
      let f = castInterface(typeSwitchOn, to=int8)
      p.fmtInteger(convert(uint64, f), signed, verb)
    elif condition == typeId(int16):
      let f = castInterface(typeSwitchOn, to=int16)
      p.fmtInteger(convert(uint64, f), signed, verb)
    elif condition == typeId(int32):
      let f = castInterface(typeSwitchOn, to=int32)
      p.fmtInteger(convert(uint64, f), signed, verb)
    elif condition == typeId(int64):
      let f = castInterface(typeSwitchOn, to=int64)
      p.fmtInteger(convert(uint64, f), signed, verb)
    elif condition == typeId(uint):
      let f = castInterface(typeSwitchOn, to=uint)
      p.fmtInteger(convert(uint64, f), unsigned, verb)
    elif condition == typeId(uint8):
      let f = castInterface(typeSwitchOn, to=uint8)
      p.fmtInteger(convert(uint64, f), unsigned, verb)
    elif condition == typeId(uint16):
      let f = castInterface(typeSwitchOn, to=uint16)
      p.fmtInteger(convert(uint64, f), unsigned, verb)
    elif condition == typeId(uint32):
      let f = castInterface(typeSwitchOn, to=uint32)
      p.fmtInteger(convert(uint64, f), unsigned, verb)
    elif condition == typeId(uint64):
      let f = castInterface(typeSwitchOn, to=uint64)
      p.fmtInteger(f, unsigned, verb)
    elif condition == typeId(uintptr):
      let f = castInterface(typeSwitchOn, to=uintptr)
      p.fmtInteger(convert(uint64, f), unsigned, verb)
    elif condition == typeId(string):
      let f = castInterface(typeSwitchOn, to=string)
      p.fmtString(f, verb)
    elif condition == typeId(GoSlice[byte]):
      let f = castInterface(typeSwitchOn, to=GoSlice[byte])
      p.fmtBytes(f, verb, "[]byte")
    elif condition == typeId(reflect.Value):
      let f = castInterface(typeSwitchOn, to=reflect.Value)
      p.printValue(f, verb, 0)
    else:
      let f = typeSwitchOn
      if not p.handleMethods(verb):
        p.printValue(reflect.valueOf(f), verb, 0)

proc printValue(p: gcptr[Pp], value: reflect.Value, verb: Rune, depth: int): void =
  var value = value
  if (((depth > 0) and value.isValid()) and value.canInterface()):
    p.arg = value.`interface`()
    if p.handleMethods(verb):
      return
  p.arg = null
  p.value = value
  block:
    var f = value
    let condition = value.kind()
    if condition == reflect.Kind.invalid:
      if (depth == 0):
        p.buf.writeString(invReflectString)
      else:
        block:
          let condition = verb
          if condition == runelit('v'):
            p.buf.writeString(nilAngleString)
          else:
            p.badVerb(verb)
    elif condition == reflect.Kind.bool:
      p.fmtBool(f.toBool(), verb)
    elif condition == reflect.Kind.int or condition == reflect.Kind.int8 or condition == reflect.Kind.int16 or condition == reflect.Kind.int32 or condition == reflect.Kind.int64:
      p.fmtInteger(convert(uint64, f.toInt()), signed, verb)
    elif condition == reflect.Kind.uint or condition == reflect.Kind.uint8 or condition == reflect.Kind.uint16 or condition == reflect.Kind.uint32 or condition == reflect.Kind.uint64 or condition == reflect.Kind.uintptr:
      p.fmtInteger(f.toUint(), unsigned, verb)
    elif condition == reflect.Kind.float32:
      p.fmtFloat(f.toFloat(), 32, verb)
    elif condition == reflect.Kind.float64:
      p.fmtFloat(f.toFloat(), 64, verb)
    elif condition == reflect.Kind.complex64:
      p.fmtComplex(f.complex(), 64, verb)
    elif condition == reflect.Kind.complex128:
      p.fmtComplex(f.complex(), 128, verb)
    elif condition == reflect.Kind.string:
      p.fmtString(f.toString(), verb)
    elif condition == reflect.Kind.map:
      if p.fmt.sharpV:
        p.buf.writeString(f.getType().toString())
        if f.isNil():
          p.buf.writeString(nilParenString)
          return
        p.buf.writeByte(runelit('{'))
      else:
        p.buf.writeString(mapString)
      var keys = f.mapKeys()
      for i, key in keys:
        if (i > 0):
          if p.fmt.sharpV:
            p.buf.writeString(commaSpaceString)
          else:
            p.buf.writeByte(runelit(' '))
        p.printValue(key, verb, (depth + 1))
        p.buf.writeByte(runelit(':'))
        p.printValue(f.mapIndex(key), verb, (depth + 1))
      if p.fmt.sharpV:
        p.buf.writeByte(runelit('}'))
      else:
        p.buf.writeByte(runelit(']'))
    elif condition == reflect.Kind.struct:
      if p.fmt.sharpV:
        p.buf.writeString(f.getType().toString())
      p.buf.writeByte(runelit('{'))
      block loop0:
        var i = 0
        while (i < f.numField()):
          block loop0Continue:
            if (i > 0):
              if p.fmt.sharpV:
                p.buf.writeString(commaSpaceString)
              else:
                p.buf.writeByte(runelit(' '))
            if (p.fmt.plusV or p.fmt.sharpV):
              if (var name = f.getType().field(i).name; (name != "")):
                p.buf.writeString(name)
                p.buf.writeByte(runelit(':'))
            p.printValue(getField(f, i), verb, (depth + 1))
          i += 1
      p.buf.writeByte(runelit('}'))
    elif condition == reflect.Kind.`interface`:
      var value = f.elem()
      if not value.isValid():
        if p.fmt.sharpV:
          p.buf.writeString(f.getType().toString())
          p.buf.writeString(nilParenString)
        else:
          p.buf.writeString(nilAngleString)
      else:
        p.printValue(value, verb, (depth + 1))
    elif condition == reflect.Kind.array or condition == reflect.Kind.slice:
      block:
        let condition = verb
        if condition == runelit('s') or condition == runelit('q') or condition == runelit('x') or condition == runelit('X'):
          var t = f.getType()
          if (t.elem().kind() == reflect.Kind.uint8):
            var bytes: GoSlice[byte]
            if (f.kind() == reflect.Kind.slice):
              bytes = f.bytes()
            elif f.canAddr():
              bytes = f.slice(0, f.len()).bytes()
            else:
              bytes = make(GoSlice[byte], f.len())
              for i in 0..<len(bytes):
                bytes[i] = convert(byte, f.index(i).toUint())
            p.fmtBytes(bytes, verb, t.toString())
            return
      
      if p.fmt.sharpV:
        p.buf.writeString(f.getType().toString())
        if ((f.kind() == reflect.Kind.slice) and f.isNil()):
          p.buf.writeString(nilParenString)
          return
        else:
          p.buf.writeByte(runelit('{'))
          block loop0:
            var i = 0
            while (i < f.len()):
              block loop0Continue:
                if (i > 0):
                  p.buf.writeString(commaSpaceString)
                p.printValue(f.index(i), verb, (depth + 1))
              i += 1
          p.buf.writeByte(runelit('}'))
      else:
        p.buf.writeByte(runelit('['))
        block loop0:
          var i = 0
          while (i < f.len()):
            block loop0Continue:
              if (i > 0):
                p.buf.writeByte(runelit(' '))
              p.printValue(f.index(i), verb, (depth + 1))
            i += 1
        p.buf.writeByte(runelit(']'))
    elif condition == reflect.Kind.`ptr`:
      if ((depth == 0) and (f.toPointer() != 0)):
        block:
          var a = f.elem()
          let condition = a.kind()
          if condition == reflect.Kind.array or condition == reflect.Kind.slice or condition == reflect.Kind.struct or condition == reflect.Kind.map:
            p.buf.writeByte(runelit('&'))
            p.printValue(a, verb, (depth + 1))
            return
      
      p.fmtPointer(f, verb)
    elif condition == reflect.Kind.chan or condition == reflect.Kind.`func` or condition == reflect.Kind.unsafePointer:
      p.fmtPointer(f, verb)
    else:
      p.unknownType(f)

proc intFromArg(a: GoSlice[EmptyInterface], argNum: int): tuple[num: int, isInt: bool, newArgNum: int] =
  result.newArgNum = argNum
  if (argNum < len(a)):
    (result.num, result.isInt) = maybeCastInterface(a[argNum], to=int)
    if not result.isInt:
      block:
        var v = reflect.valueOf(a[argNum])
        let condition = v.kind()
        if condition == reflect.Kind.int or condition == reflect.Kind.int8 or condition == reflect.Kind.int16 or condition == reflect.Kind.int32 or condition == reflect.Kind.int64:
          var n = v.toInt()
          if (convert(int64, convert(int, n)) == n):
            result.num = convert(int, n)
            result.isInt = true
        elif condition == reflect.Kind.uint or condition == reflect.Kind.uint8 or condition == reflect.Kind.uint16 or condition == reflect.Kind.uint32 or condition == reflect.Kind.uint64 or condition == reflect.Kind.uintptr:
          var n = v.toUint()
          if ((convert(int64, n) >= 0) and (convert(uint64, convert(int, n)) == n)):
            result.num = convert(int, n)
            result.isInt = true
        else:
          discard
    
    result.newArgNum = (argNum + 1)
    if tooLarge(result.num):
      result.num = 0
      result.isInt = false
  return

proc parseArgNumber(format: string): tuple[index: int, wid: int, ok: bool] =
  if (len(format) < 3):
    (result.index, result.wid, result.ok) = (0, 1, false)
    return
  block loop0:
    var i = 1
    while (i < len(format)):
      block loop0Continue:
        if (format[i] == runelit(']')):
          var (widthInternal, ok, newi) = parsenum(format, 1, i)
          if (not ok or (newi != i)):
            (result.index, result.wid, result.ok) = (0, (i + 1), false)
            return
          (result.index, result.wid, result.ok) = ((widthInternal - 1), (i + 1), true)
          return
      i += 1
  (result.index, result.wid, result.ok) = (0, 1, false)
  return

proc argNumber(p: gcptr[Pp], argNum: int, format: string, i: int, numArgs: int): tuple[newArgNum: int, newi: int, found: bool] =
  if ((len(format) <= i) or (format[i] != runelit('['))):
    (result.newArgNum, result.newi, result.found) = (argNum, i, false)
    return
  p.reordered = true
  var (index, wid, ok) = parseArgNumber(slice(format, low=i))
  if ((ok and (0 <= index)) and (index < numArgs)):
    (result.newArgNum, result.newi, result.found) = (index, (i + wid), true)
    return
  p.goodArgNum = false
  (result.newArgNum, result.newi, result.found) = (argNum, (i + wid), ok)
  return

proc badArgNum(p: gcptr[Pp], verb: Rune): void =
  p.buf.writeString(percentBangString)
  p.buf.writeRune(verb)
  p.buf.writeString(badIndexString)

proc missingArg(p: gcptr[Pp], verb: Rune): void =
  p.buf.writeString(percentBangString)
  p.buf.writeRune(verb)
  p.buf.writeString(missingString)

proc doPrintf(p: gcptr[Pp], format: string, a: GoSlice[EmptyInterface]): void =
  var `end` = len(format)
  var argNum = 0
  var afterIndex = false
  p.reordered = false
  block loop0:
    var i = 0
    while (i < `end`):
      p.goodArgNum = true
      var lasti = i
      while ((i < `end`) and (format[i] != runelit('%'))):
        i += 1
      if (i > lasti):
        p.buf.writeString(slice(format, low=lasti, high=i))
      if (i >= `end`):
        break
      i += 1
      p.fmt.clearflags()
      block loop1:
        while (i < `end`):
          block loop1Continue:
            var c = format[i]
            block:
              let condition = c
              if condition == runelit('#'):
                p.fmt.sharp = true
              elif condition == runelit('0'):
                p.fmt.zero = not p.fmt.minus
              elif condition == runelit('+'):
                p.fmt.plus = true
              elif condition == runelit('-'):
                p.fmt.minus = true
                p.fmt.zero = false
              elif condition == runelit(' '):
                p.fmt.space = true
              else:
                if (((runelit('a') <= c) and (c <= runelit('z'))) and (argNum < len(a))):
                  if (c == runelit('v')):
                    p.fmt.sharpV = p.fmt.sharp
                    p.fmt.sharp = false
                    p.fmt.plusV = p.fmt.plus
                    p.fmt.plus = false
                  p.printArg(a[argNum], convert(Rune, c))
                  argNum += 1
                  i += 1
                  break loop1Continue
                break loop1
          i += 1
      (argNum, i, afterIndex) = p.argNumber(argNum, format, i, len(a))
      if ((i < `end`) and (format[i] == runelit('*'))):
        i += 1
        (p.fmt.wid, p.fmt.widPresent, argNum) = intFromArg(a, argNum)
        if not p.fmt.widPresent:
          p.buf.writeString(badWidthString)
        if (p.fmt.wid < 0):
          p.fmt.wid = -p.fmt.wid
          p.fmt.minus = true
          p.fmt.zero = false
        afterIndex = false
      else:
        (p.fmt.wid, p.fmt.widPresent, i) = parsenum(format, i, `end`)
        if (afterIndex and p.fmt.widPresent):
          p.goodArgNum = false
      if (((i + 1) < `end`) and (format[i] == runelit('.'))):
        i += 1
        if afterIndex:
          p.goodArgNum = false
        (argNum, i, afterIndex) = p.argNumber(argNum, format, i, len(a))
        if ((i < `end`) and (format[i] == runelit('*'))):
          i += 1
          (p.fmt.prec, p.fmt.precPresent, argNum) = intFromArg(a, argNum)
          if (p.fmt.prec < 0):
            p.fmt.prec = 0
            p.fmt.precPresent = false
          if not p.fmt.precPresent:
            p.buf.writeString(badPrecString)
          afterIndex = false
        else:
          (p.fmt.prec, p.fmt.precPresent, i) = parsenum(format, i, `end`)
          if not p.fmt.precPresent:
            p.fmt.prec = 0
            p.fmt.precPresent = true
      if not afterIndex:
        (argNum, i, afterIndex) = p.argNumber(argNum, format, i, len(a))
      if (i >= `end`):
        p.buf.writeString(noVerbString)
        break
      var (verb, w) = utf8.decodeRuneInString(slice(format, low=i))
      i += w
      if true == (verb == runelit('%')):
        p.buf.writeByte(runelit('%'))
      elif true == not p.goodArgNum:
        p.badArgNum(verb)
      elif true == (argNum >= len(a)):
        p.missingArg(verb)
      elif true == (verb == runelit('v')):
        p.fmt.sharpV = p.fmt.sharp
        p.fmt.sharp = false
        p.fmt.plusV = p.fmt.plus
        p.fmt.plus = false
        p.printArg(a[argNum], verb)
        argNum += 1
      else:
        p.printArg(a[argNum], verb)
        argNum += 1
  if (not p.reordered and (argNum < len(a))):
    p.fmt.clearflags()
    p.buf.writeString(extraString)
    for i, arg in slice(a, low=argNum):
      if (i > 0):
        p.buf.writeString(commaSpaceString)
      if (arg == null):
        p.buf.writeString(nilAngleString)
      else:
        p.buf.writeString(reflect.typeOf(arg).toString())
        p.buf.writeByte(runelit('='))
        p.printArg(arg, runelit('v'))
    p.buf.writeByte(runelit(')'))

proc doPrint(p: gcptr[Pp], a: GoSlice[EmptyInterface]): void =
  var prevString = false
  for argNum, arg in a:
    var isString = ((arg != null) and (reflect.typeOf(arg).kind() == reflect.Kind.string))
    if (((argNum > 0) and not isString) and not prevString):
      p.buf.writeByte(runelit(' '))
    p.printArg(arg, runelit('v'))
    prevString = isString

proc doPrintln(p: gcptr[Pp], a: GoSlice[EmptyInterface]): void =
  for argNum, arg in a:
    if (argNum > 0):
      p.buf.writeByte(runelit(' '))
    p.printArg(arg, runelit('v'))
  p.buf.writeByte(runelit('\L'))



proc scan(a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] =
  (result.n, result.err) = fscan(os.stdin, govarargs(a))
  return

proc scanln(a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] =
  (result.n, result.err) = fscanln(os.stdin, govarargs(a))
  return

proc scanf(format: string, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] =
  (result.n, result.err) = fscanf(os.stdin, format, govarargs(a))
  return

proc read(r: gcptr[StringReader], b: GoSlice[byte]): tuple[n: int, err: Error] =
  result.n = copy(b, r[])
  r[] = slice((r[]), low=result.n)
  if (result.n == 0):
    result.err = io.EOF
  return

proc sscan(str: string, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] =
  (result.n, result.err) = fscan(convert(gcptr[StringReader], gcaddr str), govarargs(a))
  return

proc sscanln(str: string, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] =
  (result.n, result.err) = fscanln(convert(gcptr[StringReader], gcaddr str), govarargs(a))
  return

proc sscanf(str: string, format: string, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] =
  (result.n, result.err) = fscanf(convert(gcptr[StringReader], gcaddr str), format, govarargs(a))
  return

proc fscan(r: io.Reader, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] =
  var (s, old) = newScanState(r, true, false)
  (result.n, result.err) = s.doScan(a)
  s.free(old)
  return

proc fscanln(r: io.Reader, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] =
  var (s, old) = newScanState(r, false, true)
  (result.n, result.err) = s.doScan(a)
  s.free(old)
  return

proc fscanf(r: io.Reader, format: string, a: GoVarArgs[EmptyInterface]): tuple[n: int, err: Error] =
  var (s, old) = newScanState(r, false, false)
  (result.n, result.err) = s.doScanf(format, a)
  s.free(old)
  return

proc read(s: gcptr[Ss], buf: GoSlice[byte]): tuple[n: int, err: Error] =
  (result.n, result.err) = (0, errors.new("ScanState's Read should not be called. Use ReadRune"))
  return

proc readRune(s: gcptr[Ss]): tuple[r: Rune, size: int, err: Error] =
  if (s.atEOF or (s.count >= s.argLimit)):
    result.err = io.EOF
    return
  (result.r, result.size, result.err) = s.rs.readRune()
  if (result.err == null):
    s.count += 1
    if (s.nlIsEnd and (result.r == runelit('\L'))):
      s.atEOF = true
  elif (result.err == io.EOF):
    s.atEOF = true
  return

proc width(s: gcptr[Ss]): tuple[wid: int, ok: bool] =
  if (s.maxWid == hugeWid):
    (result.wid, result.ok) = (0, false)
    return
  (result.wid, result.ok) = (s.maxWid, true)
  return

proc getRune(s: gcptr[Ss]): Rune =
  var unused: type((s.readRune())[1])
  var err: type((s.readRune())[2])
  (result, unused, err) = s.readRune()
  if (err != null):
    if (err == io.EOF):
      return eof
    s.error(err)
  return

proc mustReadRune(s: gcptr[Ss]): Rune =
  result = s.getRune()
  if (result == eof):
    s.error(io.errUnexpectedEOF)
  return

proc unreadRune(s: gcptr[Ss]): Error =
  s.rs.unreadRune()
  s.atEOF = false
  s.count -= 1
  return null

proc error(s: gcptr[Ss], err: Error): void =
  panic(make((err), ScanError))

proc errorString(s: gcptr[Ss], err: string): void =
  panic(make((errors.new(err)), ScanError))

proc token(s: gcptr[Ss], skipSpaceInternal: bool, f: (proc(arg0: Rune): bool)): tuple[tok: GoSlice[byte], err: Error] =
  var f = f
  godefer((proc(): void =
    if (var e = recover(); (e != null)):
      if (var (se, ok) = maybeCastInterface(e, to=ScanError); ok):
        discard
      else:
        panic(e))())
  if (f == null):
    f = notSpace
  s.buf = slice(s.buf, high=0)
  result.tok = s.tokenInternal(skipSpaceInternal, f)
  return

proc isSpace(r: Rune): bool =
  if (r >= (1 shl 16)):
    return false
  var rx = convert(uint16, r)
  for _, rng in spaceF:
    if (rx < rng[0]):
      return false
    if (rx <= rng[1]):
      return true
  return false

proc notSpace(r: Rune): bool =
  return not isSpace(r)

proc skipSpace(s: gcptr[Ss]): void =
  s.skipSpaceInternal(false)

proc readByte(r: gcptr[ReadRune]): tuple[b: byte, err: Error] =
  if (r.pending > 0):
    result.b = r.pendBuf[0]
    copy(slice(r.pendBuf, low=0), slice(r.pendBuf, low=1))
    r.pending -= 1
    return
  var n: type((io.readFull(r.reader, slice(r.pendBuf, high=1)))[0])
  (n, result.err) = io.readFull(r.reader, slice(r.pendBuf, high=1))
  if (n != 1):
    (result.b, result.err) = (0, result.err)
    return
  (result.b, result.err) = (r.pendBuf[0], result.err)
  return

proc readRune(r: gcptr[ReadRune]): tuple[rr: Rune, size: int, err: Error] =
  if (r.peekRune >= 0):
    result.rr = r.peekRune
    r.peekRune = not r.peekRune
    result.size = utf8.runeLen(result.rr)
    return
  (r.buf[0], result.err) = r.readByte()
  if (result.err != null):
    return
  if (r.buf[0] < utf8.runeSelf):
    result.rr = convert(Rune, r.buf[0])
    result.size = 1
    r.peekRune = not result.rr
    return
  var n: int
  block loop0:
    n = 1
    while not utf8.fullRune(slice(r.buf, high=n)):
      block loop0Continue:
        (r.buf[n], result.err) = r.readByte()
        if (result.err != null):
          if (result.err == io.EOF):
            result.err = null
            break loop0
          return
      n += 1
  (result.rr, result.size) = utf8.decodeRune(slice(r.buf, high=n))
  if (result.size < n):
    copy(slice(r.pendBuf, low=r.pending), slice(r.buf, low=result.size, high=n))
    r.pending += (n - result.size)
  r.peekRune = not result.rr
  return

proc unreadRune(r: gcptr[ReadRune]): Error =
  if (r.peekRune >= 0):
    return errors.new("fmt: scanning called UnreadRune with no rune available")
  r.peekRune = not r.peekRune
  return null

proc newScanState(r: io.Reader, nlIsSpace: bool, nlIsEnd: bool): tuple[s: gcptr[Ss], old: Ssave] =
  result.s = castInterface(ssFree.get(), to=gcptr[Ss])
  if (var (rs, ok) = maybeCastInterface(r, to=io.RuneScanner); ok):
    result.s.rs = rs
  else:
    result.s.rs = convert(gcptr[ReadRune], (ref ReadRune)(reader: r, peekRune: -1))
  result.s.nlIsSpace = nlIsSpace
  result.s.nlIsEnd = nlIsEnd
  result.s.atEOF = false
  result.s.limit = hugeWid
  result.s.argLimit = hugeWid
  result.s.maxWid = hugeWid
  result.s.validSave = true
  result.s.count = 0
  return

proc free(s: gcptr[Ss], old: Ssave): void =
  if old.validSave:
    s.ssave = old
    return
  if (cap(s.buf) > 1024):
    return
  s.buf = slice(s.buf, high=0)
  s.rs = null
  ssFree.put(s)

proc skipSpaceInternal(s: gcptr[Ss], stopAtNewline: bool): void =
  while true:
    var r = s.getRune()
    if (r == eof):
      return
    if ((r == runelit('\r')) and s.peek("\n")):
      continue
    if (r == runelit('\L')):
      if stopAtNewline:
        break
      if s.nlIsSpace:
        continue
      s.errorString("unexpected newline")
      return
    if not isSpace(r):
      s.unreadRune()
      break

proc tokenInternal(s: gcptr[Ss], skipSpaceInternal: bool, f: (proc(arg0: Rune): bool)): GoSlice[byte] =
  if skipSpaceInternal:
    s.skipSpaceInternal(false)
  while true:
    var r = s.getRune()
    if (r == eof):
      break
    if not f(r):
      s.unreadRune()
      break
    s.buf.writeRune(r)
  return s.buf

proc indexRune(s: string, r: Rune): int =
  for i, c in s:
    if (c == r):
      return i
  return -1

proc consume(s: gcptr[Ss], ok: string, accept: bool): bool =
  var r = s.getRune()
  if (r == eof):
    return false
  if (indexRune(ok, r) >= 0):
    if accept:
      s.buf.writeRune(r)
    return true
  if ((r != eof) and accept):
    s.unreadRune()
  return false

proc peek(s: gcptr[Ss], ok: string): bool =
  var r = s.getRune()
  if (r != eof):
    s.unreadRune()
  return (indexRune(ok, r) >= 0)

proc notEOF(s: gcptr[Ss]): void =
  if (var r = s.getRune(); (r == eof)):
    panic(io.EOF)
  s.unreadRune()

proc accept(s: gcptr[Ss], ok: string): bool =
  return s.consume(ok, true)

proc okVerb(s: gcptr[Ss], verb: Rune, okVerbs: string, typ: string): bool =
  for _, v in okVerbs:
    if (v == verb):
      return true
  s.errorString(((("bad verb '%" + convert(string, verb)) + "' for ") + typ))
  return false

proc scanBool(s: gcptr[Ss], verb: Rune): bool =
  s.skipSpaceInternal(false)
  s.notEOF()
  if not s.okVerb(verb, "tv", "boolean"):
    return false
  block:
    let condition = s.getRune()
    if condition == runelit('0'):
      return false
    elif condition == runelit('1'):
      return true
    elif condition == runelit('t') or condition == runelit('T'):
      if (s.accept("rR") and ((not s.accept("uU") or not s.accept("eE")))):
        s.error(boolError)
      return true
    elif condition == runelit('f') or condition == runelit('F'):
      if (s.accept("aA") and (((not s.accept("lL") or not s.accept("sS")) or not s.accept("eE")))):
        s.error(boolError)
      return false
  
  return false

proc getBase(s: gcptr[Ss], verb: Rune): tuple[base: int, digits: string] =
  s.okVerb(verb, "bdoUxXv", "integer")
  result.base = 10
  result.digits = decimalDigits
  block:
    let condition = verb
    if condition == runelit('b'):
      result.base = 2
      result.digits = binaryDigits
    elif condition == runelit('o'):
      result.base = 8
      result.digits = octalDigits
    elif condition == runelit('x') or condition == runelit('X') or condition == runelit('U'):
      result.base = 16
      result.digits = hexadecimalDigits
  
  return

proc scanNumber(s: gcptr[Ss], digits: string, haveDigits: bool): string =
  if not haveDigits:
    s.notEOF()
    if not s.accept(digits):
      s.errorString("expected integer")
  while s.accept(digits):
    discard
  
  return convert(string, s.buf)

proc scanRune(s: gcptr[Ss], bitSize: int): int64 =
  s.notEOF()
  var r = convert(int64, s.getRune())
  var n = convert(uint, bitSize)
  var x = (((r shl ((64 - n)))) shr ((64 - n)))
  if (x != r):
    s.errorString(("overflow on character value " + convert(string, r)))
  return r

proc scanBasePrefix(s: gcptr[Ss]): tuple[base: int, digits: string, found: bool] =
  if not s.peek("0"):
    (result.base, result.digits, result.found) = (10, decimalDigits, false)
    return
  s.accept("0")
  result.found = true
  (result.base, result.digits) = (8, octalDigits)
  if s.peek("xX"):
    s.consume("xX", false)
    (result.base, result.digits) = (16, hexadecimalDigits)
  return

proc scanInt(s: gcptr[Ss], verb: Rune, bitSize: int): int64 =
  if (verb == runelit('c')):
    return s.scanRune(bitSize)
  s.skipSpaceInternal(false)
  s.notEOF()
  var (base, digits) = s.getBase(verb)
  var haveDigits = false
  if (verb == runelit('U')):
    if (not s.consume("U", false) or not s.consume("+", false)):
      s.errorString("bad unicode format ")
  else:
    s.accept(sign)
    if (verb == runelit('v')):
      (base, digits, haveDigits) = s.scanBasePrefix()
  var tok = s.scanNumber(digits, haveDigits)
  var (i, err) = strconv.parseInt(tok, base, 64)
  if (err != null):
    s.error(err)
  var n = convert(uint, bitSize)
  var x = (((i shl ((64 - n)))) shr ((64 - n)))
  if (x != i):
    s.errorString(("integer overflow on token " + tok))
  return i

proc scanUint(s: gcptr[Ss], verb: Rune, bitSize: int): uint64 =
  if (verb == runelit('c')):
    return convert(uint64, s.scanRune(bitSize))
  s.skipSpaceInternal(false)
  s.notEOF()
  var (base, digits) = s.getBase(verb)
  var haveDigits = false
  if (verb == runelit('U')):
    if (not s.consume("U", false) or not s.consume("+", false)):
      s.errorString("bad unicode format ")
  elif (verb == runelit('v')):
    (base, digits, haveDigits) = s.scanBasePrefix()
  var tok = s.scanNumber(digits, haveDigits)
  var (i, err) = strconv.parseUint(tok, base, 64)
  if (err != null):
    s.error(err)
  var n = convert(uint, bitSize)
  var x = (((i shl ((64 - n)))) shr ((64 - n)))
  if (x != i):
    s.errorString(("unsigned integer overflow on token " + tok))
  return i

proc floatToken(s: gcptr[Ss]): string =
  s.buf = slice(s.buf, high=0)
  if ((s.accept("nN") and s.accept("aA")) and s.accept("nN")):
    return convert(string, s.buf)
  s.accept(sign)
  if ((s.accept("iI") and s.accept("nN")) and s.accept("fF")):
    return convert(string, s.buf)
  while s.accept(decimalDigits):
    discard
  
  if s.accept(period):
    while s.accept(decimalDigits):
      discard
  
  if s.accept(exponent):
    s.accept(sign)
    while s.accept(decimalDigits):
      discard
  
  return convert(string, s.buf)

proc complexTokens(s: gcptr[Ss]): tuple[real: string, imag: string] =
  var parens = s.accept("(")
  result.real = s.floatToken()
  s.buf = slice(s.buf, high=0)
  if not s.accept("+-"):
    s.error(complexError)
  var imagSign = convert(string, s.buf)
  result.imag = s.floatToken()
  if not s.accept("i"):
    s.error(complexError)
  if (parens and not s.accept(")")):
    s.error(complexError)
  (result.real, result.imag) = (result.real, (imagSign + result.imag))
  return

proc convertFloat(s: gcptr[Ss], str: string, n: int): float64 =
  if (var p = indexRune(str, runelit('p')); (p >= 0)):
    var (f, err) = strconv.parseFloat(slice(str, high=p), n)
    if (err != null):
      if (var (e, ok) = maybeCastInterface(err, to=gcptr[strconv.NumError]); ok):
        e.num = str
      s.error(err)
    var m: type((strconv.atoi(slice(str, low=(p + 1))))[0])
    (m, err) = strconv.atoi(slice(str, low=(p + 1)))
    if (err != null):
      if (var (e, ok) = maybeCastInterface(err, to=gcptr[strconv.NumError]); ok):
        e.num = str
      s.error(err)
    return math.ldexp(f, m)
  var (f, err) = strconv.parseFloat(str, n)
  if (err != null):
    s.error(err)
  return f

proc scanComplex(s: gcptr[Ss], verb: Rune, n: int): complex128 =
  if not s.okVerb(verb, floatVerbs, "complex"):
    return 0
  s.skipSpaceInternal(false)
  s.notEOF()
  var (sreal, simag) = s.complexTokens()
  var real = s.convertFloat(sreal, `go/`(n, 2))
  var imag = s.convertFloat(simag, `go/`(n, 2))
  return complex(real, imag)

proc convertString(s: gcptr[Ss], verb: Rune): string =
  if not s.okVerb(verb, "svqxX", "string"):
    return ""
  s.skipSpaceInternal(false)
  s.notEOF()
  block:
    let condition = verb
    if condition == runelit('q'):
      result = s.quotedString()
    elif condition == runelit('x') or condition == runelit('X'):
      result = s.hexString()
    else:
      result = convert(string, s.tokenInternal(true, notSpace))
  return

proc quotedString(s: gcptr[Ss]): string =
  s.notEOF()
  var quote = s.getRune()
  block:
    let condition = quote
    if condition == runelit('`'):
      while true:
        var r = s.mustReadRune()
        if (r == quote):
          break
        s.buf.writeRune(r)
      return convert(string, s.buf)
    elif condition == runelit('"'):
      s.buf.writeByte(runelit('"'))
      while true:
        var r = s.mustReadRune()
        s.buf.writeRune(r)
        if (r == runelit('\\')):
          s.buf.writeRune(s.mustReadRune())
        elif (r == runelit('"')):
          break
      var (result, err) = strconv.unquote(convert(string, s.buf))
      if (err != null):
        s.error(err)
      return result
    else:
      s.errorString("expected quoted string")
  return ""

proc hexDigit(d: Rune): tuple[arg0: int, arg1: bool] =
  var digit = convert(int, d)
  block:
    let condition = digit
    if condition == runelit('0') or condition == runelit('1') or condition == runelit('2') or condition == runelit('3') or condition == runelit('4') or condition == runelit('5') or condition == runelit('6') or condition == runelit('7') or condition == runelit('8') or condition == runelit('9'):
      (result.arg0, result.arg1) = ((digit - runelit('0')), true)
      return
    elif condition == runelit('a') or condition == runelit('b') or condition == runelit('c') or condition == runelit('d') or condition == runelit('e') or condition == runelit('f'):
      (result.arg0, result.arg1) = (((10 + digit) - runelit('a')), true)
      return
    elif condition == runelit('A') or condition == runelit('B') or condition == runelit('C') or condition == runelit('D') or condition == runelit('E') or condition == runelit('F'):
      (result.arg0, result.arg1) = (((10 + digit) - runelit('A')), true)
      return
  
  (result.arg0, result.arg1) = (-1, false)
  return

proc hexByte(s: gcptr[Ss]): tuple[b: byte, ok: bool] =
  var rune1 = s.getRune()
  if (rune1 == eof):
    return
  var value1: type((hexDigit(rune1))[0])
  (value1, result.ok) = hexDigit(rune1)
  if not result.ok:
    s.unreadRune()
    return
  var value2: type((hexDigit(s.mustReadRune()))[0])
  (value2, result.ok) = hexDigit(s.mustReadRune())
  if not result.ok:
    s.errorString("illegal hex digit")
    return
  (result.b, result.ok) = (convert(byte, ((value1 shl 4) or value2)), true)
  return

proc hexString(s: gcptr[Ss]): string =
  s.notEOF()
  while true:
    var (b, ok) = s.hexByte()
    if not ok:
      break
    s.buf.writeByte(b)
  if (len(s.buf) == 0):
    s.errorString("no hex data for %x string")
    return ""
  return convert(string, s.buf)

proc scanOne(s: gcptr[Ss], verb: Rune, arg: EmptyInterface): void =
  s.buf = slice(s.buf, high=0)
  var err: Error
  if (var (v, ok) = maybeCastInterface(arg, to=Scanner); ok):
    err = v.scan(s, verb)
    if (err != null):
      if (err == io.EOF):
        err = io.errUnexpectedEOF
      s.error(err)
    return
  block:
    let typeSwitchOn = arg
    let condition = typeId(typeSwitchOn)
    if condition == typeId(gcptr[bool]):
      let v = castInterface(typeSwitchOn, to=gcptr[bool])
      v[] = s.scanBool(verb)
    elif condition == typeId(gcptr[complex64]):
      let v = castInterface(typeSwitchOn, to=gcptr[complex64])
      v[] = convert(complex64, s.scanComplex(verb, 64))
    elif condition == typeId(gcptr[complex128]):
      let v = castInterface(typeSwitchOn, to=gcptr[complex128])
      v[] = s.scanComplex(verb, 128)
    elif condition == typeId(gcptr[int]):
      let v = castInterface(typeSwitchOn, to=gcptr[int])
      v[] = convert(int, s.scanInt(verb, intBits))
    elif condition == typeId(gcptr[int8]):
      let v = castInterface(typeSwitchOn, to=gcptr[int8])
      v[] = convert(int8, s.scanInt(verb, 8))
    elif condition == typeId(gcptr[int16]):
      let v = castInterface(typeSwitchOn, to=gcptr[int16])
      v[] = convert(int16, s.scanInt(verb, 16))
    elif condition == typeId(gcptr[int32]):
      let v = castInterface(typeSwitchOn, to=gcptr[int32])
      v[] = convert(int32, s.scanInt(verb, 32))
    elif condition == typeId(gcptr[int64]):
      let v = castInterface(typeSwitchOn, to=gcptr[int64])
      v[] = s.scanInt(verb, 64)
    elif condition == typeId(gcptr[uint]):
      let v = castInterface(typeSwitchOn, to=gcptr[uint])
      v[] = convert(uint, s.scanUint(verb, intBits))
    elif condition == typeId(gcptr[uint8]):
      let v = castInterface(typeSwitchOn, to=gcptr[uint8])
      v[] = convert(uint8, s.scanUint(verb, 8))
    elif condition == typeId(gcptr[uint16]):
      let v = castInterface(typeSwitchOn, to=gcptr[uint16])
      v[] = convert(uint16, s.scanUint(verb, 16))
    elif condition == typeId(gcptr[uint32]):
      let v = castInterface(typeSwitchOn, to=gcptr[uint32])
      v[] = convert(uint32, s.scanUint(verb, 32))
    elif condition == typeId(gcptr[uint64]):
      let v = castInterface(typeSwitchOn, to=gcptr[uint64])
      v[] = s.scanUint(verb, 64)
    elif condition == typeId(gcptr[uintptr]):
      let v = castInterface(typeSwitchOn, to=gcptr[uintptr])
      v[] = convert(uintptr, s.scanUint(verb, uintptrBits))
    elif condition == typeId(gcptr[float32]):
      let v = castInterface(typeSwitchOn, to=gcptr[float32])
      if s.okVerb(verb, floatVerbs, "float32"):
        s.skipSpaceInternal(false)
        s.notEOF()
        v[] = float32(s.convertFloat(s.floatToken(), 32))
    elif condition == typeId(gcptr[float64]):
      let v = castInterface(typeSwitchOn, to=gcptr[float64])
      if s.okVerb(verb, floatVerbs, "float64"):
        s.skipSpaceInternal(false)
        s.notEOF()
        v[] = s.convertFloat(s.floatToken(), 64)
    elif condition == typeId(gcptr[string]):
      let v = castInterface(typeSwitchOn, to=gcptr[string])
      v[] = s.convertString(verb)
    elif condition == typeId(gcptr[GoSlice[byte]]):
      let v = castInterface(typeSwitchOn, to=gcptr[GoSlice[byte]])
      v[] = convert(GoSlice[byte], s.convertString(verb))
    else:
      let v = typeSwitchOn
      var val = reflect.valueOf(v)
      var `ptr` = val
      if (`ptr`.kind() != reflect.Kind.`ptr`):
        s.errorString(("type not a pointer: " + val.getType().toString()))
        return
      block:
        var v = `ptr`.elem()
        let condition = v.kind()
        if condition == reflect.Kind.bool:
          v.setBool(s.scanBool(verb))
        elif condition == reflect.Kind.int or condition == reflect.Kind.int8 or condition == reflect.Kind.int16 or condition == reflect.Kind.int32 or condition == reflect.Kind.int64:
          v.setInt(s.scanInt(verb, v.getType().bits()))
        elif condition == reflect.Kind.uint or condition == reflect.Kind.uint8 or condition == reflect.Kind.uint16 or condition == reflect.Kind.uint32 or condition == reflect.Kind.uint64 or condition == reflect.Kind.uintptr:
          v.setUint(s.scanUint(verb, v.getType().bits()))
        elif condition == reflect.Kind.string:
          v.setString(s.convertString(verb))
        elif condition == reflect.Kind.slice:
          var typ = v.getType()
          if (typ.elem().kind() != reflect.Kind.uint8):
            s.errorString(("can't scan type: " + val.getType().toString()))
          var str = s.convertString(verb)
          v.set(reflect.makeSlice(typ, len(str), len(str)))
          block loop0:
            var i = 0
            while (i < len(str)):
              block loop0Continue:
                v.index(i).setUint(convert(uint64, str[i]))
              i += 1
        elif condition == reflect.Kind.float32 or condition == reflect.Kind.float64:
          s.skipSpaceInternal(false)
          s.notEOF()
          v.setFloat(s.convertFloat(s.floatToken(), v.getType().bits()))
        elif condition == reflect.Kind.complex64 or condition == reflect.Kind.complex128:
          v.setComplex(s.scanComplex(verb, v.getType().bits()))
        else:
          s.errorString(("can't scan type: " + val.getType().toString()))

proc errorHandler(errp: gcptr[Error]): void =
  if (var e = recover(); (e != null)):
    if (var (se, ok) = maybeCastInterface(e, to=ScanError); ok):
      errp[] = se.err
    elif (var (eof, ok) = maybeCastInterface(e, to=Error); (ok and (eof == io.EOF))):
      errp[] = eof
    else:
      panic(e)

proc doScan(s: gcptr[Ss], a: GoSlice[EmptyInterface]): tuple[numProcessed: int, err: Error] =
  
  for _, arg in a:
    s.scanOne(runelit('v'), arg)
    result.numProcessed += 1
  if s.nlIsEnd:
    while true:
      var r = s.getRune()
      if ((r == runelit('\L')) or (r == eof)):
        break
      if not isSpace(r):
        s.errorString("expected newline")
        break
  return

proc advance(s: gcptr[Ss], format: string): int =
  while (result < len(format)):
    var (fmtc, w) = utf8.decodeRuneInString(slice(format, low=result))
    if (fmtc == runelit('%')):
      if ((result + w) == len(format)):
        s.errorString("missing verb: % at end of format string")
      var (nextc, unused) = utf8.decodeRuneInString(slice(format, low=(result + w)))
      if (nextc != runelit('%')):
        return
      result += w
    var sawSpace = false
    var wasNewline = false
    while (isSpace(fmtc) and (result < len(format))):
      if (fmtc == runelit('\L')):
        if wasNewline:
          break
        wasNewline = true
      sawSpace = true
      result += w
      (fmtc, w) = utf8.decodeRuneInString(slice(format, low=result))
    if sawSpace:
      var inputc = s.getRune()
      if (inputc == eof):
        return
      if not isSpace(inputc):
        s.errorString("expected space in input to match format")
      while ((inputc != runelit('\L')) and isSpace(inputc)):
        inputc = s.getRune()
      if (inputc == runelit('\L')):
        if not wasNewline:
          s.errorString("newline in input does not match format")
        return
      s.unreadRune()
      if wasNewline:
        s.errorString("newline in format does not match input")
      continue
    var inputc = s.mustReadRune()
    if (fmtc != inputc):
      s.unreadRune()
      return -1
    result += w
  return

proc doScanf(s: gcptr[Ss], format: string, a: GoSlice[EmptyInterface]): tuple[numProcessed: int, err: Error] =
  
  var `end` = (len(format) - 1)
  block loop0:
    var i = 0
    while (i <= `end`):
      var w = s.advance(slice(format, low=i))
      if (w > 0):
        i += w
        continue
      if (format[i] != runelit('%')):
        if (w < 0):
          s.errorString("input does not match format")
        break
      i += 1
      var widPresent: bool
      (s.maxWid, widPresent, i) = parsenum(format, i, `end`)
      if not widPresent:
        s.maxWid = hugeWid
      var c: type((utf8.decodeRuneInString(slice(format, low=i)))[0])
      (c, w) = utf8.decodeRuneInString(slice(format, low=i))
      i += w
      if (c != runelit('c')):
        s.skipSpace()
      s.argLimit = s.limit
      if (var f = (s.count + s.maxWid); (f < s.argLimit)):
        s.argLimit = f
      if (result.numProcessed >= len(a)):
        s.errorString((("too few operands for format '%" + slice(format, low=(i - w))) + "'"))
        break
      var arg = a[result.numProcessed]
      s.scanOne(c, arg)
      result.numProcessed += 1
      s.argLimit = s.limit
  if (result.numProcessed < len(a)):
    s.errorString("too many operands")
  return


when isMainModule:
  main()
