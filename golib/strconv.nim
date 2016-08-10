include gosupport
import golib/math
import golib/errors
import golib/math
import golib/unicode/utf8
const fnParseFloat = "ParseFloat"
const intSizeInternal = (32 shl ((not convert(uint, 0) shr 63)))
const intSize* = intSizeInternal
const maxUint64 = (((1 shl 64) - 1))
const uintSize = (32 shl ((not convert(uint, 0) shr 63)))
const maxShift = (uintSize - 4)
const 
  firstPowerOfTen = -348
  stepPowerOfTen = 8
const digits = "0123456789abcdefghijklmnopqrstuvwxyz"
const lowerhex = "0123456789abcdef"

exttypes:
  type
    NumError* = struct((`func`: string, num: string, err: Error))
    Decimal* = struct((d: GoArray[byte, 800], nd: int, dp: int, neg: bool, trunc: bool))
    LeftCheat* = struct((delta: int, cutoff: string))
    ExtFloat* = struct((mant: uint64, exp: int, neg: bool))
    FloatInfo* = struct((mantbits: uint, expbits: uint, bias: int))
    DecimalSlice* = struct((d: GoSlice[byte], nd: int, dp: int, neg: bool))

proc parseBool*(str: string): tuple[arg0: bool, arg1: Error] {.gofunc.}
proc formatBool*(b: bool): string {.gofunc.}
proc appendBool*(dst: GoSlice[byte], b: bool): GoSlice[byte] {.gofunc.}
proc equalIgnoreCase(s1: string, s2: string): bool {.gofunc.}
proc special(s: string): tuple[f: float64, ok: bool] {.gofunc.}
proc set(b: gcptr[Decimal], s: string): bool {.gofunc, gomethod.}
proc readFloat(s: string): tuple[mantissa: uint64, exp: int, neg: bool, trunc: bool, ok: bool] {.gofunc.}
proc floatBits(d: gcptr[Decimal], flt: gcptr[FloatInfo]): tuple[b: uint64, overflow: bool] {.gofunc, gomethod.}
proc atof64exact(mantissa: uint64, exp: int, neg: bool): tuple[f: float64, ok: bool] {.gofunc.}
proc atof32exact(mantissa: uint64, exp: int, neg: bool): tuple[f: float32, ok: bool] {.gofunc.}
proc atof32(s: string): tuple[f: float32, err: Error] {.gofunc.}
proc atof64(s: string): tuple[f: float64, err: Error] {.gofunc.}
proc parseFloat*(s: string, bitSize: int): tuple[arg0: float64, arg1: Error] {.gofunc.}
proc error*(e: gcptr[NumError]): string {.gofunc, gomethod.}
proc syntaxError(fn: string, str: string): gcptr[NumError] {.gofunc.}
proc rangeError(fn: string, str: string): gcptr[NumError] {.gofunc.}
proc parseUint*(s: string, base: int, bitSize: int): tuple[arg0: uint64, arg1: Error] {.gofunc.}
proc parseInt*(s: string, base: int, bitSize: int): tuple[i: int64, err: Error] {.gofunc.}
proc atoi*(s: string): tuple[arg0: int, arg1: Error] {.gofunc.}
proc toString*(a: gcptr[Decimal]): string {.gofunc, gomethod.}
proc digitZero(dst: GoSlice[byte]): int {.gofunc.}
proc trim(a: gcptr[Decimal]): void {.gofunc.}
proc assign*(a: gcptr[Decimal], v: uint64): void {.gofunc, gomethod.}
proc rightShift(a: gcptr[Decimal], k: uint): void {.gofunc.}
proc prefixIsLessThan(b: GoSlice[byte], s: string): bool {.gofunc.}
proc leftShift(a: gcptr[Decimal], k: uint): void {.gofunc.}
proc shift*(a: gcptr[Decimal], k: int): void {.gofunc, gomethod.}
proc shouldRoundUp(a: gcptr[Decimal], nd: int): bool {.gofunc.}
proc round*(a: gcptr[Decimal], nd: int): void {.gofunc, gomethod.}
proc roundDown*(a: gcptr[Decimal], nd: int): void {.gofunc, gomethod.}
proc roundUp*(a: gcptr[Decimal], nd: int): void {.gofunc, gomethod.}
proc roundedInteger*(a: gcptr[Decimal]): uint64 {.gofunc, gomethod.}
proc floatBits(f: gcptr[ExtFloat], flt: gcptr[FloatInfo]): tuple[bits: uint64, overflow: bool] {.gofunc, gomethod.}
proc assignComputeBounds*(f: gcptr[ExtFloat], mant: uint64, exp: int, neg: bool, flt: gcptr[FloatInfo]): tuple[lower: ExtFloat, upper: ExtFloat] {.gofunc, gomethod.}
proc normalize*(f: gcptr[ExtFloat]): uint {.gofunc, gomethod.}
proc multiply*(f: gcptr[ExtFloat], g: ExtFloat): void {.gofunc, gomethod.}
proc assignDecimal*(f: gcptr[ExtFloat], mantissa: uint64, exp10: int, neg: bool, trunc: bool, flt: gcptr[FloatInfo]): bool {.gofunc, gomethod.}
proc frexp10(f: gcptr[ExtFloat]): tuple[exp10: int, index: int] {.gofunc, gomethod.}
proc frexp10Many(a: gcptr[ExtFloat], b: gcptr[ExtFloat], c: gcptr[ExtFloat]): int {.gofunc.}
proc fixedDecimal*(f: gcptr[ExtFloat], d: gcptr[DecimalSlice], n: int): bool {.gofunc, gomethod.}
proc adjustLastDigitFixed(d: gcptr[DecimalSlice], num: uint64, den: uint64, shiftInternal: uint, Ã®µ: uint64): bool {.gofunc.}
proc shortestDecimal*(f: gcptr[ExtFloat], d: gcptr[DecimalSlice], lower: gcptr[ExtFloat], upper: gcptr[ExtFloat]): bool {.gofunc, gomethod.}
proc adjustLastDigit(d: gcptr[DecimalSlice], currentDiff: uint64, targetDiff: uint64, maxDiff: uint64, ulpDecimal: uint64, ulpBinary: uint64): bool {.gofunc.}
proc formatFloat*(f: float64, fmt: byte, prec: int, bitSize: int): string {.gofunc.}
proc appendFloat*(dst: GoSlice[byte], f: float64, fmt: byte, prec: int, bitSize: int): GoSlice[byte] {.gofunc.}
proc genericFtoa(dst: GoSlice[byte], val: float64, fmt: byte, prec: int, bitSize: int): GoSlice[byte] {.gofunc.}
proc bigFtoa(dst: GoSlice[byte], prec: int, fmt: byte, neg: bool, mant: uint64, exp: int, flt: gcptr[FloatInfo]): GoSlice[byte] {.gofunc.}
proc formatDigits(dst: GoSlice[byte], shortest: bool, neg: bool, digs: DecimalSlice, prec: int, fmt: byte): GoSlice[byte] {.gofunc.}
proc roundShortest(d: gcptr[Decimal], mant: uint64, exp: int, flt: gcptr[FloatInfo]): void {.gofunc.}
proc fmtE(dst: GoSlice[byte], neg: bool, d: DecimalSlice, prec: int, fmt: byte): GoSlice[byte] {.gofunc.}
proc fmtF(dst: GoSlice[byte], neg: bool, d: DecimalSlice, prec: int): GoSlice[byte] {.gofunc.}
proc fmtB(dst: GoSlice[byte], neg: bool, mant: uint64, exp: int, flt: gcptr[FloatInfo]): GoSlice[byte] {.gofunc.}
proc min(a: int, b: int): int {.gofunc.}
proc max(a: int, b: int): int {.gofunc.}
proc formatUint*(i: uint64, base: int): string {.gofunc.}
proc formatInt*(i: int64, base: int): string {.gofunc.}
proc itoa*(i: int): string {.gofunc.}
proc appendInt*(dst: GoSlice[byte], i: int64, base: int): GoSlice[byte] {.gofunc.}
proc appendUint*(dst: GoSlice[byte], i: uint64, base: int): GoSlice[byte] {.gofunc.}
proc formatBits(dst: GoSlice[byte], u: uint64, base: int, neg: bool, appendunderscore: bool): tuple[d: GoSlice[byte], s: string] {.gofunc.}
proc quoteWith(s: string, quoteInternal: byte, ASCIIonly: bool, graphicOnly: bool): string {.gofunc.}
proc quoteRuneWith(r: Rune, quoteInternal: byte, ASCIIonly: bool, graphicOnly: bool): string {.gofunc.}
proc appendQuotedWith(buf: GoSlice[byte], s: string, quoteInternal: byte, ASCIIonly: bool, graphicOnly: bool): GoSlice[byte] {.gofunc.}
proc appendQuotedRuneWith(buf: GoSlice[byte], r: Rune, quoteInternal: byte, ASCIIonly: bool, graphicOnly: bool): GoSlice[byte] {.gofunc.}
proc appendEscapedRune(buf: GoSlice[byte], r: Rune, width: int, quoteInternal: byte, ASCIIonly: bool, graphicOnly: bool): GoSlice[byte] {.gofunc.}
proc quote*(s: string): string {.gofunc.}
proc appendQuote*(dst: GoSlice[byte], s: string): GoSlice[byte] {.gofunc.}
proc quoteToASCII*(s: string): string {.gofunc.}
proc appendQuoteToASCII*(dst: GoSlice[byte], s: string): GoSlice[byte] {.gofunc.}
proc quoteToGraphic*(s: string): string {.gofunc.}
proc appendQuoteToGraphic*(dst: GoSlice[byte], s: string): GoSlice[byte] {.gofunc.}
proc quoteRune*(r: Rune): string {.gofunc.}
proc appendQuoteRune*(dst: GoSlice[byte], r: Rune): GoSlice[byte] {.gofunc.}
proc quoteRuneToASCII*(r: Rune): string {.gofunc.}
proc appendQuoteRuneToASCII*(dst: GoSlice[byte], r: Rune): GoSlice[byte] {.gofunc.}
proc quoteRuneToGraphic*(r: Rune): string {.gofunc.}
proc appendQuoteRuneToGraphic*(dst: GoSlice[byte], r: Rune): GoSlice[byte] {.gofunc.}
proc canBackquote*(s: string): bool {.gofunc.}
proc unhex(b: byte): tuple[v: Rune, ok: bool] {.gofunc.}
proc unquoteChar*(s: string, quoteInternal: byte): tuple[value: Rune, multibyte: bool, tail: string, err: Error] {.gofunc.}
proc unquote*(s: string): tuple[arg0: string, arg1: Error] {.gofunc.}
proc contains(s: string, c: byte): bool {.gofunc.}
proc bsearch16(a: GoSlice[uint16], x: uint16): int {.gofunc.}
proc bsearch32(a: GoSlice[uint32], x: uint32): int {.gofunc.}
proc isPrint*(r: Rune): bool {.gofunc.}
proc isGraphic*(r: Rune): bool {.gofunc.}
proc isInGraphicList(r: Rune): bool {.gofunc.}
var optimize = true
var powtab = [int(1), int(3), int(6), int(9), int(13), int(16), int(19), int(23), int(26)].make(GoSlice[int])
var float64pow10 = [float64(1), float64(10), float64(100), float64(1000), float64(10000), float64(100000), float64(1000000), float64(10000000), float64(100000000), float64(1000000000), float64(10000000000), float64(100000000000), float64(1000000000000), float64(10000000000000), float64(100000000000000), float64(1000000000000000), float64(10000000000000000), float64(100000000000000000), float64(1000000000000000000), float64(1000000000000000000 * 10), float64(1e20), float64(1e21), float64(1e22)].make(GoSlice[float64])
var float32pow10 = [float32(1), float32(10), float32(100), float32(1000), float32(10000), float32(100000), float32(1000000), float32(10000000), float32(100000000), float32(1000000000), float32(10000000000)].make(GoSlice[float32])
var errRange* = errors.new("value out of range")
var errSyntax* = errors.new("invalid syntax")
var leftcheats = [LeftCheat(make((0, ""), LeftCheat)), LeftCheat(make((1, "5"), LeftCheat)), LeftCheat(make((1, "25"), LeftCheat)), LeftCheat(make((1, "125"), LeftCheat)), LeftCheat(make((2, "625"), LeftCheat)), LeftCheat(make((2, "3125"), LeftCheat)), LeftCheat(make((2, "15625"), LeftCheat)), LeftCheat(make((3, "78125"), LeftCheat)), LeftCheat(make((3, "390625"), LeftCheat)), LeftCheat(make((3, "1953125"), LeftCheat)), LeftCheat(make((4, "9765625"), LeftCheat)), LeftCheat(make((4, "48828125"), LeftCheat)), LeftCheat(make((4, "244140625"), LeftCheat)), LeftCheat(make((4, "1220703125"), LeftCheat)), LeftCheat(make((5, "6103515625"), LeftCheat)), LeftCheat(make((5, "30517578125"), LeftCheat)), LeftCheat(make((5, "152587890625"), LeftCheat)), LeftCheat(make((6, "762939453125"), LeftCheat)), LeftCheat(make((6, "3814697265625"), LeftCheat)), LeftCheat(make((6, "19073486328125"), LeftCheat)), LeftCheat(make((7, "95367431640625"), LeftCheat)), LeftCheat(make((7, "476837158203125"), LeftCheat)), LeftCheat(make((7, "2384185791015625"), LeftCheat)), LeftCheat(make((7, "11920928955078125"), LeftCheat)), LeftCheat(make((8, "59604644775390625"), LeftCheat)), LeftCheat(make((8, "298023223876953125"), LeftCheat)), LeftCheat(make((8, "1490116119384765625"), LeftCheat)), LeftCheat(make((9, "7450580596923828125"), LeftCheat)), LeftCheat(make((9, "37252902984619140625"), LeftCheat)), LeftCheat(make((9, "186264514923095703125"), LeftCheat)), LeftCheat(make((10, "931322574615478515625"), LeftCheat)), LeftCheat(make((10, "4656612873077392578125"), LeftCheat)), LeftCheat(make((10, "23283064365386962890625"), LeftCheat)), LeftCheat(make((10, "116415321826934814453125"), LeftCheat)), LeftCheat(make((11, "582076609134674072265625"), LeftCheat)), LeftCheat(make((11, "2910383045673370361328125"), LeftCheat)), LeftCheat(make((11, "14551915228366851806640625"), LeftCheat)), LeftCheat(make((12, "72759576141834259033203125"), LeftCheat)), LeftCheat(make((12, "363797880709171295166015625"), LeftCheat)), LeftCheat(make((12, "1818989403545856475830078125"), LeftCheat)), LeftCheat(make((13, "9094947017729282379150390625"), LeftCheat)), LeftCheat(make((13, "45474735088646411895751953125"), LeftCheat)), LeftCheat(make((13, "227373675443232059478759765625"), LeftCheat)), LeftCheat(make((13, "1136868377216160297393798828125"), LeftCheat)), LeftCheat(make((14, "5684341886080801486968994140625"), LeftCheat)), LeftCheat(make((14, "28421709430404007434844970703125"), LeftCheat)), LeftCheat(make((14, "142108547152020037174224853515625"), LeftCheat)), LeftCheat(make((15, "710542735760100185871124267578125"), LeftCheat)), LeftCheat(make((15, "3552713678800500929355621337890625"), LeftCheat)), LeftCheat(make((15, "17763568394002504646778106689453125"), LeftCheat)), LeftCheat(make((16, "88817841970012523233890533447265625"), LeftCheat)), LeftCheat(make((16, "444089209850062616169452667236328125"), LeftCheat)), LeftCheat(make((16, "2220446049250313080847263336181640625"), LeftCheat)), LeftCheat(make((16, "11102230246251565404236316680908203125"), LeftCheat)), LeftCheat(make((17, "55511151231257827021181583404541015625"), LeftCheat)), LeftCheat(make((17, "277555756156289135105907917022705078125"), LeftCheat)), LeftCheat(make((17, "1387778780781445675529539585113525390625"), LeftCheat)), LeftCheat(make((18, "6938893903907228377647697925567626953125"), LeftCheat)), LeftCheat(make((18, "34694469519536141888238489627838134765625"), LeftCheat)), LeftCheat(make((18, "173472347597680709441192448139190673828125"), LeftCheat)), LeftCheat(make((19, "867361737988403547205962240695953369140625"), LeftCheat))].make(GoSlice[LeftCheat])
var smallPowersOfTen = [ExtFloat(make(((1 shl 63), -63, false), ExtFloat)), ExtFloat(make(((0xa shl 60), -60, false), ExtFloat)), ExtFloat(make(((0x64 shl 57), -57, false), ExtFloat)), ExtFloat(make(((0x3e8 shl 54), -54, false), ExtFloat)), ExtFloat(make(((0x2710 shl 50), -50, false), ExtFloat)), ExtFloat(make(((0x186a0 shl 47), -47, false), ExtFloat)), ExtFloat(make(((0xf4240 shl 44), -44, false), ExtFloat)), ExtFloat(make(((0x989680 shl 40), -40, false), ExtFloat))].make(GoAutoArray[ExtFloat])
var powersOfTen = [ExtFloat(make((0xfa8fd5a0081c0288, -1220, false), ExtFloat)), ExtFloat(make((0xbaaee17fa23ebf76, -1193, false), ExtFloat)), ExtFloat(make((0x8b16fb203055ac76, -1166, false), ExtFloat)), ExtFloat(make((0xcf42894a5dce35ea, -1140, false), ExtFloat)), ExtFloat(make((0x9a6bb0aa55653b2d, -1113, false), ExtFloat)), ExtFloat(make((0xe61acf033d1a45df, -1087, false), ExtFloat)), ExtFloat(make((0xab70fe17c79ac6ca, -1060, false), ExtFloat)), ExtFloat(make((0xff77b1fcbebcdc4f, -1034, false), ExtFloat)), ExtFloat(make((0xbe5691ef416bd60c, -1007, false), ExtFloat)), ExtFloat(make((0x8dd01fad907ffc3c, -980, false), ExtFloat)), ExtFloat(make((0xd3515c2831559a83, -954, false), ExtFloat)), ExtFloat(make((0x9d71ac8fada6c9b5, -927, false), ExtFloat)), ExtFloat(make((0xea9c227723ee8bcb, -901, false), ExtFloat)), ExtFloat(make((0xaecc49914078536d, -874, false), ExtFloat)), ExtFloat(make((0x823c12795db6ce57, -847, false), ExtFloat)), ExtFloat(make((0xc21094364dfb5637, -821, false), ExtFloat)), ExtFloat(make((0x9096ea6f3848984f, -794, false), ExtFloat)), ExtFloat(make((0xd77485cb25823ac7, -768, false), ExtFloat)), ExtFloat(make((0xa086cfcd97bf97f4, -741, false), ExtFloat)), ExtFloat(make((0xef340a98172aace5, -715, false), ExtFloat)), ExtFloat(make((0xb23867fb2a35b28e, -688, false), ExtFloat)), ExtFloat(make((0x84c8d4dfd2c63f3b, -661, false), ExtFloat)), ExtFloat(make((0xc5dd44271ad3cdba, -635, false), ExtFloat)), ExtFloat(make((0x936b9fcebb25c996, -608, false), ExtFloat)), ExtFloat(make((0xdbac6c247d62a584, -582, false), ExtFloat)), ExtFloat(make((0xa3ab66580d5fdaf6, -555, false), ExtFloat)), ExtFloat(make((0xf3e2f893dec3f126, -529, false), ExtFloat)), ExtFloat(make((0xb5b5ada8aaff80b8, -502, false), ExtFloat)), ExtFloat(make((0x87625f056c7c4a8b, -475, false), ExtFloat)), ExtFloat(make((0xc9bcff6034c13053, -449, false), ExtFloat)), ExtFloat(make((0x964e858c91ba2655, -422, false), ExtFloat)), ExtFloat(make((0xdff9772470297ebd, -396, false), ExtFloat)), ExtFloat(make((0xa6dfbd9fb8e5b88f, -369, false), ExtFloat)), ExtFloat(make((0xf8a95fcf88747d94, -343, false), ExtFloat)), ExtFloat(make((0xb94470938fa89bcf, -316, false), ExtFloat)), ExtFloat(make((0x8a08f0f8bf0f156b, -289, false), ExtFloat)), ExtFloat(make((0xcdb02555653131b6, -263, false), ExtFloat)), ExtFloat(make((0x993fe2c6d07b7fac, -236, false), ExtFloat)), ExtFloat(make((0xe45c10c42a2b3b06, -210, false), ExtFloat)), ExtFloat(make((0xaa242499697392d3, -183, false), ExtFloat)), ExtFloat(make((0xfd87b5f28300ca0e, -157, false), ExtFloat)), ExtFloat(make((0xbce5086492111aeb, -130, false), ExtFloat)), ExtFloat(make((0x8cbccc096f5088cc, -103, false), ExtFloat)), ExtFloat(make((0xd1b71758e219652c, -77, false), ExtFloat)), ExtFloat(make((0x9c40000000000000, -50, false), ExtFloat)), ExtFloat(make((0xe8d4a51000000000, -24, false), ExtFloat)), ExtFloat(make((0xad78ebc5ac620000, 3, false), ExtFloat)), ExtFloat(make((0x813f3978f8940984, 30, false), ExtFloat)), ExtFloat(make((0xc097ce7bc90715b3, 56, false), ExtFloat)), ExtFloat(make((0x8f7e32ce7bea5c70, 83, false), ExtFloat)), ExtFloat(make((0xd5d238a4abe98068, 109, false), ExtFloat)), ExtFloat(make((0x9f4f2726179a2245, 136, false), ExtFloat)), ExtFloat(make((0xed63a231d4c4fb27, 162, false), ExtFloat)), ExtFloat(make((0xb0de65388cc8ada8, 189, false), ExtFloat)), ExtFloat(make((0x83c7088e1aab65db, 216, false), ExtFloat)), ExtFloat(make((0xc45d1df942711d9a, 242, false), ExtFloat)), ExtFloat(make((0x924d692ca61be758, 269, false), ExtFloat)), ExtFloat(make((0xda01ee641a708dea, 295, false), ExtFloat)), ExtFloat(make((0xa26da3999aef774a, 322, false), ExtFloat)), ExtFloat(make((0xf209787bb47d6b85, 348, false), ExtFloat)), ExtFloat(make((0xb454e4a179dd1877, 375, false), ExtFloat)), ExtFloat(make((0x865b86925b9bc5c2, 402, false), ExtFloat)), ExtFloat(make((0xc83553c5c8965d3d, 428, false), ExtFloat)), ExtFloat(make((0x952ab45cfa97a0b3, 455, false), ExtFloat)), ExtFloat(make((0xde469fbd99a05fe3, 481, false), ExtFloat)), ExtFloat(make((0xa59bc234db398c25, 508, false), ExtFloat)), ExtFloat(make((0xf6c69a72a3989f5c, 534, false), ExtFloat)), ExtFloat(make((0xb7dcbf5354e9bece, 561, false), ExtFloat)), ExtFloat(make((0x88fcf317f22241e2, 588, false), ExtFloat)), ExtFloat(make((0xcc20ce9bd35c78a5, 614, false), ExtFloat)), ExtFloat(make((0x98165af37b2153df, 641, false), ExtFloat)), ExtFloat(make((0xe2a0b5dc971f303a, 667, false), ExtFloat)), ExtFloat(make((0xa8d9d1535ce3b396, 694, false), ExtFloat)), ExtFloat(make((0xfb9b7cd9a4a7443c, 720, false), ExtFloat)), ExtFloat(make((0xbb764c4ca7a44410, 747, false), ExtFloat)), ExtFloat(make((0x8bab8eefb6409c1a, 774, false), ExtFloat)), ExtFloat(make((0xd01fef10a657842c, 800, false), ExtFloat)), ExtFloat(make((0x9b10a4e5e9913129, 827, false), ExtFloat)), ExtFloat(make((0xe7109bfba19c0c9d, 853, false), ExtFloat)), ExtFloat(make((0xac2820d9623bf429, 880, false), ExtFloat)), ExtFloat(make((0x80444b5e7aa7cf85, 907, false), ExtFloat)), ExtFloat(make((0xbf21e44003acdd2d, 933, false), ExtFloat)), ExtFloat(make((0x8e679c2f5e44ff8f, 960, false), ExtFloat)), ExtFloat(make((0xd433179d9c8cb841, 986, false), ExtFloat)), ExtFloat(make((0x9e19db92b4e31ba9, 1013, false), ExtFloat)), ExtFloat(make((0xeb96bf6ebadf77d9, 1039, false), ExtFloat)), ExtFloat(make((0xaf87023b9bf0ee6b, 1066, false), ExtFloat))].make(GoAutoArray[ExtFloat])
var uint64pow10 = [uint64(1), uint64(10), uint64(100), uint64(1000), uint64(10000), uint64(100000), uint64(1000000), uint64(10000000), uint64(100000000), uint64(1000000000), uint64(10000000000), uint64(100000000000), uint64(1000000000000), uint64(10000000000000), uint64(100000000000000), uint64(1000000000000000), uint64(10000000000000000), uint64(100000000000000000), uint64(1000000000000000000), uint64(1000000000000000000 * 10)].make(GoAutoArray[uint64])
var float32info = make((23, 8, -127), FloatInfo)
var float64info = make((52, 11, -1023), FloatInfo)
var isPrint16 = [uint16(0x0020), uint16(0x007e), uint16(0x00a1), uint16(0x0377), uint16(0x037a), uint16(0x037f), uint16(0x0384), uint16(0x0556), uint16(0x0559), uint16(0x058a), uint16(0x058d), uint16(0x05c7), uint16(0x05d0), uint16(0x05ea), uint16(0x05f0), uint16(0x05f4), uint16(0x0606), uint16(0x061b), uint16(0x061e), uint16(0x070d), uint16(0x0710), uint16(0x074a), uint16(0x074d), uint16(0x07b1), uint16(0x07c0), uint16(0x07fa), uint16(0x0800), uint16(0x082d), uint16(0x0830), uint16(0x085b), uint16(0x085e), uint16(0x085e), uint16(0x08a0), uint16(0x08bd), uint16(0x08d4), uint16(0x098c), uint16(0x098f), uint16(0x0990), uint16(0x0993), uint16(0x09b2), uint16(0x09b6), uint16(0x09b9), uint16(0x09bc), uint16(0x09c4), uint16(0x09c7), uint16(0x09c8), uint16(0x09cb), uint16(0x09ce), uint16(0x09d7), uint16(0x09d7), uint16(0x09dc), uint16(0x09e3), uint16(0x09e6), uint16(0x09fb), uint16(0x0a01), uint16(0x0a0a), uint16(0x0a0f), uint16(0x0a10), uint16(0x0a13), uint16(0x0a39), uint16(0x0a3c), uint16(0x0a42), uint16(0x0a47), uint16(0x0a48), uint16(0x0a4b), uint16(0x0a4d), uint16(0x0a51), uint16(0x0a51), uint16(0x0a59), uint16(0x0a5e), uint16(0x0a66), uint16(0x0a75), uint16(0x0a81), uint16(0x0ab9), uint16(0x0abc), uint16(0x0acd), uint16(0x0ad0), uint16(0x0ad0), uint16(0x0ae0), uint16(0x0ae3), uint16(0x0ae6), uint16(0x0af1), uint16(0x0af9), uint16(0x0af9), uint16(0x0b01), uint16(0x0b0c), uint16(0x0b0f), uint16(0x0b10), uint16(0x0b13), uint16(0x0b39), uint16(0x0b3c), uint16(0x0b44), uint16(0x0b47), uint16(0x0b48), uint16(0x0b4b), uint16(0x0b4d), uint16(0x0b56), uint16(0x0b57), uint16(0x0b5c), uint16(0x0b63), uint16(0x0b66), uint16(0x0b77), uint16(0x0b82), uint16(0x0b8a), uint16(0x0b8e), uint16(0x0b95), uint16(0x0b99), uint16(0x0b9f), uint16(0x0ba3), uint16(0x0ba4), uint16(0x0ba8), uint16(0x0baa), uint16(0x0bae), uint16(0x0bb9), uint16(0x0bbe), uint16(0x0bc2), uint16(0x0bc6), uint16(0x0bcd), uint16(0x0bd0), uint16(0x0bd0), uint16(0x0bd7), uint16(0x0bd7), uint16(0x0be6), uint16(0x0bfa), uint16(0x0c00), uint16(0x0c39), uint16(0x0c3d), uint16(0x0c4d), uint16(0x0c55), uint16(0x0c5a), uint16(0x0c60), uint16(0x0c63), uint16(0x0c66), uint16(0x0c6f), uint16(0x0c78), uint16(0x0cb9), uint16(0x0cbc), uint16(0x0ccd), uint16(0x0cd5), uint16(0x0cd6), uint16(0x0cde), uint16(0x0ce3), uint16(0x0ce6), uint16(0x0cf2), uint16(0x0d01), uint16(0x0d3a), uint16(0x0d3d), uint16(0x0d4f), uint16(0x0d54), uint16(0x0d63), uint16(0x0d66), uint16(0x0d7f), uint16(0x0d82), uint16(0x0d96), uint16(0x0d9a), uint16(0x0dbd), uint16(0x0dc0), uint16(0x0dc6), uint16(0x0dca), uint16(0x0dca), uint16(0x0dcf), uint16(0x0ddf), uint16(0x0de6), uint16(0x0def), uint16(0x0df2), uint16(0x0df4), uint16(0x0e01), uint16(0x0e3a), uint16(0x0e3f), uint16(0x0e5b), uint16(0x0e81), uint16(0x0e84), uint16(0x0e87), uint16(0x0e8a), uint16(0x0e8d), uint16(0x0e8d), uint16(0x0e94), uint16(0x0ea7), uint16(0x0eaa), uint16(0x0ebd), uint16(0x0ec0), uint16(0x0ecd), uint16(0x0ed0), uint16(0x0ed9), uint16(0x0edc), uint16(0x0edf), uint16(0x0f00), uint16(0x0f6c), uint16(0x0f71), uint16(0x0fda), uint16(0x1000), uint16(0x10c7), uint16(0x10cd), uint16(0x10cd), uint16(0x10d0), uint16(0x124d), uint16(0x1250), uint16(0x125d), uint16(0x1260), uint16(0x128d), uint16(0x1290), uint16(0x12b5), uint16(0x12b8), uint16(0x12c5), uint16(0x12c8), uint16(0x1315), uint16(0x1318), uint16(0x135a), uint16(0x135d), uint16(0x137c), uint16(0x1380), uint16(0x1399), uint16(0x13a0), uint16(0x13f5), uint16(0x13f8), uint16(0x13fd), uint16(0x1400), uint16(0x169c), uint16(0x16a0), uint16(0x16f8), uint16(0x1700), uint16(0x1714), uint16(0x1720), uint16(0x1736), uint16(0x1740), uint16(0x1753), uint16(0x1760), uint16(0x1773), uint16(0x1780), uint16(0x17dd), uint16(0x17e0), uint16(0x17e9), uint16(0x17f0), uint16(0x17f9), uint16(0x1800), uint16(0x180d), uint16(0x1810), uint16(0x1819), uint16(0x1820), uint16(0x1877), uint16(0x1880), uint16(0x18aa), uint16(0x18b0), uint16(0x18f5), uint16(0x1900), uint16(0x192b), uint16(0x1930), uint16(0x193b), uint16(0x1940), uint16(0x1940), uint16(0x1944), uint16(0x196d), uint16(0x1970), uint16(0x1974), uint16(0x1980), uint16(0x19ab), uint16(0x19b0), uint16(0x19c9), uint16(0x19d0), uint16(0x19da), uint16(0x19de), uint16(0x1a1b), uint16(0x1a1e), uint16(0x1a7c), uint16(0x1a7f), uint16(0x1a89), uint16(0x1a90), uint16(0x1a99), uint16(0x1aa0), uint16(0x1aad), uint16(0x1ab0), uint16(0x1abe), uint16(0x1b00), uint16(0x1b4b), uint16(0x1b50), uint16(0x1b7c), uint16(0x1b80), uint16(0x1bf3), uint16(0x1bfc), uint16(0x1c37), uint16(0x1c3b), uint16(0x1c49), uint16(0x1c4d), uint16(0x1c88), uint16(0x1cc0), uint16(0x1cc7), uint16(0x1cd0), uint16(0x1cf9), uint16(0x1d00), uint16(0x1df5), uint16(0x1dfb), uint16(0x1f15), uint16(0x1f18), uint16(0x1f1d), uint16(0x1f20), uint16(0x1f45), uint16(0x1f48), uint16(0x1f4d), uint16(0x1f50), uint16(0x1f7d), uint16(0x1f80), uint16(0x1fd3), uint16(0x1fd6), uint16(0x1fef), uint16(0x1ff2), uint16(0x1ffe), uint16(0x2010), uint16(0x2027), uint16(0x2030), uint16(0x205e), uint16(0x2070), uint16(0x2071), uint16(0x2074), uint16(0x209c), uint16(0x20a0), uint16(0x20be), uint16(0x20d0), uint16(0x20f0), uint16(0x2100), uint16(0x218b), uint16(0x2190), uint16(0x2426), uint16(0x2440), uint16(0x244a), uint16(0x2460), uint16(0x2b73), uint16(0x2b76), uint16(0x2b95), uint16(0x2b98), uint16(0x2bb9), uint16(0x2bbd), uint16(0x2bd1), uint16(0x2bec), uint16(0x2bef), uint16(0x2c00), uint16(0x2cf3), uint16(0x2cf9), uint16(0x2d27), uint16(0x2d2d), uint16(0x2d2d), uint16(0x2d30), uint16(0x2d67), uint16(0x2d6f), uint16(0x2d70), uint16(0x2d7f), uint16(0x2d96), uint16(0x2da0), uint16(0x2e44), uint16(0x2e80), uint16(0x2ef3), uint16(0x2f00), uint16(0x2fd5), uint16(0x2ff0), uint16(0x2ffb), uint16(0x3001), uint16(0x3096), uint16(0x3099), uint16(0x30ff), uint16(0x3105), uint16(0x312d), uint16(0x3131), uint16(0x31ba), uint16(0x31c0), uint16(0x31e3), uint16(0x31f0), uint16(0x4db5), uint16(0x4dc0), uint16(0x9fd5), uint16(0xa000), uint16(0xa48c), uint16(0xa490), uint16(0xa4c6), uint16(0xa4d0), uint16(0xa62b), uint16(0xa640), uint16(0xa6f7), uint16(0xa700), uint16(0xa7b7), uint16(0xa7f7), uint16(0xa82b), uint16(0xa830), uint16(0xa839), uint16(0xa840), uint16(0xa877), uint16(0xa880), uint16(0xa8c5), uint16(0xa8ce), uint16(0xa8d9), uint16(0xa8e0), uint16(0xa8fd), uint16(0xa900), uint16(0xa953), uint16(0xa95f), uint16(0xa97c), uint16(0xa980), uint16(0xa9d9), uint16(0xa9de), uint16(0xaa36), uint16(0xaa40), uint16(0xaa4d), uint16(0xaa50), uint16(0xaa59), uint16(0xaa5c), uint16(0xaac2), uint16(0xaadb), uint16(0xaaf6), uint16(0xab01), uint16(0xab06), uint16(0xab09), uint16(0xab0e), uint16(0xab11), uint16(0xab16), uint16(0xab20), uint16(0xab65), uint16(0xab70), uint16(0xabed), uint16(0xabf0), uint16(0xabf9), uint16(0xac00), uint16(0xd7a3), uint16(0xd7b0), uint16(0xd7c6), uint16(0xd7cb), uint16(0xd7fb), uint16(0xf900), uint16(0xfa6d), uint16(0xfa70), uint16(0xfad9), uint16(0xfb00), uint16(0xfb06), uint16(0xfb13), uint16(0xfb17), uint16(0xfb1d), uint16(0xfbc1), uint16(0xfbd3), uint16(0xfd3f), uint16(0xfd50), uint16(0xfd8f), uint16(0xfd92), uint16(0xfdc7), uint16(0xfdf0), uint16(0xfdfd), uint16(0xfe00), uint16(0xfe19), uint16(0xfe20), uint16(0xfe6b), uint16(0xfe70), uint16(0xfefc), uint16(0xff01), uint16(0xffbe), uint16(0xffc2), uint16(0xffc7), uint16(0xffca), uint16(0xffcf), uint16(0xffd2), uint16(0xffd7), uint16(0xffda), uint16(0xffdc), uint16(0xffe0), uint16(0xffee), uint16(0xfffc), uint16(0xfffd)].make(GoSlice[uint16])
var isNotPrint16 = [uint16(0x00ad), uint16(0x038b), uint16(0x038d), uint16(0x03a2), uint16(0x0530), uint16(0x0560), uint16(0x0588), uint16(0x0590), uint16(0x06dd), uint16(0x083f), uint16(0x08b5), uint16(0x08e2), uint16(0x0984), uint16(0x09a9), uint16(0x09b1), uint16(0x09de), uint16(0x0a04), uint16(0x0a29), uint16(0x0a31), uint16(0x0a34), uint16(0x0a37), uint16(0x0a3d), uint16(0x0a5d), uint16(0x0a84), uint16(0x0a8e), uint16(0x0a92), uint16(0x0aa9), uint16(0x0ab1), uint16(0x0ab4), uint16(0x0ac6), uint16(0x0aca), uint16(0x0b04), uint16(0x0b29), uint16(0x0b31), uint16(0x0b34), uint16(0x0b5e), uint16(0x0b84), uint16(0x0b91), uint16(0x0b9b), uint16(0x0b9d), uint16(0x0bc9), uint16(0x0c04), uint16(0x0c0d), uint16(0x0c11), uint16(0x0c29), uint16(0x0c45), uint16(0x0c49), uint16(0x0c57), uint16(0x0c84), uint16(0x0c8d), uint16(0x0c91), uint16(0x0ca9), uint16(0x0cb4), uint16(0x0cc5), uint16(0x0cc9), uint16(0x0cdf), uint16(0x0cf0), uint16(0x0d04), uint16(0x0d0d), uint16(0x0d11), uint16(0x0d45), uint16(0x0d49), uint16(0x0d84), uint16(0x0db2), uint16(0x0dbc), uint16(0x0dd5), uint16(0x0dd7), uint16(0x0e83), uint16(0x0e89), uint16(0x0e98), uint16(0x0ea0), uint16(0x0ea4), uint16(0x0ea6), uint16(0x0eac), uint16(0x0eba), uint16(0x0ec5), uint16(0x0ec7), uint16(0x0f48), uint16(0x0f98), uint16(0x0fbd), uint16(0x0fcd), uint16(0x10c6), uint16(0x1249), uint16(0x1257), uint16(0x1259), uint16(0x1289), uint16(0x12b1), uint16(0x12bf), uint16(0x12c1), uint16(0x12d7), uint16(0x1311), uint16(0x1680), uint16(0x170d), uint16(0x176d), uint16(0x1771), uint16(0x191f), uint16(0x1a5f), uint16(0x1cf7), uint16(0x1f58), uint16(0x1f5a), uint16(0x1f5c), uint16(0x1f5e), uint16(0x1fb5), uint16(0x1fc5), uint16(0x1fdc), uint16(0x1ff5), uint16(0x208f), uint16(0x23ff), uint16(0x2bc9), uint16(0x2c2f), uint16(0x2c5f), uint16(0x2d26), uint16(0x2da7), uint16(0x2daf), uint16(0x2db7), uint16(0x2dbf), uint16(0x2dc7), uint16(0x2dcf), uint16(0x2dd7), uint16(0x2ddf), uint16(0x2e9a), uint16(0x3040), uint16(0x318f), uint16(0x321f), uint16(0x32ff), uint16(0xa7af), uint16(0xa9ce), uint16(0xa9ff), uint16(0xab27), uint16(0xab2f), uint16(0xfb37), uint16(0xfb3d), uint16(0xfb3f), uint16(0xfb42), uint16(0xfb45), uint16(0xfe53), uint16(0xfe67), uint16(0xfe75), uint16(0xffe7)].make(GoSlice[uint16])
var isPrint32 = [uint32(0x010000), uint32(0x01004d), uint32(0x010050), uint32(0x01005d), uint32(0x010080), uint32(0x0100fa), uint32(0x010100), uint32(0x010102), uint32(0x010107), uint32(0x010133), uint32(0x010137), uint32(0x01019b), uint32(0x0101a0), uint32(0x0101a0), uint32(0x0101d0), uint32(0x0101fd), uint32(0x010280), uint32(0x01029c), uint32(0x0102a0), uint32(0x0102d0), uint32(0x0102e0), uint32(0x0102fb), uint32(0x010300), uint32(0x010323), uint32(0x010330), uint32(0x01034a), uint32(0x010350), uint32(0x01037a), uint32(0x010380), uint32(0x0103c3), uint32(0x0103c8), uint32(0x0103d5), uint32(0x010400), uint32(0x01049d), uint32(0x0104a0), uint32(0x0104a9), uint32(0x0104b0), uint32(0x0104d3), uint32(0x0104d8), uint32(0x0104fb), uint32(0x010500), uint32(0x010527), uint32(0x010530), uint32(0x010563), uint32(0x01056f), uint32(0x01056f), uint32(0x010600), uint32(0x010736), uint32(0x010740), uint32(0x010755), uint32(0x010760), uint32(0x010767), uint32(0x010800), uint32(0x010805), uint32(0x010808), uint32(0x010838), uint32(0x01083c), uint32(0x01083c), uint32(0x01083f), uint32(0x01089e), uint32(0x0108a7), uint32(0x0108af), uint32(0x0108e0), uint32(0x0108f5), uint32(0x0108fb), uint32(0x01091b), uint32(0x01091f), uint32(0x010939), uint32(0x01093f), uint32(0x01093f), uint32(0x010980), uint32(0x0109b7), uint32(0x0109bc), uint32(0x0109cf), uint32(0x0109d2), uint32(0x010a06), uint32(0x010a0c), uint32(0x010a33), uint32(0x010a38), uint32(0x010a3a), uint32(0x010a3f), uint32(0x010a47), uint32(0x010a50), uint32(0x010a58), uint32(0x010a60), uint32(0x010a9f), uint32(0x010ac0), uint32(0x010ae6), uint32(0x010aeb), uint32(0x010af6), uint32(0x010b00), uint32(0x010b35), uint32(0x010b39), uint32(0x010b55), uint32(0x010b58), uint32(0x010b72), uint32(0x010b78), uint32(0x010b91), uint32(0x010b99), uint32(0x010b9c), uint32(0x010ba9), uint32(0x010baf), uint32(0x010c00), uint32(0x010c48), uint32(0x010c80), uint32(0x010cb2), uint32(0x010cc0), uint32(0x010cf2), uint32(0x010cfa), uint32(0x010cff), uint32(0x010e60), uint32(0x010e7e), uint32(0x011000), uint32(0x01104d), uint32(0x011052), uint32(0x01106f), uint32(0x01107f), uint32(0x0110c1), uint32(0x0110d0), uint32(0x0110e8), uint32(0x0110f0), uint32(0x0110f9), uint32(0x011100), uint32(0x011143), uint32(0x011150), uint32(0x011176), uint32(0x011180), uint32(0x0111cd), uint32(0x0111d0), uint32(0x0111f4), uint32(0x011200), uint32(0x01123e), uint32(0x011280), uint32(0x0112a9), uint32(0x0112b0), uint32(0x0112ea), uint32(0x0112f0), uint32(0x0112f9), uint32(0x011300), uint32(0x01130c), uint32(0x01130f), uint32(0x011310), uint32(0x011313), uint32(0x011339), uint32(0x01133c), uint32(0x011344), uint32(0x011347), uint32(0x011348), uint32(0x01134b), uint32(0x01134d), uint32(0x011350), uint32(0x011350), uint32(0x011357), uint32(0x011357), uint32(0x01135d), uint32(0x011363), uint32(0x011366), uint32(0x01136c), uint32(0x011370), uint32(0x011374), uint32(0x011400), uint32(0x01145d), uint32(0x011480), uint32(0x0114c7), uint32(0x0114d0), uint32(0x0114d9), uint32(0x011580), uint32(0x0115b5), uint32(0x0115b8), uint32(0x0115dd), uint32(0x011600), uint32(0x011644), uint32(0x011650), uint32(0x011659), uint32(0x011660), uint32(0x01166c), uint32(0x011680), uint32(0x0116b7), uint32(0x0116c0), uint32(0x0116c9), uint32(0x011700), uint32(0x011719), uint32(0x01171d), uint32(0x01172b), uint32(0x011730), uint32(0x01173f), uint32(0x0118a0), uint32(0x0118f2), uint32(0x0118ff), uint32(0x0118ff), uint32(0x011ac0), uint32(0x011af8), uint32(0x011c00), uint32(0x011c45), uint32(0x011c50), uint32(0x011c6c), uint32(0x011c70), uint32(0x011c8f), uint32(0x011c92), uint32(0x011cb6), uint32(0x012000), uint32(0x012399), uint32(0x012400), uint32(0x012474), uint32(0x012480), uint32(0x012543), uint32(0x013000), uint32(0x01342e), uint32(0x014400), uint32(0x014646), uint32(0x016800), uint32(0x016a38), uint32(0x016a40), uint32(0x016a69), uint32(0x016a6e), uint32(0x016a6f), uint32(0x016ad0), uint32(0x016aed), uint32(0x016af0), uint32(0x016af5), uint32(0x016b00), uint32(0x016b45), uint32(0x016b50), uint32(0x016b77), uint32(0x016b7d), uint32(0x016b8f), uint32(0x016f00), uint32(0x016f44), uint32(0x016f50), uint32(0x016f7e), uint32(0x016f8f), uint32(0x016f9f), uint32(0x016fe0), uint32(0x016fe0), uint32(0x017000), uint32(0x0187ec), uint32(0x018800), uint32(0x018af2), uint32(0x01b000), uint32(0x01b001), uint32(0x01bc00), uint32(0x01bc6a), uint32(0x01bc70), uint32(0x01bc7c), uint32(0x01bc80), uint32(0x01bc88), uint32(0x01bc90), uint32(0x01bc99), uint32(0x01bc9c), uint32(0x01bc9f), uint32(0x01d000), uint32(0x01d0f5), uint32(0x01d100), uint32(0x01d126), uint32(0x01d129), uint32(0x01d172), uint32(0x01d17b), uint32(0x01d1e8), uint32(0x01d200), uint32(0x01d245), uint32(0x01d300), uint32(0x01d356), uint32(0x01d360), uint32(0x01d371), uint32(0x01d400), uint32(0x01d49f), uint32(0x01d4a2), uint32(0x01d4a2), uint32(0x01d4a5), uint32(0x01d4a6), uint32(0x01d4a9), uint32(0x01d50a), uint32(0x01d50d), uint32(0x01d546), uint32(0x01d54a), uint32(0x01d6a5), uint32(0x01d6a8), uint32(0x01d7cb), uint32(0x01d7ce), uint32(0x01da8b), uint32(0x01da9b), uint32(0x01daaf), uint32(0x01e000), uint32(0x01e018), uint32(0x01e01b), uint32(0x01e02a), uint32(0x01e800), uint32(0x01e8c4), uint32(0x01e8c7), uint32(0x01e8d6), uint32(0x01e900), uint32(0x01e94a), uint32(0x01e950), uint32(0x01e959), uint32(0x01e95e), uint32(0x01e95f), uint32(0x01ee00), uint32(0x01ee24), uint32(0x01ee27), uint32(0x01ee3b), uint32(0x01ee42), uint32(0x01ee42), uint32(0x01ee47), uint32(0x01ee54), uint32(0x01ee57), uint32(0x01ee64), uint32(0x01ee67), uint32(0x01ee9b), uint32(0x01eea1), uint32(0x01eebb), uint32(0x01eef0), uint32(0x01eef1), uint32(0x01f000), uint32(0x01f02b), uint32(0x01f030), uint32(0x01f093), uint32(0x01f0a0), uint32(0x01f0ae), uint32(0x01f0b1), uint32(0x01f0f5), uint32(0x01f100), uint32(0x01f10c), uint32(0x01f110), uint32(0x01f16b), uint32(0x01f170), uint32(0x01f1ac), uint32(0x01f1e6), uint32(0x01f202), uint32(0x01f210), uint32(0x01f23b), uint32(0x01f240), uint32(0x01f248), uint32(0x01f250), uint32(0x01f251), uint32(0x01f300), uint32(0x01f6d2), uint32(0x01f6e0), uint32(0x01f6ec), uint32(0x01f6f0), uint32(0x01f6f6), uint32(0x01f700), uint32(0x01f773), uint32(0x01f780), uint32(0x01f7d4), uint32(0x01f800), uint32(0x01f80b), uint32(0x01f810), uint32(0x01f847), uint32(0x01f850), uint32(0x01f859), uint32(0x01f860), uint32(0x01f887), uint32(0x01f890), uint32(0x01f8ad), uint32(0x01f910), uint32(0x01f927), uint32(0x01f930), uint32(0x01f930), uint32(0x01f933), uint32(0x01f94b), uint32(0x01f950), uint32(0x01f95e), uint32(0x01f980), uint32(0x01f991), uint32(0x01f9c0), uint32(0x01f9c0), uint32(0x020000), uint32(0x02a6d6), uint32(0x02a700), uint32(0x02b734), uint32(0x02b740), uint32(0x02b81d), uint32(0x02b820), uint32(0x02cea1), uint32(0x02f800), uint32(0x02fa1d), uint32(0x0e0100), uint32(0x0e01ef)].make(GoSlice[uint32])
var isNotPrint32 = [uint16(0x000c), uint16(0x0027), uint16(0x003b), uint16(0x003e), uint16(0x018f), uint16(0x039e), uint16(0x0809), uint16(0x0836), uint16(0x0856), uint16(0x08f3), uint16(0x0a04), uint16(0x0a14), uint16(0x0a18), uint16(0x10bd), uint16(0x1135), uint16(0x11e0), uint16(0x1212), uint16(0x1287), uint16(0x1289), uint16(0x128e), uint16(0x129e), uint16(0x1304), uint16(0x1329), uint16(0x1331), uint16(0x1334), uint16(0x145a), uint16(0x145c), uint16(0x1c09), uint16(0x1c37), uint16(0x1ca8), uint16(0x246f), uint16(0x6a5f), uint16(0x6b5a), uint16(0x6b62), uint16(0xd455), uint16(0xd49d), uint16(0xd4ad), uint16(0xd4ba), uint16(0xd4bc), uint16(0xd4c4), uint16(0xd506), uint16(0xd515), uint16(0xd51d), uint16(0xd53a), uint16(0xd53f), uint16(0xd545), uint16(0xd551), uint16(0xdaa0), uint16(0xe007), uint16(0xe022), uint16(0xe025), uint16(0xee04), uint16(0xee20), uint16(0xee23), uint16(0xee28), uint16(0xee33), uint16(0xee38), uint16(0xee3a), uint16(0xee48), uint16(0xee4a), uint16(0xee4c), uint16(0xee50), uint16(0xee53), uint16(0xee58), uint16(0xee5a), uint16(0xee5c), uint16(0xee5e), uint16(0xee60), uint16(0xee63), uint16(0xee6b), uint16(0xee73), uint16(0xee78), uint16(0xee7d), uint16(0xee7f), uint16(0xee8a), uint16(0xeea4), uint16(0xeeaa), uint16(0xf0c0), uint16(0xf0d0), uint16(0xf12f), uint16(0xf91f), uint16(0xf93f)].make(GoSlice[uint16])
var isGraphicInternal = [uint16(0x00a0), uint16(0x1680), uint16(0x2000), uint16(0x2001), uint16(0x2002), uint16(0x2003), uint16(0x2004), uint16(0x2005), uint16(0x2006), uint16(0x2007), uint16(0x2008), uint16(0x2009), uint16(0x200a), uint16(0x202f), uint16(0x205f), uint16(0x3000)].make(GoSlice[uint16])
var shifts = {(1 shl 1): 1, (1 shl 2): 2, (1 shl 3): 3, (1 shl 4): 4, (1 shl 5): 5}.make(GoArray[uint, (len(digits) + 1)])


proc parseBool(str: string): tuple[arg0: bool, arg1: Error] =
  block:
    let condition = str
    if condition == "1" or condition == "t" or condition == "T" or condition == "true" or condition == "TRUE" or condition == "True":
      (result.arg0, result.arg1) = (true, null)
      return
    elif condition == "0" or condition == "f" or condition == "F" or condition == "false" or condition == "FALSE" or condition == "False":
      (result.arg0, result.arg1) = (false, null)
      return
  
  (result.arg0, result.arg1) = (false, syntaxError("ParseBool", str))
  return

proc formatBool(b: bool): string =
  if b:
    return "true"
  return "false"

proc appendBool(dst: GoSlice[byte], b: bool): GoSlice[byte] =
  if b:
    return append(dst, govarargs("true"))
  return append(dst, govarargs("false"))



proc equalIgnoreCase(s1: string, s2: string): bool =
  if (len(s1) != len(s2)):
    return false
  block loop0:
    var i = 0
    while (i < len(s1)):
      block loop0Continue:
        var c1 = s1[i]
        if ((runelit('A') <= c1) and (c1 <= runelit('Z'))):
          c1 += (runelit('a') - runelit('A'))
        var c2 = s2[i]
        if ((runelit('A') <= c2) and (c2 <= runelit('Z'))):
          c2 += (runelit('a') - runelit('A'))
        if (c1 != c2):
          return false
      i += 1
  return true

proc special(s: string): tuple[f: float64, ok: bool] =
  if (len(s) == 0):
    return
  block:
    let condition = s[0]
    if condition == runelit('+'):
      if (equalIgnoreCase(s, "+inf") or equalIgnoreCase(s, "+infinity")):
        (result.f, result.ok) = (math.inf(1), true)
        return
    elif condition == runelit('-'):
      if (equalIgnoreCase(s, "-inf") or equalIgnoreCase(s, "-infinity")):
        (result.f, result.ok) = (math.inf(-1), true)
        return
    elif condition == runelit('n') or condition == runelit('N'):
      if equalIgnoreCase(s, "nan"):
        (result.f, result.ok) = (math.naN(), true)
        return
    elif condition == runelit('i') or condition == runelit('I'):
      if (equalIgnoreCase(s, "inf") or equalIgnoreCase(s, "infinity")):
        (result.f, result.ok) = (math.inf(1), true)
        return
    else:
      return
  return

proc set(b: gcptr[Decimal], s: string): bool =
  var i = 0
  b.neg = false
  b.trunc = false
  if (i >= len(s)):
    return
  if true == (s[i] == runelit('+')):
    i += 1
  elif true == (s[i] == runelit('-')):
    b.neg = true
    i += 1
  
  var sawdot = false
  var sawdigits = false
  block loop0:
    while (i < len(s)):
      block loop0Continue:
        if true == (s[i] == runelit('.')):
          if sawdot:
            return
          sawdot = true
          b.dp = b.nd
          continue
        elif true == ((runelit('0') <= s[i]) and (s[i] <= runelit('9'))):
          sawdigits = true
          if ((s[i] == runelit('0')) and (b.nd == 0)):
            b.dp -= 1
            continue
          if (b.nd < len(b.d)):
            b.d[b.nd] = s[i]
            b.nd += 1
          elif (s[i] != runelit('0')):
            b.trunc = true
          continue
        
        break loop0
      i += 1
  if not sawdigits:
    return
  if not sawdot:
    b.dp = b.nd
  if ((i < len(s)) and (((s[i] == runelit('e')) or (s[i] == runelit('E'))))):
    i += 1
    if (i >= len(s)):
      return
    var esign = 1
    if (s[i] == runelit('+')):
      i += 1
    elif (s[i] == runelit('-')):
      i += 1
      esign = -1
    if (((i >= len(s)) or (s[i] < runelit('0'))) or (s[i] > runelit('9'))):
      return
    var e = 0
    block loop0:
      while (((i < len(s)) and (runelit('0') <= s[i])) and (s[i] <= runelit('9'))):
        block loop0Continue:
          if (e < 10000):
            e = (((e * 10) + convert(int, s[i])) - runelit('0'))
        i += 1
    b.dp += (e * esign)
  if (i != len(s)):
    return
  result = true
  return

proc readFloat(s: string): tuple[mantissa: uint64, exp: int, neg: bool, trunc: bool, ok: bool] =
  const uint64digits = 19
  var i = 0
  if (i >= len(s)):
    return
  if true == (s[i] == runelit('+')):
    i += 1
  elif true == (s[i] == runelit('-')):
    result.neg = true
    i += 1
  
  var sawdot = false
  var sawdigits = false
  var nd = 0
  var ndMant = 0
  var dp = 0
  block loop0:
    while (i < len(s)):
      block loop0Continue:
        block:
          var c = s[i]
          let condition = true
          if condition == (c == runelit('.')):
            if sawdot:
              return
            sawdot = true
            dp = nd
            continue
          elif condition == ((runelit('0') <= c) and (c <= runelit('9'))):
            sawdigits = true
            if ((c == runelit('0')) and (nd == 0)):
              dp -= 1
              continue
            nd += 1
            if (ndMant < uint64digits):
              result.mantissa *= 10
              result.mantissa += convert(uint64, (c - runelit('0')))
              ndMant += 1
            elif (s[i] != runelit('0')):
              result.trunc = true
            continue
        
        break loop0
      i += 1
  if not sawdigits:
    return
  if not sawdot:
    dp = nd
  if ((i < len(s)) and (((s[i] == runelit('e')) or (s[i] == runelit('E'))))):
    i += 1
    if (i >= len(s)):
      return
    var esign = 1
    if (s[i] == runelit('+')):
      i += 1
    elif (s[i] == runelit('-')):
      i += 1
      esign = -1
    if (((i >= len(s)) or (s[i] < runelit('0'))) or (s[i] > runelit('9'))):
      return
    var e = 0
    block loop0:
      while (((i < len(s)) and (runelit('0') <= s[i])) and (s[i] <= runelit('9'))):
        block loop0Continue:
          if (e < 10000):
            e = (((e * 10) + convert(int, s[i])) - runelit('0'))
        i += 1
    dp += (e * esign)
  if (i != len(s)):
    return
  if (result.mantissa != 0):
    result.exp = (dp - ndMant)
  result.ok = true
  return

proc floatBits(d: gcptr[Decimal], flt: gcptr[FloatInfo]): tuple[b: uint64, overflow: bool] =
  var exp: int
  var mant: uint64
  block outKw:
    discard
    
    block overflow:
      if (d.nd == 0):
        mant = 0
        exp = flt.bias
        break outKw
      if (d.dp > 310):
        break overflow
      if (d.dp < -330):
        mant = 0
        exp = flt.bias
        break outKw
      exp = 0
      while (d.dp > 0):
        var n: int
        if (d.dp >= len(powtab)):
          n = 27
        else:
          n = powtab[d.dp]
        d.shift(-n)
        exp += n
      while ((d.dp < 0) or ((d.dp == 0) and (d.d[0] < runelit('5')))):
        var n: int
        if (-d.dp >= len(powtab)):
          n = 27
        else:
          n = powtab[-d.dp]
        d.shift(n)
        exp -= n
      exp -= 1
      if (exp < (flt.bias + 1)):
        var n = ((flt.bias + 1) - exp)
        d.shift(-n)
        exp += n
      if ((exp - flt.bias) >= ((1 shl flt.expbits) - 1)):
        break overflow
      d.shift(convert(int, (1 + flt.mantbits)))
      mant = d.roundedInteger()
      if (mant == (2 shl flt.mantbits)):
        mant = mant shr (1)
        exp += 1
        if ((exp - flt.bias) >= ((1 shl flt.expbits) - 1)):
          break overflow
      if ((mant and ((1 shl flt.mantbits))) == 0):
        exp = flt.bias
      break outKw
    mant = 0
    exp = (((1 shl flt.expbits) - 1) + flt.bias)
    result.overflow = true
  var bits = (mant and (((convert(uint64, 1) shl flt.mantbits) - 1)))
  bits = bits or ((convert(uint64, (((exp - flt.bias)) and (((1 shl flt.expbits) - 1)))) shl flt.mantbits))
  if d.neg:
    bits = bits or (((1 shl flt.mantbits) shl flt.expbits))
  (result.b, result.overflow) = (bits, result.overflow)
  return

proc atof64exact(mantissa: uint64, exp: int, neg: bool): tuple[f: float64, ok: bool] =
  var exp = exp
  if ((mantissa shr float64info.mantbits) != 0):
    return
  result.f = float64(mantissa)
  if neg:
    result.f = -result.f
  if true == (exp == 0):
    (result.f, result.ok) = (result.f, true)
    return
  elif true == ((exp > 0) and (exp <= (15 + 22))):
    if (exp > 22):
      result.f *= float64pow10[(exp - 22)]
      exp = 22
    if ((result.f > 1000000000000000) or (result.f < -1000000000000000)):
      return
    (result.f, result.ok) = ((result.f * float64pow10[exp]), true)
    return
  elif true == ((exp < 0) and (exp >= -22)):
    (result.f, result.ok) = (`go/`(result.f, float64pow10[-exp]), true)
    return
  
  return

proc atof32exact(mantissa: uint64, exp: int, neg: bool): tuple[f: float32, ok: bool] =
  var exp = exp
  if ((mantissa shr float32info.mantbits) != 0):
    return
  result.f = float32(mantissa)
  if neg:
    result.f = -result.f
  if true == (exp == 0):
    (result.f, result.ok) = (result.f, true)
    return
  elif true == ((exp > 0) and (exp <= (7 + 10))):
    if (exp > 10):
      result.f *= float32pow10[(exp - 10)]
      exp = 10
    if ((result.f > 10000000) or (result.f < -10000000)):
      return
    (result.f, result.ok) = ((result.f * float32pow10[exp]), true)
    return
  elif true == ((exp < 0) and (exp >= -10)):
    (result.f, result.ok) = (`go/`(result.f, float32pow10[-exp]), true)
    return
  
  return

proc atof32(s: string): tuple[f: float32, err: Error] =
  if (var (val, ok) = special(s); ok):
    (result.f, result.err) = (float32(val), null)
    return
  if optimize:
    var (mantissa, exp, neg, trunc, ok) = readFloat(s)
    if ok:
      if not trunc:
        if (var (f, ok) = atof32exact(mantissa, exp, neg); ok):
          (result.f, result.err) = (f, null)
          return
      var ext = gcnew(ExtFloat)
      if (var ok = ext.assignDecimal(mantissa, exp, neg, trunc, gcaddr float32info); ok):
        var (b, ovf) = ext.floatBits(gcaddr float32info)
        result.f = math.float32frombits(convert(uint32, b))
        if ovf:
          result.err = rangeError(fnParseFloat, s)
        (result.f, result.err) = (result.f, result.err)
        return
  var d: Decimal
  if not d.set(s):
    (result.f, result.err) = (0, syntaxError(fnParseFloat, s))
    return
  var (b, ovf) = d.floatBits(gcaddr float32info)
  result.f = math.float32frombits(convert(uint32, b))
  if ovf:
    result.err = rangeError(fnParseFloat, s)
  (result.f, result.err) = (result.f, result.err)
  return

proc atof64(s: string): tuple[f: float64, err: Error] =
  if (var (val, ok) = special(s); ok):
    (result.f, result.err) = (val, null)
    return
  if optimize:
    var (mantissa, exp, neg, trunc, ok) = readFloat(s)
    if ok:
      if not trunc:
        if (var (f, ok) = atof64exact(mantissa, exp, neg); ok):
          (result.f, result.err) = (f, null)
          return
      var ext = gcnew(ExtFloat)
      if (var ok = ext.assignDecimal(mantissa, exp, neg, trunc, gcaddr float64info); ok):
        var (b, ovf) = ext.floatBits(gcaddr float64info)
        result.f = math.float64frombits(b)
        if ovf:
          result.err = rangeError(fnParseFloat, s)
        (result.f, result.err) = (result.f, result.err)
        return
  var d: Decimal
  if not d.set(s):
    (result.f, result.err) = (0, syntaxError(fnParseFloat, s))
    return
  var (b, ovf) = d.floatBits(gcaddr float64info)
  result.f = math.float64frombits(b)
  if ovf:
    result.err = rangeError(fnParseFloat, s)
  (result.f, result.err) = (result.f, result.err)
  return

proc parseFloat(s: string, bitSize: int): tuple[arg0: float64, arg1: Error] =
  if (bitSize == 32):
    var (f, err) = atof32(s)
    (result.arg0, result.arg1) = (float64(f), err)
    return
  (result.arg0, result.arg1) = atof64(s)
  return



proc error(e: gcptr[NumError]): string =
  return (((((("strconv." + e.`func`) + ": ") + "parsing ") + quote(e.num)) + ": ") + e.err.error())

proc syntaxError(fn: string, str: string): gcptr[NumError] =
  return convert(gcptr[NumError], make((fn, str, errSyntax), (ref NumError)))

proc rangeError(fn: string, str: string): gcptr[NumError] =
  return convert(gcptr[NumError], make((fn, str, errRange), (ref NumError)))

proc parseUint(s: string, base: int, bitSize: int): tuple[arg0: uint64, arg1: Error] =
  var (base,bitSize) = (base,bitSize)
  var n: uint64
  var err: Error
  var 
    cutoff: uint64
    maxVal: uint64
  if (bitSize == 0):
    bitSize = convert(int, intSize)
  var i = 0
  block Error:
    if true == (len(s) < 1):
      err = errSyntax
      break Error
    elif true == ((2 <= base) and (base <= 36)):
      discard
    
    elif true == (base == 0):
      if true == (((s[0] == runelit('0')) and (len(s) > 1)) and (((s[1] == runelit('x')) or (s[1] == runelit('X'))))):
        if (len(s) < 3):
          err = errSyntax
          break Error
        base = 16
        i = 2
      elif true == (s[0] == runelit('0')):
        base = 8
        i = 1
      else:
        base = 10
    else:
      err = errors.new(("invalid base " + itoa(base)))
      break Error
    block:
      let condition = base
      if condition == 10:
        cutoff = (`go/`(maxUint64, 10) + 1)
      elif condition == 16:
        cutoff = (`go/`(maxUint64, 16) + 1)
      else:
        cutoff = (`go/`(maxUint64, convert(uint64, base)) + 1)
    maxVal = ((1 shl convert(uint, bitSize)) - 1)
    block loop0:
      while (i < len(s)):
        block loop0Continue:
          var v: byte
          var d = s[i]
          if true == ((runelit('0') <= d) and (d <= runelit('9'))):
            v = (d - runelit('0'))
          elif true == ((runelit('a') <= d) and (d <= runelit('z'))):
            v = ((d - runelit('a')) + 10)
          elif true == ((runelit('A') <= d) and (d <= runelit('Z'))):
            v = ((d - runelit('A')) + 10)
          else:
            n = 0
            err = errSyntax
            break Error
          if (v >= convert(byte, base)):
            n = 0
            err = errSyntax
            break Error
          if (n >= cutoff):
            n = maxUint64
            err = errRange
            break Error
          n *= convert(uint64, base)
          var n1 = (n + convert(uint64, v))
          if ((n1 < n) or (n1 > maxVal)):
            n = maxUint64
            err = errRange
            break Error
          n = n1
        i += 1
    (result.arg0, result.arg1) = (n, null)
    return
  (result.arg0, result.arg1) = (n, convert(gcptr[NumError], make(("ParseUint", s, err), (ref NumError))))
  return

proc parseInt(s: string, base: int, bitSize: int): tuple[i: int64, err: Error] =
  var (s,bitSize) = (s,bitSize)
  const fnParseInt = "ParseInt"
  if (bitSize == 0):
    bitSize = convert(int, intSize)
  if (len(s) == 0):
    (result.i, result.err) = (0, syntaxError(fnParseInt, s))
    return
  var s0 = s
  var neg = false
  if (s[0] == runelit('+')):
    s = slice(s, low=1)
  elif (s[0] == runelit('-')):
    neg = true
    s = slice(s, low=1)
  var un: uint64
  (un, result.err) = parseUint(s, base, bitSize)
  if ((result.err != null) and (castInterface(result.err, to=gcptr[NumError]).err != errRange)):
    castInterface(result.err, to=gcptr[NumError]).`func` = fnParseInt
    castInterface(result.err, to=gcptr[NumError]).num = s0
    (result.i, result.err) = (0, result.err)
    return
  var cutoff = convert(uint64, (1 shl convert(uint, (bitSize - 1))))
  if (not neg and (un >= cutoff)):
    (result.i, result.err) = (convert(int64, (cutoff - 1)), rangeError(fnParseInt, s0))
    return
  if (neg and (un > cutoff)):
    (result.i, result.err) = (-convert(int64, cutoff), rangeError(fnParseInt, s0))
    return
  var n = convert(int64, un)
  if neg:
    n = -n
  (result.i, result.err) = (n, null)
  return

proc atoi(s: string): tuple[arg0: int, arg1: Error] =
  var (i64, err) = parseInt(s, 10, 0)
  (result.arg0, result.arg1) = (convert(int, i64), err)
  return



proc toString(a: gcptr[Decimal]): string =
  var n = (10 + a.nd)
  if (a.dp > 0):
    n += a.dp
  if (a.dp < 0):
    n += -a.dp
  var buf = make(GoSlice[byte], n)
  var w = 0
  if true == (a.nd == 0):
    return "0"
  elif true == (a.dp <= 0):
    buf[w] = runelit('0')
    w += 1
    buf[w] = runelit('.')
    w += 1
    w += digitZero(slice(buf, low=w, high=(w + -a.dp)))
    w += copy(slice(buf, low=w), slice(a.d, low=0, high=a.nd))
  elif true == (a.dp < a.nd):
    w += copy(slice(buf, low=w), slice(a.d, low=0, high=a.dp))
    buf[w] = runelit('.')
    w += 1
    w += copy(slice(buf, low=w), slice(a.d, low=a.dp, high=a.nd))
  else:
    w += copy(slice(buf, low=w), slice(a.d, low=0, high=a.nd))
    w += digitZero(slice(buf, low=w, high=((w + a.dp) - a.nd)))
  return convert(string, slice(buf, low=0, high=w))

proc digitZero(dst: GoSlice[byte]): int =
  for i in 0..<len(dst):
    dst[i] = runelit('0')
  return len(dst)

proc trim(a: gcptr[Decimal]): void =
  while ((a.nd > 0) and (a.d[(a.nd - 1)] == runelit('0'))):
    a.nd -= 1
  if (a.nd == 0):
    a.dp = 0

proc assign(a: gcptr[Decimal], v: uint64): void =
  var v = v
  var buf: GoArray[byte, 24]
  var n = 0
  while (v > 0):
    var v1 = `go/`(v, 10)
    v -= (10 * v1)
    buf[n] = convert(byte, (v + runelit('0')))
    n += 1
    v = v1
  a.nd = 0
  block loop0:
    n -= 1
    while (n >= 0):
      block loop0Continue:
        a.d[a.nd] = buf[n]
        a.nd += 1
      n -= 1
  a.dp = a.nd
  trim(a)

proc rightShift(a: gcptr[Decimal], k: uint): void =
  var r = 0
  var w = 0
  var n: uint
  block loop0:
    while ((n shr k) == 0):
      block loop0Continue:
        if (r >= a.nd):
          if (n == 0):
            a.nd = 0
            return
          while ((n shr k) == 0):
            n = (n * 10)
            r += 1
          break loop0
        var c = convert(uint, a.d[r])
        n = (((n * 10) + c) - runelit('0'))
      r += 1
  a.dp -= (r - 1)
  block loop0:
    while (r < a.nd):
      block loop0Continue:
        var c = convert(uint, a.d[r])
        var dig = (n shr k)
        n -= (dig shl k)
        a.d[w] = convert(byte, (dig + runelit('0')))
        w += 1
        n = (((n * 10) + c) - runelit('0'))
      r += 1
  while (n > 0):
    var dig = (n shr k)
    n -= (dig shl k)
    if (w < len(a.d)):
      a.d[w] = convert(byte, (dig + runelit('0')))
      w += 1
    elif (dig > 0):
      a.trunc = true
    n = (n * 10)
  a.nd = w
  trim(a)

proc prefixIsLessThan(b: GoSlice[byte], s: string): bool =
  block loop0:
    var i = 0
    while (i < len(s)):
      block loop0Continue:
        if (i >= len(b)):
          return true
        if (b[i] != s[i]):
          return (b[i] < s[i])
      i += 1
  return false

proc leftShift(a: gcptr[Decimal], k: uint): void =
  var delta = leftcheats[k].delta
  if prefixIsLessThan(slice(a.d, low=0, high=a.nd), leftcheats[k].cutoff):
    delta -= 1
  var r = a.nd
  var w = (a.nd + delta)
  var n: uint
  block loop0:
    r -= 1
    while (r >= 0):
      block loop0Continue:
        n += (((convert(uint, a.d[r]) - runelit('0'))) shl k)
        var quo = `go/`(n, 10)
        var rem = (n - (10 * quo))
        w -= 1
        if (w < len(a.d)):
          a.d[w] = convert(byte, (rem + runelit('0')))
        elif (rem != 0):
          a.trunc = true
        n = quo
      r -= 1
  while (n > 0):
    var quo = `go/`(n, 10)
    var rem = (n - (10 * quo))
    w -= 1
    if (w < len(a.d)):
      a.d[w] = convert(byte, (rem + runelit('0')))
    elif (rem != 0):
      a.trunc = true
    n = quo
  a.nd += delta
  if (a.nd >= len(a.d)):
    a.nd = len(a.d)
  a.dp += delta
  trim(a)

proc shift(a: gcptr[Decimal], k: int): void =
  var k = k
  if true == (a.nd == 0):
    discard
  
  elif true == (k > 0):
    while (k > maxShift):
      leftShift(a, maxShift)
      k -= maxShift
    leftShift(a, convert(uint, k))
  elif true == (k < 0):
    while (k < -maxShift):
      rightShift(a, maxShift)
      k += maxShift
    rightShift(a, convert(uint, -k))


proc shouldRoundUp(a: gcptr[Decimal], nd: int): bool =
  if ((nd < 0) or (nd >= a.nd)):
    return false
  if ((a.d[nd] == runelit('5')) and ((nd + 1) == a.nd)):
    if a.trunc:
      return true
    return ((nd > 0) and ((((a.d[(nd - 1)] - runelit('0'))) mod 2) != 0))
  return (a.d[nd] >= runelit('5'))

proc round(a: gcptr[Decimal], nd: int): void =
  if ((nd < 0) or (nd >= a.nd)):
    return
  if shouldRoundUp(a, nd):
    a.roundUp(nd)
  else:
    a.roundDown(nd)

proc roundDown(a: gcptr[Decimal], nd: int): void =
  if ((nd < 0) or (nd >= a.nd)):
    return
  a.nd = nd
  trim(a)

proc roundUp(a: gcptr[Decimal], nd: int): void =
  if ((nd < 0) or (nd >= a.nd)):
    return
  block loop0:
    var i = (nd - 1)
    while (i >= 0):
      block loop0Continue:
        var c = a.d[i]
        if (c < runelit('9')):
          a.d[i] += 1
          a.nd = (i + 1)
          return
      i -= 1
  a.d[0] = runelit('1')
  a.nd = 1
  a.dp += 1

proc roundedInteger(a: gcptr[Decimal]): uint64 =
  if (a.dp > 20):
    return 0xFFFFFFFFFFFFFFFF
  var i: int
  var n = convert(uint64, 0)
  block loop0:
    i = 0
    while ((i < a.dp) and (i < a.nd)):
      block loop0Continue:
        n = ((n * 10) + convert(uint64, (a.d[i] - runelit('0'))))
      i += 1
  block loop0:
    while (i < a.dp):
      block loop0Continue:
        n *= 10
      i += 1
  if shouldRoundUp(a, a.dp):
    n += 1
  return n





proc floatBits(f: gcptr[ExtFloat], flt: gcptr[FloatInfo]): tuple[bits: uint64, overflow: bool] =
  f.normalize()
  var exp = (f.exp + 63)
  if (exp < (flt.bias + 1)):
    var n = ((flt.bias + 1) - exp)
    f.mant = f.mant shr (convert(uint, n))
    exp += n
  var mant = (f.mant shr ((63 - flt.mantbits)))
  if ((f.mant and ((1 shl ((62 - flt.mantbits))))) != 0):
    mant += 1
  if (mant == (2 shl flt.mantbits)):
    mant = mant shr (1)
    exp += 1
  if ((exp - flt.bias) >= ((1 shl flt.expbits) - 1)):
    mant = 0
    exp = (((1 shl flt.expbits) - 1) + flt.bias)
    result.overflow = true
  elif ((mant and ((1 shl flt.mantbits))) == 0):
    exp = flt.bias
  result.bits = (mant and (((convert(uint64, 1) shl flt.mantbits) - 1)))
  result.bits = result.bits or ((convert(uint64, (((exp - flt.bias)) and (((1 shl flt.expbits) - 1)))) shl flt.mantbits))
  if f.neg:
    result.bits = result.bits or ((1 shl ((flt.mantbits + flt.expbits))))
  return

proc assignComputeBounds(f: gcptr[ExtFloat], mant: uint64, exp: int, neg: bool, flt: gcptr[FloatInfo]): tuple[lower: ExtFloat, upper: ExtFloat] =
  f.mant = mant
  f.exp = (exp - convert(int, flt.mantbits))
  f.neg = neg
  if ((f.exp <= 0) and (mant == (((mant shr convert(uint, -f.exp))) shl convert(uint, -f.exp)))):
    f.mant = f.mant shr (convert(uint, -f.exp))
    f.exp = 0
    (result.lower, result.upper) = (f[], f[])
    return
  var expBiased = (exp - flt.bias)
  result.upper = ExtFloat(mant: ((2 * f.mant) + 1), exp: (f.exp - 1), neg: f.neg)
  if ((mant != (1 shl flt.mantbits)) or (expBiased == 1)):
    result.lower = ExtFloat(mant: ((2 * f.mant) - 1), exp: (f.exp - 1), neg: f.neg)
  else:
    result.lower = ExtFloat(mant: ((4 * f.mant) - 1), exp: (f.exp - 2), neg: f.neg)
  return

proc normalize(f: gcptr[ExtFloat]): uint =
  var (mant, exp) = (f.mant, f.exp)
  if (mant == 0):
    return 0
  if ((mant shr ((64 - 32))) == 0):
    mant = mant shl (32)
    exp -= 32
  if ((mant shr ((64 - 16))) == 0):
    mant = mant shl (16)
    exp -= 16
  if ((mant shr ((64 - 8))) == 0):
    mant = mant shl (8)
    exp -= 8
  if ((mant shr ((64 - 4))) == 0):
    mant = mant shl (4)
    exp -= 4
  if ((mant shr ((64 - 2))) == 0):
    mant = mant shl (2)
    exp -= 2
  if ((mant shr ((64 - 1))) == 0):
    mant = mant shl (1)
    exp -= 1
  result = convert(uint, (f.exp - exp))
  (f.mant, f.exp) = (mant, exp)
  return

proc multiply(f: gcptr[ExtFloat], g: ExtFloat): void =
  var (fhi, flo) = ((f.mant shr 32), convert(uint64, convert(uint32, f.mant)))
  var (ghi, glo) = ((g.mant shr 32), convert(uint64, convert(uint32, g.mant)))
  var cross1 = (fhi * glo)
  var cross2 = (flo * ghi)
  f.mant = (((fhi * ghi) + ((cross1 shr 32))) + ((cross2 shr 32)))
  var rem = ((convert(uint64, convert(uint32, cross1)) + convert(uint64, convert(uint32, cross2))) + ((((flo * glo)) shr 32)))
  rem += ((1 shl 31))
  f.mant += ((rem shr 32))
  f.exp = ((f.exp + g.exp) + 64)

proc assignDecimal(f: gcptr[ExtFloat], mantissa: uint64, exp10: int, neg: bool, trunc: bool, flt: gcptr[FloatInfo]): bool =
  const uint64digits = 19
  const errorscale = 8
  var errors = 0
  if trunc:
    errors += `go/`(errorscale, 2)
  f.mant = mantissa
  f.exp = 0
  f.neg = neg
  var i = `go/`(((exp10 - firstPowerOfTen)), stepPowerOfTen)
  if ((exp10 < firstPowerOfTen) or (i >= len(powersOfTen))):
    return false
  var adjExp = (((exp10 - firstPowerOfTen)) mod stepPowerOfTen)
  if ((adjExp < uint64digits) and (mantissa < uint64pow10[(uint64digits - adjExp)])):
    f.mant *= uint64pow10[adjExp]
    f.normalize()
  else:
    f.normalize()
    f.multiply(smallPowersOfTen[adjExp])
    errors += `go/`(errorscale, 2)
  f.multiply(powersOfTen[i])
  if (errors > 0):
    errors += 1
  errors += `go/`(errorscale, 2)
  var shiftInternal = f.normalize()
  errors = errors shl (shiftInternal)
  var denormalExp = (flt.bias - 63)
  var extrabits: uint
  if (f.exp <= denormalExp):
    extrabits = (((63 - flt.mantbits) + 1) + convert(uint, (denormalExp - f.exp)))
  else:
    extrabits = (63 - flt.mantbits)
  var halfway = (convert(uint64, 1) shl ((extrabits - 1)))
  var mant_extra = (f.mant and (((1 shl extrabits) - 1)))
  if (((convert(int64, halfway) - convert(int64, errors)) < convert(int64, mant_extra)) and (convert(int64, mant_extra) < (convert(int64, halfway) + convert(int64, errors)))):
    return false
  return true

proc frexp10(f: gcptr[ExtFloat]): tuple[exp10: int, index: int] =
  const expMin = -60
  const expMax = -32
  var approxExp10 = `go/`((((`go/`(((expMin + expMax)), 2) - f.exp)) * 28), 93)
  var i = `go/`(((approxExp10 - firstPowerOfTen)), stepPowerOfTen)
  while true:
    var exp = ((f.exp + powersOfTen[i].exp) + 64)
    if true == (exp < expMin):
      i += 1
    elif true == (exp > expMax):
      i -= 1
    else:
      break
  f.multiply(powersOfTen[i])
  (result.exp10, result.index) = (-((firstPowerOfTen + (i * stepPowerOfTen))), i)
  return

proc frexp10Many(a: gcptr[ExtFloat], b: gcptr[ExtFloat], c: gcptr[ExtFloat]): int =
  var i: type((c.frexp10())[1])
  (result, i) = c.frexp10()
  a.multiply(powersOfTen[i])
  b.multiply(powersOfTen[i])
  return

proc fixedDecimal(f: gcptr[ExtFloat], d: gcptr[DecimalSlice], n: int): bool =
  if (f.mant == 0):
    d.nd = 0
    d.dp = 0
    d.neg = f.neg
    return true
  if (n == 0):
    panic("strconv: internal error: extFloat.FixedDecimal called with n == 0")
  f.normalize()
  var (exp10, unused) = f.frexp10()
  var shiftInternal = convert(uint, -f.exp)
  var integer = convert(uint32, (f.mant shr shiftInternal))
  var fraction = (f.mant - ((convert(uint64, integer) shl shiftInternal)))
  var Ã®µ = convert(uint64, 1)
  var needed = n
  var integerDigits = 0
  var pow10 = convert(uint64, 1)
  block loop0:
    var (i, pow) = (0, convert(uint64, 1))
    while (i < 20):
      block loop0Continue:
        if (pow > convert(uint64, integer)):
          integerDigits = i
          break loop0
        pow *= 10
      i += 1
  var rest = integer
  if (integerDigits > needed):
    pow10 = uint64pow10[(integerDigits - needed)]
    integer = `go/`(integer, convert(uint32, pow10))
    rest -= (integer * convert(uint32, pow10))
  else:
    rest = 0
  var buf: GoArray[byte, 32]
  var pos = len(buf)
  block loop0:
    var v = integer
    while (v > 0):
      var v1 = `go/`(v, 10)
      v -= (10 * v1)
      pos -= 1
      buf[pos] = convert(byte, (v + runelit('0')))
      v = v1
  block loop0:
    var i = pos
    while (i < len(buf)):
      block loop0Continue:
        d.d[(i - pos)] = buf[i]
      i += 1
  var nd = (len(buf) - pos)
  d.nd = nd
  d.dp = (integerDigits + exp10)
  needed -= nd
  if (needed > 0):
    if ((rest != 0) or (pow10 != 1)):
      panic("strconv: internal error, rest != 0 but needed > 0")
    while (needed > 0):
      fraction *= 10
      Ã®µ *= 10
      if ((2 * Ã®µ) > (1 shl shiftInternal)):
        return false
      var digit = (fraction shr shiftInternal)
      d.d[nd] = convert(byte, (digit + runelit('0')))
      fraction -= (digit shl shiftInternal)
      nd += 1
      needed -= 1
    d.nd = nd
  var ok = adjustLastDigitFixed(d, ((convert(uint64, rest) shl shiftInternal) or fraction), pow10, shiftInternal, Ã®µ)
  if not ok:
    return false
  block loop0:
    var i = (d.nd - 1)
    while (i >= 0):
      block loop0Continue:
        if (d.d[i] != runelit('0')):
          d.nd = (i + 1)
          break loop0
      i -= 1
  return true

proc adjustLastDigitFixed(d: gcptr[DecimalSlice], num: uint64, den: uint64, shiftInternal: uint, Ã®µ: uint64): bool =
  if (num > (den shl shiftInternal)):
    panic("strconv: num > den<<shift in adjustLastDigitFixed")
  if ((2 * Ã®µ) > (den shl shiftInternal)):
    panic("strconv: Îµ > (den<<shift)/2")
  if ((2 * ((num + Ã®µ))) < (den shl shiftInternal)):
    return true
  if ((2 * ((num - Ã®µ))) > (den shl shiftInternal)):
    var i = (d.nd - 1)
    block loop0:
      while (i >= 0):
        block loop0Continue:
          if (d.d[i] == runelit('9')):
            d.nd -= 1
          else:
            break loop0
        i -= 1
    if (i < 0):
      d.d[0] = runelit('1')
      d.nd = 1
      d.dp += 1
    else:
      d.d[i] += 1
    return true
  return false

proc shortestDecimal(f: gcptr[ExtFloat], d: gcptr[DecimalSlice], lower: gcptr[ExtFloat], upper: gcptr[ExtFloat]): bool =
  if (f.mant == 0):
    d.nd = 0
    d.dp = 0
    d.neg = f.neg
    return true
  if (((f.exp == 0) and (lower[] == f[])) and (lower[] == upper[])):
    var buf: GoArray[byte, 24]
    var n = (len(buf) - 1)
    block loop0:
      var v = f.mant
      while (v > 0):
        var v1 = `go/`(v, 10)
        v -= (10 * v1)
        buf[n] = convert(byte, (v + runelit('0')))
        n -= 1
        v = v1
    var nd = ((len(buf) - n) - 1)
    block loop0:
      var i = 0
      while (i < nd):
        block loop0Continue:
          d.d[i] = buf[((n + 1) + i)]
        i += 1
    (d.nd, d.dp) = (nd, nd)
    while ((d.nd > 0) and (d.d[(d.nd - 1)] == runelit('0'))):
      d.nd -= 1
    if (d.nd == 0):
      d.dp = 0
    d.neg = f.neg
    return true
  upper.normalize()
  if (f.exp > upper.exp):
    f.mant = f.mant shl (convert(uint, (f.exp - upper.exp)))
    f.exp = upper.exp
  if (lower.exp > upper.exp):
    lower.mant = lower.mant shl (convert(uint, (lower.exp - upper.exp)))
    lower.exp = upper.exp
  var exp10 = frexp10Many(lower, f, upper)
  upper.mant += 1
  lower.mant -= 1
  var shiftInternal = convert(uint, -upper.exp)
  var integer = convert(uint32, (upper.mant shr shiftInternal))
  var fraction = (upper.mant - ((convert(uint64, integer) shl shiftInternal)))
  var allowance = (upper.mant - lower.mant)
  var targetDiff = (upper.mant - f.mant)
  var integerDigits: int
  block loop0:
    var (i, pow) = (0, convert(uint64, 1))
    while (i < 20):
      block loop0Continue:
        if (pow > convert(uint64, integer)):
          integerDigits = i
          break loop0
        pow *= 10
      i += 1
  block loop0:
    var i = 0
    while (i < integerDigits):
      block loop0Continue:
        var pow = uint64pow10[((integerDigits - i) - 1)]
        var digit = `go/`(integer, convert(uint32, pow))
        d.d[i] = convert(byte, (digit + runelit('0')))
        integer -= (digit * convert(uint32, pow))
        if (var currentDiff = ((convert(uint64, integer) shl shiftInternal) + fraction); (currentDiff < allowance)):
          d.nd = (i + 1)
          d.dp = (integerDigits + exp10)
          d.neg = f.neg
          return adjustLastDigit(d, currentDiff, targetDiff, allowance, (pow shl shiftInternal), 2)
      i += 1
  d.nd = integerDigits
  d.dp = (d.nd + exp10)
  d.neg = f.neg
  var digit: int
  var multiplier = convert(uint64, 1)
  while true:
    fraction *= 10
    multiplier *= 10
    digit = convert(int, (fraction shr shiftInternal))
    d.d[d.nd] = convert(byte, (digit + runelit('0')))
    d.nd += 1
    fraction -= (convert(uint64, digit) shl shiftInternal)
    if (fraction < (allowance * multiplier)):
      return adjustLastDigit(d, fraction, (targetDiff * multiplier), (allowance * multiplier), (1 shl shiftInternal), (multiplier * 2))

proc adjustLastDigit(d: gcptr[DecimalSlice], currentDiff: uint64, targetDiff: uint64, maxDiff: uint64, ulpDecimal: uint64, ulpBinary: uint64): bool =
  var currentDiff = currentDiff
  if (ulpDecimal < (2 * ulpBinary)):
    return false
  while (((currentDiff + `go/`(ulpDecimal, 2)) + ulpBinary) < targetDiff):
    d.d[(d.nd - 1)] -= 1
    currentDiff += ulpDecimal
  if ((currentDiff + ulpDecimal) <= ((targetDiff + `go/`(ulpDecimal, 2)) + ulpBinary)):
    return false
  if ((currentDiff < ulpBinary) or (currentDiff > (maxDiff - ulpBinary))):
    return false
  if ((d.nd == 1) and (d.d[0] == runelit('0'))):
    d.nd = 0
    d.dp = 0
  return true



proc formatFloat(f: float64, fmt: byte, prec: int, bitSize: int): string =
  return convert(string, genericFtoa(make(GoSlice[byte], 0, max((prec + 4), 24)), f, fmt, prec, bitSize))

proc appendFloat(dst: GoSlice[byte], f: float64, fmt: byte, prec: int, bitSize: int): GoSlice[byte] =
  return genericFtoa(dst, f, fmt, prec, bitSize)

proc genericFtoa(dst: GoSlice[byte], val: float64, fmt: byte, prec: int, bitSize: int): GoSlice[byte] =
  var prec = prec
  var bits: uint64
  var flt: gcptr[FloatInfo]
  block:
    let condition = bitSize
    if condition == 32:
      bits = convert(uint64, math.float32bits(float32(val)))
      flt = gcaddr float32info
    elif condition == 64:
      bits = math.float64bits(val)
      flt = gcaddr float64info
    else:
      panic("strconv: illegal AppendFloat/FormatFloat bitSize")
  var neg = ((bits shr ((flt.expbits + flt.mantbits))) != 0)
  var exp = (convert(int, (bits shr flt.mantbits)) and (((1 shl flt.expbits) - 1)))
  var mant = (bits and (((convert(uint64, 1) shl flt.mantbits) - 1)))
  block:
    let condition = exp
    if condition == ((1 shl flt.expbits) - 1):
      var s: string
      if true == (mant != 0):
        s = "NaN"
      elif true == neg:
        s = "-Inf"
      else:
        s = "+Inf"
      return append(dst, govarargs(s))
    elif condition == 0:
      exp += 1
    else:
      mant = mant or ((convert(uint64, 1) shl flt.mantbits))
  exp += flt.bias
  if (fmt == runelit('b')):
    return fmtB(dst, neg, mant, exp, flt)
  if not optimize:
    return bigFtoa(dst, prec, fmt, neg, mant, exp, flt)
  var digs: DecimalSlice
  var ok = false
  var shortest = (prec < 0)
  if shortest:
    var f = gcnew(ExtFloat)
    var (lower, upper) = f.assignComputeBounds(mant, exp, neg, flt)
    var buf: GoArray[byte, 32]
    digs.d = slice(buf)
    ok = f.shortestDecimal(gcaddr digs, gcaddr lower, gcaddr upper)
    if not ok:
      return bigFtoa(dst, prec, fmt, neg, mant, exp, flt)
    block:
      let condition = fmt
      if condition == runelit('e') or condition == runelit('E'):
        prec = max((digs.nd - 1), 0)
      elif condition == runelit('f'):
        prec = max((digs.nd - digs.dp), 0)
      elif condition == runelit('g') or condition == runelit('G'):
        prec = digs.nd
  
  elif (fmt != runelit('f')):
    var digits = prec
    block:
      let condition = fmt
      if condition == runelit('e') or condition == runelit('E'):
        digits += 1
      elif condition == runelit('g') or condition == runelit('G'):
        if (prec == 0):
          prec = 1
        digits = prec
    
    if (digits <= 15):
      var buf: GoArray[byte, 24]
      digs.d = slice(buf)
      var f = make((mant, (exp - convert(int, flt.mantbits)), neg), ExtFloat)
      ok = f.fixedDecimal(gcaddr digs, digits)
  if not ok:
    return bigFtoa(dst, prec, fmt, neg, mant, exp, flt)
  return formatDigits(dst, shortest, neg, digs, prec, fmt)

proc bigFtoa(dst: GoSlice[byte], prec: int, fmt: byte, neg: bool, mant: uint64, exp: int, flt: gcptr[FloatInfo]): GoSlice[byte] =
  var prec = prec
  var d = gcnew(Decimal)
  d.assign(mant)
  d.shift((exp - convert(int, flt.mantbits)))
  var digs: DecimalSlice
  var shortest = (prec < 0)
  if shortest:
    roundShortest(d, mant, exp, flt)
    digs = DecimalSlice(d: slice(d.d), nd: d.nd, dp: d.dp)
    block:
      let condition = fmt
      if condition == runelit('e') or condition == runelit('E'):
        prec = (digs.nd - 1)
      elif condition == runelit('f'):
        prec = max((digs.nd - digs.dp), 0)
      elif condition == runelit('g') or condition == runelit('G'):
        prec = digs.nd
  
  else:
    block:
      let condition = fmt
      if condition == runelit('e') or condition == runelit('E'):
        d.round((prec + 1))
      elif condition == runelit('f'):
        d.round((d.dp + prec))
      elif condition == runelit('g') or condition == runelit('G'):
        if (prec == 0):
          prec = 1
        d.round(prec)
    
    digs = DecimalSlice(d: slice(d.d), nd: d.nd, dp: d.dp)
  return formatDigits(dst, shortest, neg, digs, prec, fmt)

proc formatDigits(dst: GoSlice[byte], shortest: bool, neg: bool, digs: DecimalSlice, prec: int, fmt: byte): GoSlice[byte] =
  var prec = prec
  block:
    let condition = fmt
    if condition == runelit('e') or condition == runelit('E'):
      return fmtE(dst, neg, digs, prec, fmt)
    elif condition == runelit('f'):
      return fmtF(dst, neg, digs, prec)
    elif condition == runelit('g') or condition == runelit('G'):
      var eprec = prec
      if ((eprec > digs.nd) and (digs.nd >= digs.dp)):
        eprec = digs.nd
      if shortest:
        eprec = 6
      var exp = (digs.dp - 1)
      if ((exp < -4) or (exp >= eprec)):
        if (prec > digs.nd):
          prec = digs.nd
        return fmtE(dst, neg, digs, (prec - 1), ((fmt + runelit('e')) - runelit('g')))
      if (prec > digs.dp):
        prec = digs.nd
      return fmtF(dst, neg, digs, max((prec - digs.dp), 0))
  
  return append(dst, runelit('%'), fmt)

proc roundShortest(d: gcptr[Decimal], mant: uint64, exp: int, flt: gcptr[FloatInfo]): void =
  if (mant == 0):
    d.nd = 0
    return
  var minexp = (flt.bias + 1)
  if ((exp > minexp) and ((332 * ((d.dp - d.nd))) >= (100 * ((exp - convert(int, flt.mantbits)))))):
    return
  var upper = gcnew(Decimal)
  upper.assign(((mant * 2) + 1))
  upper.shift(((exp - convert(int, flt.mantbits)) - 1))
  var mantlo: uint64
  var explo: int
  if ((mant > (1 shl flt.mantbits)) or (exp == minexp)):
    mantlo = (mant - 1)
    explo = exp
  else:
    mantlo = ((mant * 2) - 1)
    explo = (exp - 1)
  var lower = gcnew(Decimal)
  lower.assign(((mantlo * 2) + 1))
  lower.shift(((explo - convert(int, flt.mantbits)) - 1))
  var inclusive = ((mant mod 2) == 0)
  block loop0:
    var i = 0
    while (i < d.nd):
      block loop0Continue:
        var l = convert(byte, runelit('0'))
        if (i < lower.nd):
          l = lower.d[i]
        var m = d.d[i]
        var u = convert(byte, runelit('0'))
        if (i < upper.nd):
          u = upper.d[i]
        var okdown = ((l != m) or (inclusive and ((i + 1) == lower.nd)))
        var okup = ((m != u) and (((inclusive or ((m + 1) < u)) or ((i + 1) < upper.nd))))
        if true == (okdown and okup):
          d.round((i + 1))
          return
        elif true == okdown:
          d.roundDown((i + 1))
          return
        elif true == okup:
          d.roundUp((i + 1))
          return
      
      i += 1

proc fmtE(dst: GoSlice[byte], neg: bool, d: DecimalSlice, prec: int, fmt: byte): GoSlice[byte] =
  var dst = dst
  if neg:
    dst = append(dst, runelit('-'))
  var ch = convert(byte, runelit('0'))
  if (d.nd != 0):
    ch = d.d[0]
  dst = append(dst, ch)
  if (prec > 0):
    dst = append(dst, runelit('.'))
    var i = 1
    var m = min(d.nd, (prec + 1))
    if (i < m):
      dst = append(dst, govarargs(slice(d.d, low=i, high=m)))
      i = m
    block loop0:
      while (i <= prec):
        block loop0Continue:
          dst = append(dst, runelit('0'))
        i += 1
  dst = append(dst, fmt)
  var exp = (d.dp - 1)
  if (d.nd == 0):
    exp = 0
  if (exp < 0):
    ch = runelit('-')
    exp = -exp
  else:
    ch = runelit('+')
  dst = append(dst, ch)
  if true == (exp < 10):
    dst = append(dst, runelit('0'), (convert(byte, exp) + runelit('0')))
  elif true == (exp < 100):
    dst = append(dst, (convert(byte, `go/`(exp, 10)) + runelit('0')), (convert(byte, (exp mod 10)) + runelit('0')))
  else:
    dst = append(dst, (convert(byte, `go/`(exp, 100)) + runelit('0')), ((convert(byte, `go/`(exp, 10)) mod 10) + runelit('0')), (convert(byte, (exp mod 10)) + runelit('0')))
  return dst

proc fmtF(dst: GoSlice[byte], neg: bool, d: DecimalSlice, prec: int): GoSlice[byte] =
  var dst = dst
  if neg:
    dst = append(dst, runelit('-'))
  if (d.dp > 0):
    var m = min(d.nd, d.dp)
    dst = append(dst, govarargs(slice(d.d, high=m)))
    block loop0:
      while (m < d.dp):
        block loop0Continue:
          dst = append(dst, runelit('0'))
        m += 1
  else:
    dst = append(dst, runelit('0'))
  if (prec > 0):
    dst = append(dst, runelit('.'))
    block loop0:
      var i = 0
      while (i < prec):
        block loop0Continue:
          var ch = convert(byte, runelit('0'))
          if (var j = (d.dp + i); ((0 <= j) and (j < d.nd))):
            ch = d.d[j]
          dst = append(dst, ch)
        i += 1
  return dst

proc fmtB(dst: GoSlice[byte], neg: bool, mant: uint64, exp: int, flt: gcptr[FloatInfo]): GoSlice[byte] =
  var (dst,exp) = (dst,exp)
  if neg:
    dst = append(dst, runelit('-'))
  dst = formatBits(dst, mant, 10, false, true)[0]
  dst = append(dst, runelit('p'))
  exp -= convert(int, flt.mantbits)
  if (exp >= 0):
    dst = append(dst, runelit('+'))
  dst = formatBits(dst, convert(uint64, exp), 10, (exp < 0), true)[0]
  return dst

proc min(a: int, b: int): int =
  if (a < b):
    return a
  return b

proc max(a: int, b: int): int =
  if (a > b):
    return a
  return b





proc formatUint(i: uint64, base: int): string =
  var (unused, s) = formatBits(null, i, base, false, false)
  return s

proc formatInt(i: int64, base: int): string =
  var (unused, s) = formatBits(null, convert(uint64, i), base, (i < 0), false)
  return s

proc itoa(i: int): string =
  return formatInt(convert(int64, i), 10)

proc appendInt(dst: GoSlice[byte], i: int64, base: int): GoSlice[byte] =
  var dst = dst
  dst = formatBits(dst, convert(uint64, i), base, (i < 0), true)[0]
  return dst

proc appendUint(dst: GoSlice[byte], i: uint64, base: int): GoSlice[byte] =
  var dst = dst
  dst = formatBits(dst, i, base, false, true)[0]
  return dst

proc formatBits(dst: GoSlice[byte], u: uint64, base: int, neg: bool, appendunderscore: bool): tuple[d: GoSlice[byte], s: string] =
  var u = u
  if ((base < 2) or (base > len(digits))):
    panic("strconv: illegal AppendInt/FormatInt base")
  var a: GoArray[byte, (64 + 1)]
  var i = len(a)
  if neg:
    u = -u
  if (base == 10):
    if ((not convert(uintptr, 0) shr 32) == 0):
      while (u > convert(uint64, not convert(uintptr, 0))):
        var q = `go/`(u, 1000000000)
        var us = convert(uintptr, (u - (q * 1000000000)))
        block loop1:
          var j = 9
          while (j > 0):
            block loop1Continue:
              i -= 1
              var qs = `go/`(us, 10)
              a[i] = convert(byte, ((us - (qs * 10)) + runelit('0')))
              us = qs
            j -= 1
        u = q
    var us = convert(uintptr, u)
    while (us >= 10):
      i -= 1
      var q = `go/`(us, 10)
      a[i] = convert(byte, ((us - (q * 10)) + runelit('0')))
      us = q
    i -= 1
    a[i] = convert(byte, (us + runelit('0')))
  elif (var s = shifts[base]; (s > 0)):
    var b = convert(uint64, base)
    var m = (convert(uintptr, b) - 1)
    while (u >= b):
      i -= 1
      a[i] = digits[(convert(uintptr, u) and m)]
      u = u shr (s)
    i -= 1
    a[i] = digits[convert(uintptr, u)]
  else:
    var b = convert(uint64, base)
    while (u >= b):
      i -= 1
      var q = `go/`(u, b)
      a[i] = digits[convert(uintptr, (u - (q * b)))]
      u = q
    i -= 1
    a[i] = digits[convert(uintptr, u)]
  if neg:
    i -= 1
    a[i] = runelit('-')
  if appendunderscore:
    result.d = append(dst, govarargs(slice(a, low=i)))
    return
  result.s = convert(string, slice(a, low=i))
  return



proc quoteWith(s: string, quoteInternal: byte, ASCIIonly: bool, graphicOnly: bool): string =
  return convert(string, appendQuotedWith(make(GoSlice[byte], 0, `go/`((3 * len(s)), 2)), s, quoteInternal, ASCIIonly, graphicOnly))

proc quoteRuneWith(r: Rune, quoteInternal: byte, ASCIIonly: bool, graphicOnly: bool): string =
  return convert(string, appendQuotedRuneWith(null, r, quoteInternal, ASCIIonly, graphicOnly))

proc appendQuotedWith(buf: GoSlice[byte], s: string, quoteInternal: byte, ASCIIonly: bool, graphicOnly: bool): GoSlice[byte] =
  var (buf,s) = (buf,s)
  buf = append(buf, quoteInternal)
  block loop0:
    var width = 0
    while (len(s) > 0):
      block loop0Continue:
        var r = convert(Rune, s[0])
        width = 1
        if (r >= utf8.runeSelf):
          (r, width) = utf8.decodeRuneInString(s)
        if ((width == 1) and (r == utf8.runeError)):
          buf = append(buf, govarargs(r"\x"))
          buf = append(buf, lowerhex[(s[0] shr 4)])
          buf = append(buf, lowerhex[(s[0] and 0xF)])
          break loop0Continue
        buf = appendEscapedRune(buf, r, width, quoteInternal, ASCIIonly, graphicOnly)
      s = slice(s, low=width)
  buf = append(buf, quoteInternal)
  return buf

proc appendQuotedRuneWith(buf: GoSlice[byte], r: Rune, quoteInternal: byte, ASCIIonly: bool, graphicOnly: bool): GoSlice[byte] =
  var (buf,r) = (buf,r)
  buf = append(buf, quoteInternal)
  if not utf8.validRune(r):
    r = utf8.runeError
  buf = appendEscapedRune(buf, r, utf8.runeLen(r), quoteInternal, ASCIIonly, graphicOnly)
  buf = append(buf, quoteInternal)
  return buf

proc appendEscapedRune(buf: GoSlice[byte], r: Rune, width: int, quoteInternal: byte, ASCIIonly: bool, graphicOnly: bool): GoSlice[byte] =
  var (buf,r) = (buf,r)
  var runeTmp: GoArray[byte, utf8.UTFMax]
  if ((r == convert(Rune, quoteInternal)) or (r == runelit('\\'))):
    buf = append(buf, runelit('\\'))
    buf = append(buf, convert(byte, r))
    return buf
  if ASCIIonly:
    if ((r < utf8.runeSelf) and isPrint(r)):
      buf = append(buf, convert(byte, r))
      return buf
  elif (isPrint(r) or (graphicOnly and isInGraphicList(r))):
    var n = utf8.encodeRune(slice(runeTmp), r)
    buf = append(buf, govarargs(slice(runeTmp, high=n)))
    return buf
  block:
    let condition = r
    if condition == runelit('\a'):
      buf = append(buf, govarargs(r"\a"))
    elif condition == runelit('\b'):
      buf = append(buf, govarargs(r"\b"))
    elif condition == runelit('\f'):
      buf = append(buf, govarargs(r"\f"))
    elif condition == runelit('\L'):
      buf = append(buf, govarargs(r"\n"))
    elif condition == runelit('\r'):
      buf = append(buf, govarargs(r"\r"))
    elif condition == runelit('\t'):
      buf = append(buf, govarargs(r"\t"))
    elif condition == runelit('\v'):
      buf = append(buf, govarargs(r"\v"))
    else:
      if true == (r < runelit(' ')):
        buf = append(buf, govarargs(r"\x"))
        buf = append(buf, lowerhex[(convert(byte, r) shr 4)])
        buf = append(buf, lowerhex[(convert(byte, r) and 0xF)])
      elif true == (r > utf8.maxRune):
        r = 0xFFFD
        buf = append(buf, govarargs(r"\u"))
        block loop0:
          var s = 12
          while (s >= 0):
            block loop0Continue:
              buf = append(buf, lowerhex[((r shr convert(uint, s)) and 0xF)])
            s -= 4
      elif true == (r < 0x10000):
        buf = append(buf, govarargs(r"\u"))
        block loop0:
          var s = 12
          while (s >= 0):
            block loop0Continue:
              buf = append(buf, lowerhex[((r shr convert(uint, s)) and 0xF)])
            s -= 4
      else:
        buf = append(buf, govarargs(r"\U"))
        block loop0:
          var s = 28
          while (s >= 0):
            block loop0Continue:
              buf = append(buf, lowerhex[((r shr convert(uint, s)) and 0xF)])
            s -= 4
  return buf

proc quote(s: string): string =
  return quoteWith(s, runelit('"'), false, false)

proc appendQuote(dst: GoSlice[byte], s: string): GoSlice[byte] =
  return appendQuotedWith(dst, s, runelit('"'), false, false)

proc quoteToASCII(s: string): string =
  return quoteWith(s, runelit('"'), true, false)

proc appendQuoteToASCII(dst: GoSlice[byte], s: string): GoSlice[byte] =
  return appendQuotedWith(dst, s, runelit('"'), true, false)

proc quoteToGraphic(s: string): string =
  return quoteWith(s, runelit('"'), false, true)

proc appendQuoteToGraphic(dst: GoSlice[byte], s: string): GoSlice[byte] =
  return appendQuotedWith(dst, s, runelit('"'), false, true)

proc quoteRune(r: Rune): string =
  return quoteRuneWith(r, runelit('\''), false, false)

proc appendQuoteRune(dst: GoSlice[byte], r: Rune): GoSlice[byte] =
  return appendQuotedRuneWith(dst, r, runelit('\''), false, false)

proc quoteRuneToASCII(r: Rune): string =
  return quoteRuneWith(r, runelit('\''), true, false)

proc appendQuoteRuneToASCII(dst: GoSlice[byte], r: Rune): GoSlice[byte] =
  return appendQuotedRuneWith(dst, r, runelit('\''), true, false)

proc quoteRuneToGraphic(r: Rune): string =
  return quoteRuneWith(r, runelit('\''), false, true)

proc appendQuoteRuneToGraphic(dst: GoSlice[byte], r: Rune): GoSlice[byte] =
  return appendQuotedRuneWith(dst, r, runelit('\''), false, true)

proc canBackquote(s: string): bool =
  var s = s
  while (len(s) > 0):
    var (r, wid) = utf8.decodeRuneInString(s)
    s = slice(s, low=wid)
    if (wid > 1):
      if (r == runelit(0xfeff)):
        return false
      continue
    if (r == utf8.runeError):
      return false
    if (((((r < runelit(' ')) and (r != runelit('\t')))) or (r == runelit('`'))) or (r == runelit(0x007F))):
      return false
  return true

proc unhex(b: byte): tuple[v: Rune, ok: bool] =
  var c = convert(Rune, b)
  if true == ((runelit('0') <= c) and (c <= runelit('9'))):
    (result.v, result.ok) = ((c - runelit('0')), true)
    return
  elif true == ((runelit('a') <= c) and (c <= runelit('f'))):
    (result.v, result.ok) = (((c - runelit('a')) + 10), true)
    return
  elif true == ((runelit('A') <= c) and (c <= runelit('F'))):
    (result.v, result.ok) = (((c - runelit('A')) + 10), true)
    return
  
  return

proc unquoteChar(s: string, quoteInternal: byte): tuple[value: Rune, multibyte: bool, tail: string, err: Error] =
  var s = s
  block:
    var c = s[0]
    let condition = true
    if true == ((c == quoteInternal) and (((quoteInternal == runelit('\'')) or (quoteInternal == runelit('"'))))):
      result.err = errSyntax
      return
    elif true == (c >= utf8.runeSelf):
      var (r, size) = utf8.decodeRuneInString(s)
      (result.value, result.multibyte, result.tail, result.err) = (r, true, slice(s, low=size), null)
      return
    elif true == (c != runelit('\\')):
      (result.value, result.multibyte, result.tail, result.err) = (convert(Rune, s[0]), false, slice(s, low=1), null)
      return
  
  if (len(s) <= 1):
    result.err = errSyntax
    return
  var c = s[1]
  s = slice(s, low=2)
  block:
    let condition = c
    if condition == runelit('a'):
      result.value = runelit('\a')
    elif condition == runelit('b'):
      result.value = runelit('\b')
    elif condition == runelit('f'):
      result.value = runelit('\f')
    elif condition == runelit('n'):
      result.value = runelit('\L')
    elif condition == runelit('r'):
      result.value = runelit('\r')
    elif condition == runelit('t'):
      result.value = runelit('\t')
    elif condition == runelit('v'):
      result.value = runelit('\v')
    elif condition == runelit('x') or condition == runelit('u') or condition == runelit('U'):
      var n = 0
      block:
        let condition = c
        if condition == runelit('x'):
          n = 2
        elif condition == runelit('u'):
          n = 4
        elif condition == runelit('U'):
          n = 8
      
      var v: Rune
      if (len(s) < n):
        result.err = errSyntax
        return
      block loop0:
        var j = 0
        while (j < n):
          block loop0Continue:
            var (x, ok) = unhex(s[j])
            if not ok:
              result.err = errSyntax
              return
            v = ((v shl 4) or x)
          j += 1
      s = slice(s, low=n)
      if (c == runelit('x')):
        result.value = v
        break
      if (v > utf8.maxRune):
        result.err = errSyntax
        return
      result.value = v
      result.multibyte = true
    elif condition == runelit('0') or condition == runelit('1') or condition == runelit('2') or condition == runelit('3') or condition == runelit('4') or condition == runelit('5') or condition == runelit('6') or condition == runelit('7'):
      var v = (convert(Rune, c) - runelit('0'))
      if (len(s) < 2):
        result.err = errSyntax
        return
      block loop0:
        var j = 0
        while (j < 2):
          block loop0Continue:
            var x = (convert(Rune, s[j]) - runelit('0'))
            if ((x < 0) or (x > 7)):
              result.err = errSyntax
              return
            v = (((v shl 3)) or x)
          j += 1
      s = slice(s, low=2)
      if (v > 255):
        result.err = errSyntax
        return
      result.value = v
    elif condition == runelit('\\'):
      result.value = runelit('\\')
    elif condition == runelit('\'') or condition == runelit('"'):
      if (c != quoteInternal):
        result.err = errSyntax
        return
      result.value = convert(Rune, c)
    else:
      result.err = errSyntax
      return
  result.tail = s
  return

proc unquote(s: string): tuple[arg0: string, arg1: Error] =
  var s = s
  var n = len(s)
  if (n < 2):
    (result.arg0, result.arg1) = ("", errSyntax)
    return
  var quoteInternal = s[0]
  if (quoteInternal != s[(n - 1)]):
    (result.arg0, result.arg1) = ("", errSyntax)
    return
  s = slice(s, low=1, high=(n - 1))
  if (quoteInternal == runelit('`')):
    if contains(s, runelit('`')):
      (result.arg0, result.arg1) = ("", errSyntax)
      return
    (result.arg0, result.arg1) = (s, null)
    return
  if ((quoteInternal != runelit('"')) and (quoteInternal != runelit('\''))):
    (result.arg0, result.arg1) = ("", errSyntax)
    return
  if contains(s, runelit('\L')):
    (result.arg0, result.arg1) = ("", errSyntax)
    return
  if (not contains(s, runelit('\\')) and not contains(s, quoteInternal)):
    block:
      let condition = quoteInternal
      if condition == runelit('"'):
        (result.arg0, result.arg1) = (s, null)
        return
      elif condition == runelit('\''):
        var (r, size) = utf8.decodeRuneInString(s)
        if ((size == len(s)) and (((r != utf8.runeError) or (size != 1)))):
          (result.arg0, result.arg1) = (s, null)
          return
  
  var runeTmp: GoArray[byte, utf8.UTFMax]
  var buf = make(GoSlice[byte], 0, `go/`((3 * len(s)), 2))
  while (len(s) > 0):
    var (c, multibyte, ss, err) = unquoteChar(s, quoteInternal)
    if (err != null):
      (result.arg0, result.arg1) = ("", err)
      return
    s = ss
    if ((c < utf8.runeSelf) or not multibyte):
      buf = append(buf, convert(byte, c))
    else:
      var n = utf8.encodeRune(slice(runeTmp), c)
      buf = append(buf, govarargs(slice(runeTmp, high=n)))
    if ((quoteInternal == runelit('\'')) and (len(s) != 0)):
      (result.arg0, result.arg1) = ("", errSyntax)
      return
  (result.arg0, result.arg1) = (convert(string, buf), null)
  return

proc contains(s: string, c: byte): bool =
  block loop0:
    var i = 0
    while (i < len(s)):
      block loop0Continue:
        if (s[i] == c):
          return true
      i += 1
  return false

proc bsearch16(a: GoSlice[uint16], x: uint16): int =
  var (i, j) = (0, len(a))
  while (i < j):
    var h = (i + `go/`(((j - i)), 2))
    if (a[h] < x):
      i = (h + 1)
    else:
      j = h
  return i

proc bsearch32(a: GoSlice[uint32], x: uint32): int =
  var (i, j) = (0, len(a))
  while (i < j):
    var h = (i + `go/`(((j - i)), 2))
    if (a[h] < x):
      i = (h + 1)
    else:
      j = h
  return i

proc isPrint(r: Rune): bool =
  var r = r
  if (r <= 0xFF):
    if ((0x20 <= r) and (r <= 0x7E)):
      return true
    if ((0xA1 <= r) and (r <= 0xFF)):
      return (r != 0xAD)
    return false
  if ((0 <= r) and (r < (1 shl 16))):
    var (rr, isPrintInternal, isNotPrint) = (convert(uint16, r), isPrint16, isNotPrint16)
    var i = bsearch16(isPrintInternal, rr)
    if (((i >= len(isPrintInternal)) or (rr < isPrintInternal[(i and (not 1))])) or (isPrintInternal[(i or 1)] < rr)):
      return false
    var j = bsearch16(isNotPrint, rr)
    return ((j >= len(isNotPrint)) or (isNotPrint[j] != rr))
  var (rr, isPrintInternal, isNotPrint) = (convert(uint32, r), isPrint32, isNotPrint32)
  var i = bsearch32(isPrintInternal, rr)
  if (((i >= len(isPrintInternal)) or (rr < isPrintInternal[(i and (not 1))])) or (isPrintInternal[(i or 1)] < rr)):
    return false
  if (r >= 0x20000):
    return true
  r -= 0x10000
  var j = bsearch16(isNotPrint, convert(uint16, r))
  return ((j >= len(isNotPrint)) or (isNotPrint[j] != convert(uint16, r)))

proc isGraphic(r: Rune): bool =
  if isPrint(r):
    return true
  return isInGraphicList(r)

proc isInGraphicList(r: Rune): bool =
  if (r > 0xFFFF):
    return false
  var rr = convert(uint16, r)
  var i = bsearch16(isGraphicInternal, rr)
  return ((i < len(isGraphicInternal)) and (rr == isGraphicInternal[i]))


when isMainModule:
  main()
