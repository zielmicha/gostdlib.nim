include gosupport
import golib/errors
import golib/io
import golib/unicode/utf8
import golib/io
import golib/unicode
import golib/unicode/utf8
const primeRK = 16777619

exttypes:
  type
    Reader* = struct((s: string, i: int64, prevRune: int))
    Replacer* = struct((r: ReplacerInternal))
    ReplacerInternal* = iface((replace(s: string): string, writeString(w: io.Writer, s: string): (int, Error)))
    TrieNode* = struct((value: string, priority: int, prefix: string, next: gcptr[TrieNode], table: GoSlice[gcptr[TrieNode]]))
    GenericReplacer* = struct((root: TrieNode, tableSize: int, mapping: GoArray[byte, 256]))
    AppendSliceWriter* = GoSlice[byte]
    StringWriterIface* = iface((writeString(arg0: string): (int, Error)))
    StringWriter* = struct((w: io.Writer))
    SingleStringReplacer* = struct((finder: gcptr[StringFinder], value: string))
    ByteReplacer* = GoArray[byte, 256]
    ByteStringReplacer* = GoArray[GoSlice[byte], 256]
    StringFinder* = struct((pattern: string, badCharSkip: GoArray[int, 256], goodSuffixSkip: GoSlice[int]))

proc compare*(a: string, b: string): int {.gofunc.}
proc len*(r: gcptr[Reader]): int {.gofunc, gomethod.}
proc size*(r: gcptr[Reader]): int64 {.gofunc, gomethod.}
proc read*(r: gcptr[Reader], b: GoSlice[byte]): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc readAt*(r: gcptr[Reader], b: GoSlice[byte], off: int64): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc readByte*(r: gcptr[Reader]): tuple[arg0: byte, arg1: Error] {.gofunc, gomethod.}
proc unreadByte*(r: gcptr[Reader]): Error {.gofunc, gomethod.}
proc readRune*(r: gcptr[Reader]): tuple[ch: Rune, size: int, err: Error] {.gofunc, gomethod.}
proc unreadRune*(r: gcptr[Reader]): Error {.gofunc, gomethod.}
proc seek*(r: gcptr[Reader], offset: int64, whence: int): tuple[arg0: int64, arg1: Error] {.gofunc, gomethod.}
proc writeTo*(r: gcptr[Reader], w: io.Writer): tuple[n: int64, err: Error] {.gofunc, gomethod.}
proc reset*(r: gcptr[Reader], s: string): void {.gofunc, gomethod.}
proc newReader*(s: string): gcptr[Reader] {.gofunc.}
proc newReplacer*(oldnew: GoVarArgs[string]): gcptr[Replacer] {.gofunc.}
proc replace*(r: gcptr[Replacer], s: string): string {.gofunc, gomethod.}
proc writeString*(r: gcptr[Replacer], w: io.Writer, s: string): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc add(t: gcptr[TrieNode], key: string, val: string, priority: int, r: gcptr[GenericReplacer]): void {.gofunc, gomethod.}
proc lookup(r: gcptr[GenericReplacer], s: string, ignoreRoot: bool): tuple[val: string, keylen: int, found: bool] {.gofunc, gomethod.}
proc makeGenericReplacer(oldnew: GoSlice[string]): gcptr[GenericReplacer] {.gofunc.}
proc write*(w: gcptr[AppendSliceWriter], p: GoSlice[byte]): tuple[arg0: int, arg1: Error] {.gofunc, gomethod.}
proc writeString*(w: gcptr[AppendSliceWriter], s: string): tuple[arg0: int, arg1: Error] {.gofunc, gomethod.}
proc writeString*(w: StringWriter, s: string): tuple[arg0: int, arg1: Error] {.gofunc.}
proc getStringWriter(w: io.Writer): StringWriterIface {.gofunc.}
proc replace*(r: gcptr[GenericReplacer], s: string): string {.gofunc, gomethod.}
proc writeString*(r: gcptr[GenericReplacer], w: io.Writer, s: string): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc makeSingleStringReplacer(pattern: string, value: string): gcptr[SingleStringReplacer] {.gofunc.}
proc replace*(r: gcptr[SingleStringReplacer], s: string): string {.gofunc, gomethod.}
proc writeString*(r: gcptr[SingleStringReplacer], w: io.Writer, s: string): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc replace*(r: gcptr[ByteReplacer], s: string): string {.gofunc, gomethod.}
proc writeString*(r: gcptr[ByteReplacer], w: io.Writer, s: string): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc replace*(r: gcptr[ByteStringReplacer], s: string): string {.gofunc, gomethod.}
proc writeString*(r: gcptr[ByteStringReplacer], w: io.Writer, s: string): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc makeStringFinder(pattern: string): gcptr[StringFinder] {.gofunc.}
proc longestCommonSuffix(a: string, b: string): int {.gofunc.}
proc next(f: gcptr[StringFinder], text: string): int {.gofunc, gomethod.}
proc max(a: int, b: int): int {.gofunc.}
proc explode(s: string, n: int): GoSlice[string] {.gofunc.}
proc hashStr(sep: string): tuple[arg0: uint32, arg1: uint32] {.gofunc.}
proc hashStrRev(sep: string): tuple[arg0: uint32, arg1: uint32] {.gofunc.}
proc count*(s: string, sep: string): int {.gofunc.}
proc contains*(s: string, substr: string): bool {.gofunc.}
proc containsAny*(s: string, chars: string): bool {.gofunc.}
proc containsRune*(s: string, r: Rune): bool {.gofunc.}
proc lastIndex*(s: string, sep: string): int {.gofunc.}
proc indexRune*(s: string, r: Rune): int {.gofunc.}
proc indexAny*(s: string, chars: string): int {.gofunc.}
proc lastIndexAny*(s: string, chars: string): int {.gofunc.}
proc lastIndexByte*(s: string, c: byte): int {.gofunc.}
proc genSplit(s: string, sep: string, sepSave: int, n: int): GoSlice[string] {.gofunc.}
proc splitN*(s: string, sep: string, n: int): GoSlice[string] {.gofunc.}
proc splitAfterN*(s: string, sep: string, n: int): GoSlice[string] {.gofunc.}
proc split*(s: string, sep: string): GoSlice[string] {.gofunc.}
proc splitAfter*(s: string, sep: string): GoSlice[string] {.gofunc.}
proc fields*(s: string): GoSlice[string] {.gofunc.}
proc fieldsFunc*(s: string, f: (proc(arg0: Rune): bool)): GoSlice[string] {.gofunc.}
proc join*(a: GoSlice[string], sep: string): string {.gofunc.}
proc hasPrefix*(s: string, prefix: string): bool {.gofunc.}
proc hasSuffix*(s: string, suffix: string): bool {.gofunc.}
proc map*(mapping: (proc(arg0: Rune): Rune), s: string): string {.gofunc.}
proc repeat*(s: string, countInternal: int): string {.gofunc.}
proc toUpper*(s: string): string {.gofunc.}
proc toLower*(s: string): string {.gofunc.}
proc toTitle*(s: string): string {.gofunc.}
proc toUpperSpecial*(underscorecase: unicode.SpecialCase, s: string): string {.gofunc.}
proc toLowerSpecial*(underscorecase: unicode.SpecialCase, s: string): string {.gofunc.}
proc toTitleSpecial*(underscorecase: unicode.SpecialCase, s: string): string {.gofunc.}
proc isSeparator(r: Rune): bool {.gofunc.}
proc title*(s: string): string {.gofunc.}
proc trimLeftFunc*(s: string, f: (proc(arg0: Rune): bool)): string {.gofunc.}
proc trimRightFunc*(s: string, f: (proc(arg0: Rune): bool)): string {.gofunc.}
proc trimFunc*(s: string, f: (proc(arg0: Rune): bool)): string {.gofunc.}
proc indexFunc*(s: string, f: (proc(arg0: Rune): bool)): int {.gofunc.}
proc lastIndexFunc*(s: string, f: (proc(arg0: Rune): bool)): int {.gofunc.}
proc indexFuncInternal*(s: string, f: (proc(arg0: Rune): bool), truth: bool): int {.gofunc.}
proc lastIndexFuncInternal*(s: string, f: (proc(arg0: Rune): bool), truth: bool): int {.gofunc.}
proc makeCutsetFunc(cutset: string): (proc(arg0: Rune): bool) {.gofunc.}
proc trim*(s: string, cutset: string): string {.gofunc.}
proc trimLeft*(s: string, cutset: string): string {.gofunc.}
proc trimRight*(s: string, cutset: string): string {.gofunc.}
proc trimSpace*(s: string): string {.gofunc.}
proc trimPrefix*(s: string, prefix: string): string {.gofunc.}
proc trimSuffix*(s: string, suffix: string): string {.gofunc.}
proc replace*(s: string, old: string, new: string, n: int): string {.gofunc.}
proc equalFold*(s: string, t: string): bool {.gofunc.}
proc indexByte*(s: string, c: byte): int {.gofunc.}
proc index*(s: string, sep: string): int {.gofunc.}


proc compare(a: string, b: string): int =
  if (a == b):
    return 0
  if (a < b):
    return -1
  return +1



proc len(r: gcptr[Reader]): int =
  if (r.i >= convert(int64, len(r.s))):
    return 0
  return convert(int, (convert(int64, len(r.s)) - r.i))

proc size(r: gcptr[Reader]): int64 =
  return convert(int64, len(r.s))

proc read(r: gcptr[Reader], b: GoSlice[byte]): tuple[n: int, err: Error] =
  if (r.i >= convert(int64, len(r.s))):
    (result.n, result.err) = (0, io.EOF)
    return
  r.prevRune = -1
  result.n = copy(b, slice(r.s, low=r.i))
  r.i += convert(int64, result.n)
  return

proc readAt(r: gcptr[Reader], b: GoSlice[byte], off: int64): tuple[n: int, err: Error] =
  if (off < 0):
    (result.n, result.err) = (0, errors.new("strings.Reader.ReadAt: negative offset"))
    return
  if (off >= convert(int64, len(r.s))):
    (result.n, result.err) = (0, io.EOF)
    return
  result.n = copy(b, slice(r.s, low=off))
  if (result.n < len(b)):
    result.err = io.EOF
  return

proc readByte(r: gcptr[Reader]): tuple[arg0: byte, arg1: Error] =
  r.prevRune = -1
  if (r.i >= convert(int64, len(r.s))):
    (result.arg0, result.arg1) = (0, io.EOF)
    return
  var b = r.s[r.i]
  r.i += 1
  (result.arg0, result.arg1) = (b, null)
  return

proc unreadByte(r: gcptr[Reader]): Error =
  r.prevRune = -1
  if (r.i <= 0):
    return errors.new("strings.Reader.UnreadByte: at beginning of string")
  r.i -= 1
  return null

proc readRune(r: gcptr[Reader]): tuple[ch: Rune, size: int, err: Error] =
  if (r.i >= convert(int64, len(r.s))):
    r.prevRune = -1
    (result.ch, result.size, result.err) = (0, 0, io.EOF)
    return
  r.prevRune = convert(int, r.i)
  if (var c = r.s[r.i]; (c < utf8.runeSelf)):
    r.i += 1
    (result.ch, result.size, result.err) = (convert(Rune, c), 1, null)
    return
  (result.ch, result.size) = utf8.decodeRuneInString(slice(r.s, low=r.i))
  r.i += convert(int64, result.size)
  return

proc unreadRune(r: gcptr[Reader]): Error =
  if (r.prevRune < 0):
    return errors.new("strings.Reader.UnreadRune: previous operation was not ReadRune")
  r.i = convert(int64, r.prevRune)
  r.prevRune = -1
  return null

proc seek(r: gcptr[Reader], offset: int64, whence: int): tuple[arg0: int64, arg1: Error] =
  r.prevRune = -1
  var abs: int64
  block:
    let condition = whence
    if condition == io.seekStart:
      abs = offset
    elif condition == io.seekCurrent:
      abs = (r.i + offset)
    elif condition == io.seekEnd:
      abs = (convert(int64, len(r.s)) + offset)
    else:
      (result.arg0, result.arg1) = (0, errors.new("strings.Reader.Seek: invalid whence"))
      return
  if (abs < 0):
    (result.arg0, result.arg1) = (0, errors.new("strings.Reader.Seek: negative position"))
    return
  r.i = abs
  (result.arg0, result.arg1) = (abs, null)
  return

proc writeTo(r: gcptr[Reader], w: io.Writer): tuple[n: int64, err: Error] =
  r.prevRune = -1
  if (r.i >= convert(int64, len(r.s))):
    (result.n, result.err) = (0, null)
    return
  var s = slice(r.s, low=r.i)
  var m: type((io.writeString(w, s))[0])
  (m, result.err) = io.writeString(w, s)
  if (m > len(s)):
    panic("strings.Reader.WriteTo: invalid WriteString count")
  r.i += convert(int64, m)
  result.n = convert(int64, m)
  if ((m != len(s)) and (result.err == null)):
    result.err = io.errShortWrite
  return

proc reset(r: gcptr[Reader], s: string): void =
  r[] = make((s, 0, -1), Reader)

proc newReader(s: string): gcptr[Reader] =
  return convert(gcptr[Reader], make((s, 0, -1), (ref Reader)))



proc newReplacer(oldnew: GoVarArgs[string]): gcptr[Replacer] =
  if ((len(oldnew) mod 2) == 1):
    panic("strings.NewReplacer: odd argument count")
  if ((len(oldnew) == 2) and (len(oldnew[0]) > 1)):
    return convert(gcptr[Replacer], (ref Replacer)(r: makeSingleStringReplacer(oldnew[0], oldnew[1])))
  var allNewBytes = true
  block loop0:
    var i = 0
    while (i < len(oldnew)):
      block loop0Continue:
        if (len(oldnew[i]) != 1):
          return convert(gcptr[Replacer], (ref Replacer)(r: makeGenericReplacer(oldnew)))
        if (len(oldnew[(i + 1)]) != 1):
          allNewBytes = false
      i += 2
  if allNewBytes:
    var r = make((), ByteReplacer)
    for i in 0..<len(r):
      r[i] = convert(byte, i)
    block loop0:
      var i = (len(oldnew) - 2)
      while (i >= 0):
        block loop0Continue:
          var o = oldnew[i][0]
          var n = oldnew[(i + 1)][0]
          r[o] = n
        i -= 2
    return convert(gcptr[Replacer], (ref Replacer)(r: gcaddr r))
  var r = make((), ByteStringReplacer)
  block loop0:
    var i = (len(oldnew) - 2)
    while (i >= 0):
      block loop0Continue:
        var o = oldnew[i][0]
        var n = oldnew[(i + 1)]
        r[o] = convert(GoSlice[byte], n)
      i -= 2
  return convert(gcptr[Replacer], (ref Replacer)(r: gcaddr r))

proc replace(r: gcptr[Replacer], s: string): string =
  return r.r.replace(s)

proc writeString(r: gcptr[Replacer], w: io.Writer, s: string): tuple[n: int, err: Error] =
  (result.n, result.err) = r.r.writeString(w, s)
  return

proc add(t: gcptr[TrieNode], key: string, val: string, priority: int, r: gcptr[GenericReplacer]): void =
  if (key == ""):
    if (t.priority == 0):
      t.value = val
      t.priority = priority
    return
  if (t.prefix != ""):
    var n: int
    block loop0:
      while ((n < len(t.prefix)) and (n < len(key))):
        block loop0Continue:
          if (t.prefix[n] != key[n]):
            break loop0
        n += 1
    if (n == len(t.prefix)):
      t.next.add(slice(key, low=n), val, priority, r)
    elif (n == 0):
      var prefixNode: gcptr[TrieNode]
      if (len(t.prefix) == 1):
        prefixNode = t.next
      else:
        prefixNode = convert(gcptr[TrieNode], (ref TrieNode)(prefix: slice(t.prefix, low=1), next: t.next))
      var keyNode = gcnew(TrieNode)
      t.table = make(GoSlice[gcptr[TrieNode]], r.tableSize)
      t.table[r.mapping[t.prefix[0]]] = prefixNode
      t.table[r.mapping[key[0]]] = keyNode
      t.prefix = ""
      t.next = null
      keyNode.add(slice(key, low=1), val, priority, r)
    else:
      var next = convert(gcptr[TrieNode], (ref TrieNode)(prefix: slice(t.prefix, low=n), next: t.next))
      t.prefix = slice(t.prefix, high=n)
      t.next = next
      next.add(slice(key, low=n), val, priority, r)
  elif (t.table != null):
    var m = r.mapping[key[0]]
    if (t.table[m] == null):
      t.table[m] = gcnew(TrieNode)
    t.table[m].add(slice(key, low=1), val, priority, r)
  else:
    t.prefix = key
    t.next = gcnew(TrieNode)
    t.next.add("", val, priority, r)

proc lookup(r: gcptr[GenericReplacer], s: string, ignoreRoot: bool): tuple[val: string, keylen: int, found: bool] =
  var s = s
  var bestPriority = 0
  var node = gcaddr r.root
  var n = 0
  while (node != null):
    if ((node.priority > bestPriority) and not ((ignoreRoot and (node == gcaddr r.root)))):
      bestPriority = node.priority
      result.val = node.value
      result.keylen = n
      result.found = true
    if (s == ""):
      break
    if (node.table != null):
      var indexInternal = r.mapping[s[0]]
      if (convert(int, indexInternal) == r.tableSize):
        break
      node = node.table[indexInternal]
      s = slice(s, low=1)
      n += 1
    elif ((node.prefix != "") and hasPrefix(s, node.prefix)):
      n += len(node.prefix)
      s = slice(s, low=len(node.prefix))
      node = node.next
    else:
      break
  return

proc makeGenericReplacer(oldnew: GoSlice[string]): gcptr[GenericReplacer] =
  var r = gcnew(GenericReplacer)
  block loop0:
    var i = 0
    while (i < len(oldnew)):
      block loop0Continue:
        var key = oldnew[i]
        block loop1:
          var j = 0
          while (j < len(key)):
            block loop1Continue:
              r.mapping[key[j]] = 1
            j += 1
      i += 2
  for _, b in r.mapping:
    r.tableSize += convert(int, b)
  var indexInternal: byte
  for i, b in r.mapping:
    if (b == 0):
      r.mapping[i] = convert(byte, r.tableSize)
    else:
      r.mapping[i] = indexInternal
      indexInternal += 1
  r.root.table = make(GoSlice[gcptr[TrieNode]], r.tableSize)
  block loop0:
    var i = 0
    while (i < len(oldnew)):
      block loop0Continue:
        r.root.add(oldnew[i], oldnew[(i + 1)], (len(oldnew) - i), r)
      i += 2
  return r

proc write(w: gcptr[AppendSliceWriter], p: GoSlice[byte]): tuple[arg0: int, arg1: Error] =
  w[] = append(w[], govarargs(p))
  (result.arg0, result.arg1) = (len(p), null)
  return

proc writeString(w: gcptr[AppendSliceWriter], s: string): tuple[arg0: int, arg1: Error] =
  w[] = append(w[], govarargs(s))
  (result.arg0, result.arg1) = (len(s), null)
  return

proc writeString(w: StringWriter, s: string): tuple[arg0: int, arg1: Error] =
  (result.arg0, result.arg1) = w.w.write(convert(GoSlice[byte], s))
  return

proc getStringWriter(w: io.Writer): StringWriterIface =
  var (sw, ok) = maybeCastInterface(w, to=StringWriterIface)
  if not ok:
    sw = make((w), StringWriter)
  return sw

proc replace(r: gcptr[GenericReplacer], s: string): string =
  var buf = make(AppendSliceWriter, 0, len(s))
  r.writeString(gcaddr buf, s)
  return convert(string, buf)

proc writeString(r: gcptr[GenericReplacer], w: io.Writer, s: string): tuple[n: int, err: Error] =
  var sw = getStringWriter(w)
  var 
    last: int
    wn: int
  var prevMatchEmpty: bool
  block loop0:
    var i = 0
    while (i <= len(s)):
      if ((i != len(s)) and (r.root.priority == 0)):
        var indexInternal = convert(int, r.mapping[s[i]])
        if ((indexInternal == r.tableSize) or (r.root.table[indexInternal] == null)):
          i += 1
          continue
      var (val, keylen, match) = r.lookup(slice(s, low=i), prevMatchEmpty)
      prevMatchEmpty = (match and (keylen == 0))
      if match:
        (wn, result.err) = sw.writeString(slice(s, low=last, high=i))
        result.n += wn
        if (result.err != null):
          return
        (wn, result.err) = sw.writeString(val)
        result.n += wn
        if (result.err != null):
          return
        i += keylen
        last = i
        continue
      i += 1
  if (last != len(s)):
    (wn, result.err) = sw.writeString(slice(s, low=last))
    result.n += wn
  return

proc makeSingleStringReplacer(pattern: string, value: string): gcptr[SingleStringReplacer] =
  return convert(gcptr[SingleStringReplacer], (ref SingleStringReplacer)(finder: makeStringFinder(pattern), value: value))

proc replace(r: gcptr[SingleStringReplacer], s: string): string =
  var buf: GoSlice[byte]
  var (i, matched) = (0, false)
  while true:
    var match = r.finder.next(slice(s, low=i))
    if (match == -1):
      break
    matched = true
    buf = append(buf, govarargs(slice(s, low=i, high=(i + match))))
    buf = append(buf, govarargs(r.value))
    i += (match + len(r.finder.pattern))
  if not matched:
    return s
  buf = append(buf, govarargs(slice(s, low=i)))
  return convert(string, buf)

proc writeString(r: gcptr[SingleStringReplacer], w: io.Writer, s: string): tuple[n: int, err: Error] =
  var sw = getStringWriter(w)
  var 
    i: int
    wn: int
  while true:
    var match = r.finder.next(slice(s, low=i))
    if (match == -1):
      break
    (wn, result.err) = sw.writeString(slice(s, low=i, high=(i + match)))
    result.n += wn
    if (result.err != null):
      return
    (wn, result.err) = sw.writeString(r.value)
    result.n += wn
    if (result.err != null):
      return
    i += (match + len(r.finder.pattern))
  (wn, result.err) = sw.writeString(slice(s, low=i))
  result.n += wn
  return

proc replace(r: gcptr[ByteReplacer], s: string): string =
  var buf: GoSlice[byte]
  block loop0:
    var i = 0
    while (i < len(s)):
      block loop0Continue:
        var b = s[i]
        if (r[b] != b):
          if (buf == null):
            buf = convert(GoSlice[byte], s)
          buf[i] = r[b]
      i += 1
  if (buf == null):
    return s
  return convert(string, buf)

proc writeString(r: gcptr[ByteReplacer], w: io.Writer, s: string): tuple[n: int, err: Error] =
  var s = s
  var bufsize = (32 shl 10)
  if (len(s) < bufsize):
    bufsize = len(s)
  var buf = make(GoSlice[byte], bufsize)
  while (len(s) > 0):
    var ncopy = copy(buf, slice(s))
    s = slice(s, low=ncopy)
    for i, b in slice(buf, high=ncopy):
      buf[i] = r[b]
    var (wn, err) = w.write(slice(buf, high=ncopy))
    result.n += wn
    if (err != null):
      (result.n, result.err) = (result.n, err)
      return
  (result.n, result.err) = (result.n, null)
  return

proc replace(r: gcptr[ByteStringReplacer], s: string): string =
  var newSize = len(s)
  var anyChanges = false
  block loop0:
    var i = 0
    while (i < len(s)):
      block loop0Continue:
        var b = s[i]
        if (r[b] != null):
          anyChanges = true
          newSize += (len(r[b]) - 1)
      i += 1
  if not anyChanges:
    return s
  var buf = make(GoSlice[byte], newSize)
  var bi = buf
  block loop0:
    var i = 0
    while (i < len(s)):
      block loop0Continue:
        var b = s[i]
        if (r[b] != null):
          var n = copy(bi, r[b])
          bi = slice(bi, low=n)
        else:
          bi[0] = b
          bi = slice(bi, low=1)
      i += 1
  return convert(string, buf)

proc writeString(r: gcptr[ByteStringReplacer], w: io.Writer, s: string): tuple[n: int, err: Error] =
  var sw = getStringWriter(w)
  var last = 0
  block loop0:
    var i = 0
    while (i < len(s)):
      block loop0Continue:
        var b = s[i]
        if (r[b] == null):
          break loop0Continue
        if (last != i):
          var (nw, err) = sw.writeString(slice(s, low=last, high=i))
          result.n += nw
          if (err != null):
            (result.n, result.err) = (result.n, err)
            return
        last = (i + 1)
        var (nw, err) = w.write(r[b])
        result.n += nw
        if (err != null):
          (result.n, result.err) = (result.n, err)
          return
      i += 1
  if (last != len(s)):
    var nw: int
    (nw, result.err) = sw.writeString(slice(s, low=last))
    result.n += nw
  return



proc makeStringFinder(pattern: string): gcptr[StringFinder] =
  var f = convert(gcptr[StringFinder], (ref StringFinder)(pattern: pattern, goodSuffixSkip: make(GoSlice[int], len(pattern))))
  var last = (len(pattern) - 1)
  for i in 0..<len(f.badCharSkip):
    f.badCharSkip[i] = len(pattern)
  block loop0:
    var i = 0
    while (i < last):
      block loop0Continue:
        f.badCharSkip[pattern[i]] = (last - i)
      i += 1
  var lastPrefix = last
  block loop0:
    var i = last
    while (i >= 0):
      block loop0Continue:
        if hasPrefix(pattern, slice(pattern, low=(i + 1))):
          lastPrefix = (i + 1)
        f.goodSuffixSkip[i] = ((lastPrefix + last) - i)
      i -= 1
  block loop0:
    var i = 0
    while (i < last):
      block loop0Continue:
        var lenSuffix = longestCommonSuffix(pattern, slice(pattern, low=1, high=(i + 1)))
        if (pattern[(i - lenSuffix)] != pattern[(last - lenSuffix)]):
          f.goodSuffixSkip[(last - lenSuffix)] = ((lenSuffix + last) - i)
      i += 1
  return f

proc longestCommonSuffix(a: string, b: string): int =
  block loop0:
    while ((result < len(a)) and (result < len(b))):
      block loop0Continue:
        if (a[((len(a) - 1) - result)] != b[((len(b) - 1) - result)]):
          break loop0
      result += 1
  return

proc next(f: gcptr[StringFinder], text: string): int =
  var i = (len(f.pattern) - 1)
  while (i < len(text)):
    var j = (len(f.pattern) - 1)
    while ((j >= 0) and (text[i] == f.pattern[j])):
      i -= 1
      j -= 1
    if (j < 0):
      return (i + 1)
    i += max(f.badCharSkip[text[i]], f.goodSuffixSkip[j])
  return -1

proc max(a: int, b: int): int =
  if (a > b):
    return a
  return b



proc explode(s: string, n: int): GoSlice[string] =
  var (s,n) = (s,n)
  var l = utf8.runeCountInString(s)
  if ((n < 0) or (n > l)):
    n = l
  var a = make(GoSlice[string], n)
  block loop0:
    var i = 0
    while (i < (n - 1)):
      block loop0Continue:
        var (ch, sizeInternal) = utf8.decodeRuneInString(s)
        a[i] = slice(s, high=sizeInternal)
        s = slice(s, low=sizeInternal)
        if (ch == utf8.runeError):
          a[i] = convert(string, utf8.runeError)
      i += 1
  if (n > 0):
    a[(n - 1)] = s
  return a

proc hashStr(sep: string): tuple[arg0: uint32, arg1: uint32] =
  var hash = convert(uint32, 0)
  block loop0:
    var i = 0
    while (i < len(sep)):
      block loop0Continue:
        hash = ((hash * primeRK) + convert(uint32, sep[i]))
      i += 1
  var 
    pow: uint32 = 1
    sq: uint32 = primeRK
  block loop0:
    var i = len(sep)
    while (i > 0):
      block loop0Continue:
        if ((i and 1) != 0):
          pow *= sq
        sq *= sq
      i = i shr (1)
  (result.arg0, result.arg1) = (hash, pow)
  return

proc hashStrRev(sep: string): tuple[arg0: uint32, arg1: uint32] =
  var hash = convert(uint32, 0)
  block loop0:
    var i = (len(sep) - 1)
    while (i >= 0):
      block loop0Continue:
        hash = ((hash * primeRK) + convert(uint32, sep[i]))
      i -= 1
  var 
    pow: uint32 = 1
    sq: uint32 = primeRK
  block loop0:
    var i = len(sep)
    while (i > 0):
      block loop0Continue:
        if ((i and 1) != 0):
          pow *= sq
        sq *= sq
      i = i shr (1)
  (result.arg0, result.arg1) = (hash, pow)
  return

proc count(s: string, sep: string): int =
  var n = 0
  if true == (len(sep) == 0):
    return (utf8.runeCountInString(s) + 1)
  elif true == (len(sep) == 1):
    var c = sep[0]
    block loop0:
      var i = 0
      while (i < len(s)):
        block loop0Continue:
          if (s[i] == c):
            n += 1
        i += 1
    return n
  elif true == (len(sep) > len(s)):
    return 0
  elif true == (len(sep) == len(s)):
    if (sep == s):
      return 1
    return 0
  
  var (hashsep, pow) = hashStr(sep)
  var h = convert(uint32, 0)
  block loop0:
    var i = 0
    while (i < len(sep)):
      block loop0Continue:
        h = ((h * primeRK) + convert(uint32, s[i]))
      i += 1
  var lastmatch = 0
  if ((h == hashsep) and (slice(s, high=len(sep)) == sep)):
    n += 1
    lastmatch = len(sep)
  block loop0:
    var i = len(sep)
    while (i < len(s)):
      h *= primeRK
      h += convert(uint32, s[i])
      h -= (pow * convert(uint32, s[(i - len(sep))]))
      i += 1
      if (((h == hashsep) and (lastmatch <= (i - len(sep)))) and (slice(s, low=(i - len(sep)), high=i) == sep)):
        n += 1
        lastmatch = i
  return n

proc contains(s: string, substr: string): bool =
  return (index(s, substr) >= 0)

proc containsAny(s: string, chars: string): bool =
  return (indexAny(s, chars) >= 0)

proc containsRune(s: string, r: Rune): bool =
  return (indexRune(s, r) >= 0)

proc lastIndex(s: string, sep: string): int =
  var n = len(sep)
  if true == (n == 0):
    return len(s)
  elif true == (n == 1):
    return lastIndexByte(s, sep[0])
  elif true == (n == len(s)):
    if (sep == s):
      return 0
    return -1
  elif true == (n > len(s)):
    return -1
  
  var (hashsep, pow) = hashStrRev(sep)
  var last = (len(s) - n)
  var h: uint32
  block loop0:
    var i = (len(s) - 1)
    while (i >= last):
      block loop0Continue:
        h = ((h * primeRK) + convert(uint32, s[i]))
      i -= 1
  if ((h == hashsep) and (slice(s, low=last) == sep)):
    return last
  block loop0:
    var i = (last - 1)
    while (i >= 0):
      block loop0Continue:
        h *= primeRK
        h += convert(uint32, s[i])
        h -= (pow * convert(uint32, s[(i + n)]))
        if ((h == hashsep) and (slice(s, low=i, high=(i + n)) == sep)):
          return i
      i -= 1
  return -1

proc indexRune(s: string, r: Rune): int =
  if true == (r < utf8.runeSelf):
    return indexByte(s, convert(byte, r))
  else:
    for i, c in s:
      if (c == r):
        return i
  return -1

proc indexAny(s: string, chars: string): int =
  if (len(chars) > 0):
    for i, c in s:
      for _, m in chars:
        if (c == m):
          return i
  return -1

proc lastIndexAny(s: string, chars: string): int =
  if (len(chars) > 0):
    block loop0:
      var i = len(s)
      while (i > 0):
        var (rune, sizeInternal) = utf8.decodeLastRuneInString(slice(s, low=0, high=i))
        i -= sizeInternal
        for _, m in chars:
          if (rune == m):
            return i
  return -1

proc lastIndexByte(s: string, c: byte): int =
  block loop0:
    var i = (len(s) - 1)
    while (i >= 0):
      block loop0Continue:
        if (s[i] == c):
          return i
      i -= 1
  return -1

proc genSplit(s: string, sep: string, sepSave: int, n: int): GoSlice[string] =
  var n = n
  if (n == 0):
    return null
  if (sep == ""):
    return explode(s, n)
  if (n < 0):
    n = (count(s, sep) + 1)
  var c = sep[0]
  var start = 0
  var a = make(GoSlice[string], n)
  var na = 0
  block loop0:
    var i = 0
    while (((i + len(sep)) <= len(s)) and ((na + 1) < n)):
      block loop0Continue:
        if ((s[i] == c) and (((len(sep) == 1) or (slice(s, low=i, high=(i + len(sep))) == sep)))):
          a[na] = slice(s, low=start, high=(i + sepSave))
          na += 1
          start = (i + len(sep))
          i += (len(sep) - 1)
      i += 1
  a[na] = slice(s, low=start)
  return slice(a, low=0, high=(na + 1))

proc splitN(s: string, sep: string, n: int): GoSlice[string] =
  return genSplit(s, sep, 0, n)

proc splitAfterN(s: string, sep: string, n: int): GoSlice[string] =
  return genSplit(s, sep, len(sep), n)

proc split(s: string, sep: string): GoSlice[string] =
  return genSplit(s, sep, 0, -1)

proc splitAfter(s: string, sep: string): GoSlice[string] =
  return genSplit(s, sep, len(sep), -1)

proc fields(s: string): GoSlice[string] =
  return fieldsFunc(s, unicode.isSpace)

proc fieldsFunc(s: string, f: (proc(arg0: Rune): bool)): GoSlice[string] =
  var n = 0
  var inField = false
  for _, rune in s:
    var wasInField = inField
    inField = not f(rune)
    if (inField and not wasInField):
      n += 1
  var a = make(GoSlice[string], n)
  var na = 0
  var fieldStart = -1
  for i, rune in s:
    if f(rune):
      if (fieldStart >= 0):
        a[na] = slice(s, low=fieldStart, high=i)
        na += 1
        fieldStart = -1
    elif (fieldStart == -1):
      fieldStart = i
  if (fieldStart >= 0):
    a[na] = slice(s, low=fieldStart)
  return a

proc join(a: GoSlice[string], sep: string): string =
  if (len(a) == 0):
    return ""
  if (len(a) == 1):
    return a[0]
  var n = (len(sep) * ((len(a) - 1)))
  block loop0:
    var i = 0
    while (i < len(a)):
      block loop0Continue:
        n += len(a[i])
      i += 1
  var b = make(GoSlice[byte], n)
  var bp = copy(b, a[0])
  for _, s in slice(a, low=1):
    bp += copy(slice(b, low=bp), sep)
    bp += copy(slice(b, low=bp), s)
  return convert(string, b)

proc hasPrefix(s: string, prefix: string): bool =
  return ((len(s) >= len(prefix)) and (slice(s, low=0, high=len(prefix)) == prefix))

proc hasSuffix(s: string, suffix: string): bool =
  return ((len(s) >= len(suffix)) and (slice(s, low=(len(s) - len(suffix))) == suffix))

proc map(mapping: (proc(arg0: Rune): Rune), s: string): string =
  var maxbytes = len(s)
  var nbytes = 0
  var b: GoSlice[byte]
  for i, c in s:
    var r = mapping(c)
    if (b == null):
      if (r == c):
        continue
      b = make(GoSlice[byte], maxbytes)
      nbytes = copy(b, slice(s, high=i))
    if (r >= 0):
      var wid = 1
      if (r >= utf8.runeSelf):
        wid = utf8.runeLen(r)
      if ((nbytes + wid) > maxbytes):
        maxbytes = ((maxbytes * 2) + utf8.UTFMax)
        var nb = make(GoSlice[byte], maxbytes)
        copy(nb, slice(b, low=0, high=nbytes))
        b = nb
      nbytes += utf8.encodeRune(slice(b, low=nbytes, high=maxbytes), r)
  if (b == null):
    return s
  return convert(string, slice(b, low=0, high=nbytes))

proc repeat(s: string, countInternal: int): string =
  var b = make(GoSlice[byte], (len(s) * countInternal))
  var bp = copy(b, s)
  while (bp < len(b)):
    copy(slice(b, low=bp), slice(b, high=bp))
    bp *= 2
  return convert(string, b)

proc toUpper(s: string): string =
  return map(unicode.toUpper, s)

proc toLower(s: string): string =
  return map(unicode.toLower, s)

proc toTitle(s: string): string =
  return map(unicode.toTitle, s)

proc toUpperSpecial(underscorecase: unicode.SpecialCase, s: string): string =
  return map((proc(r: Rune): Rune =
    return underscorecase.toUpper(r)), s)

proc toLowerSpecial(underscorecase: unicode.SpecialCase, s: string): string =
  return map((proc(r: Rune): Rune =
    return underscorecase.toLower(r)), s)

proc toTitleSpecial(underscorecase: unicode.SpecialCase, s: string): string =
  return map((proc(r: Rune): Rune =
    return underscorecase.toTitle(r)), s)

proc isSeparator(r: Rune): bool =
  if (r <= 0x7F):
    if true == ((runelit('0') <= r) and (r <= runelit('9'))):
      return false
    elif true == ((runelit('a') <= r) and (r <= runelit('z'))):
      return false
    elif true == ((runelit('A') <= r) and (r <= runelit('Z'))):
      return false
    elif true == (r == runelit('_')):
      return false
    
    return true
  if (unicode.isLetter(r) or unicode.isDigit(r)):
    return false
  return unicode.isSpace(r)

proc title(s: string): string =
  var prev = runelit(' ')
  return map((proc(r: Rune): Rune =
    if isSeparator(prev):
      prev = r
      return unicode.toTitle(r)
    prev = r
    return r), s)

proc trimLeftFunc(s: string, f: (proc(arg0: Rune): bool)): string =
  var i = indexFuncInternal(s, f, false)
  if (i == -1):
    return ""
  return slice(s, low=i)

proc trimRightFunc(s: string, f: (proc(arg0: Rune): bool)): string =
  var i = lastIndexFuncInternal(s, f, false)
  if ((i >= 0) and (s[i] >= utf8.runeSelf)):
    var (unused, wid) = utf8.decodeRuneInString(slice(s, low=i))
    i += wid
  else:
    i += 1
  return slice(s, low=0, high=i)

proc trimFunc(s: string, f: (proc(arg0: Rune): bool)): string =
  return trimRightFunc(trimLeftFunc(s, f), f)

proc indexFunc(s: string, f: (proc(arg0: Rune): bool)): int =
  return indexFuncInternal(s, f, true)

proc lastIndexFunc(s: string, f: (proc(arg0: Rune): bool)): int =
  return lastIndexFuncInternal(s, f, true)

proc indexFuncInternal(s: string, f: (proc(arg0: Rune): bool), truth: bool): int =
  var start = 0
  while (start < len(s)):
    var wid = 1
    var r = convert(Rune, s[start])
    if (r >= utf8.runeSelf):
      (r, wid) = utf8.decodeRuneInString(slice(s, low=start))
    if (f(r) == truth):
      return start
    start += wid
  return -1

proc lastIndexFuncInternal(s: string, f: (proc(arg0: Rune): bool), truth: bool): int =
  block loop0:
    var i = len(s)
    while (i > 0):
      var (r, sizeInternal) = utf8.decodeLastRuneInString(slice(s, low=0, high=i))
      i -= sizeInternal
      if (f(r) == truth):
        return i
  return -1

proc makeCutsetFunc(cutset: string): (proc(arg0: Rune): bool) =
  return (proc(r: Rune): bool =
    return (indexRune(cutset, r) >= 0))

proc trim(s: string, cutset: string): string =
  if ((s == "") or (cutset == "")):
    return s
  return trimFunc(s, makeCutsetFunc(cutset))

proc trimLeft(s: string, cutset: string): string =
  if ((s == "") or (cutset == "")):
    return s
  return trimLeftFunc(s, makeCutsetFunc(cutset))

proc trimRight(s: string, cutset: string): string =
  if ((s == "") or (cutset == "")):
    return s
  return trimRightFunc(s, makeCutsetFunc(cutset))

proc trimSpace(s: string): string =
  return trimFunc(s, unicode.isSpace)

proc trimPrefix(s: string, prefix: string): string =
  if hasPrefix(s, prefix):
    return slice(s, low=len(prefix))
  return s

proc trimSuffix(s: string, suffix: string): string =
  if hasSuffix(s, suffix):
    return slice(s, high=(len(s) - len(suffix)))
  return s

proc replace(s: string, old: string, new: string, n: int): string =
  var n = n
  if ((old == new) or (n == 0)):
    return s
  var m = count(s, old)
  if (m == 0):
    return s
  elif ((n < 0) or (m < n)):
    n = m
  var t = make(GoSlice[byte], (len(s) + (n * ((len(new) - len(old))))))
  var w = 0
  var start = 0
  block loop0:
    var i = 0
    while (i < n):
      block loop0Continue:
        var j = start
        if (len(old) == 0):
          if (i > 0):
            var (unused, wid) = utf8.decodeRuneInString(slice(s, low=start))
            j += wid
        else:
          j += index(slice(s, low=start), old)
        w += copy(slice(t, low=w), slice(s, low=start, high=j))
        w += copy(slice(t, low=w), new)
        start = (j + len(old))
      i += 1
  w += copy(slice(t, low=w), slice(s, low=start))
  return convert(string, slice(t, low=0, high=w))

proc equalFold(s: string, t: string): bool =
  var (s,t) = (s,t)
  while ((s != "") and (t != "")):
    var 
      sr: Rune
      tr: Rune
    if (s[0] < utf8.runeSelf):
      (sr, s) = (convert(Rune, s[0]), slice(s, low=1))
    else:
      var (r, sizeInternal) = utf8.decodeRuneInString(s)
      (sr, s) = (r, slice(s, low=sizeInternal))
    if (t[0] < utf8.runeSelf):
      (tr, t) = (convert(Rune, t[0]), slice(t, low=1))
    else:
      var (r, sizeInternal) = utf8.decodeRuneInString(t)
      (tr, t) = (r, slice(t, low=sizeInternal))
    if (tr == sr):
      continue
    if (tr < sr):
      (tr, sr) = (sr, tr)
    if (((tr < utf8.runeSelf) and (runelit('A') <= sr)) and (sr <= runelit('Z'))):
      if (tr == ((sr + runelit('a')) - runelit('A'))):
        continue
      return false
    var r = unicode.simpleFold(sr)
    while ((r != sr) and (r < tr)):
      r = unicode.simpleFold(r)
    if (r == tr):
      continue
    return false
  return (s == t)



proc indexByte(s: string, c: byte): int =
  discard



proc index(s: string, sep: string): int =
  var n = len(sep)
  if true == (n == 0):
    return 0
  elif true == (n == 1):
    return indexByte(s, sep[0])
  elif true == (n == len(s)):
    if (sep == s):
      return 0
    return -1
  elif true == (n > len(s)):
    return -1
  
  var (hashsep, pow) = hashStr(sep)
  var h: uint32
  block loop0:
    var i = 0
    while (i < n):
      block loop0Continue:
        h = ((h * primeRK) + convert(uint32, s[i]))
      i += 1
  if ((h == hashsep) and (slice(s, high=n) == sep)):
    return 0
  block loop0:
    var i = n
    while (i < len(s)):
      h *= primeRK
      h += convert(uint32, s[i])
      h -= (pow * convert(uint32, s[(i - n)]))
      i += 1
      if ((h == hashsep) and (slice(s, low=(i - n), high=i) == sep)):
        return (i - n)
  return -1


when isMainModule:
  main()
