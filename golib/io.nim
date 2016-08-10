include gosupport
import golib/errors
import golib/errors
import golib/sync
const 
  seekStart* = 0
  seekCurrent* = 1
  seekEnd* = 2

exttypes:
  type
    Reader* = iface((read(p: GoSlice[byte]): (int, Error)))
    Writer* = iface((write(p: GoSlice[byte]): (int, Error)))
    Closer* = iface((close(): Error))
    Seeker* = iface((seek(offset: int64, whence: int): (int64, Error)))
    ReadWriter* = iface((extends Reader, extends Writer))
    ReadCloser* = iface((extends Reader, extends Closer))
    WriteCloser* = iface((extends Writer, extends Closer))
    ReadWriteCloser* = iface((extends Reader, extends Writer, extends Closer))
    ReadSeeker* = iface((extends Reader, extends Seeker))
    WriteSeeker* = iface((extends Writer, extends Seeker))
    ReadWriteSeeker* = iface((extends Reader, extends Writer, extends Seeker))
    ReaderFrom* = iface((readFrom(r: Reader): (int64, Error)))
    WriterTo* = iface((writeTo(w: Writer): (int64, Error)))
    ReaderAt* = iface((readAt(p: GoSlice[byte], off: int64): (int, Error)))
    WriterAt* = iface((writeAt(p: GoSlice[byte], off: int64): (int, Error)))
    ByteReader* = iface((readByte(): (byte, Error)))
    ByteScanner* = iface((extends ByteReader, unreadByte(): Error))
    ByteWriter* = iface((writeByte(c: byte): Error))
    RuneReader* = iface((readRune(): (Rune, int, Error)))
    RuneScanner* = iface((extends RuneReader, unreadRune(): Error))
    StringWriter* = iface((writeString(s: string): (int, Error)))
    LimitedReader* = struct((r: Reader, n: int64))
    SectionReader* = struct((r: ReaderAt, base: int64, off: int64, limit: int64))
    TeeReader* = struct((r: Reader, w: Writer))
    MultiReader* = struct((readers: GoSlice[Reader]))
    MultiWriter* = struct((writers: GoSlice[Writer]))
    Pipe* = struct((rl: sync.Mutex, wl: sync.Mutex, l: sync.Mutex, data: GoSlice[byte], rwait: sync.Cond, wwait: sync.Cond, rerr: Error, werr: Error))
    PipeReader* = struct((p: gcptr[Pipe]))
    PipeWriter* = struct((p: gcptr[Pipe]))

proc writeString*(w: Writer, s: string): tuple[n: int, err: Error] {.gofunc.}
proc readAtLeast*(r: Reader, buf: GoSlice[byte], min: int): tuple[n: int, err: Error] {.gofunc.}
proc readFull*(r: Reader, buf: GoSlice[byte]): tuple[n: int, err: Error] {.gofunc.}
proc copyN*(dst: Writer, src: Reader, n: int64): tuple[written: int64, err: Error] {.gofunc.}
proc copy*(dst: Writer, src: Reader): tuple[written: int64, err: Error] {.gofunc.}
proc copyBuffer*(dst: Writer, src: Reader, buf: GoSlice[byte]): tuple[written: int64, err: Error] {.gofunc.}
proc copyBufferInternal*(dst: Writer, src: Reader, buf: GoSlice[byte]): tuple[written: int64, err: Error] {.gofunc.}
proc limitReader*(r: Reader, n: int64): Reader {.gofunc.}
proc read*(l: gcptr[LimitedReader], p: GoSlice[byte]): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc newSectionReader*(r: ReaderAt, off: int64, n: int64): gcptr[SectionReader] {.gofunc.}
proc read*(s: gcptr[SectionReader], p: GoSlice[byte]): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc seek*(s: gcptr[SectionReader], offset: int64, whence: int): tuple[arg0: int64, arg1: Error] {.gofunc, gomethod.}
proc readAt*(s: gcptr[SectionReader], p: GoSlice[byte], off: int64): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc size*(s: gcptr[SectionReader]): int64 {.gofunc, gomethod.}
proc teeReader*(r: Reader, w: Writer): Reader {.gofunc.}
proc read*(t: gcptr[TeeReader], p: GoSlice[byte]): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc read*(mr: gcptr[MultiReader], p: GoSlice[byte]): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc multiReader*(readers: GoVarArgs[Reader]): Reader {.gofunc.}
proc write*(t: gcptr[MultiWriter], p: GoSlice[byte]): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc writeString*(t: gcptr[MultiWriter], s: string): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc multiWriter*(writers: GoVarArgs[Writer]): Writer {.gofunc.}
proc readInternal*(p: gcptr[Pipe], b: GoSlice[byte]): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc writeInternal*(p: gcptr[Pipe], b: GoSlice[byte]): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc rclose(p: gcptr[Pipe], err: Error): void {.gofunc, gomethod.}
proc wclose(p: gcptr[Pipe], err: Error): void {.gofunc, gomethod.}
proc read*(r: gcptr[PipeReader], data: GoSlice[byte]): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc close*(r: gcptr[PipeReader]): Error {.gofunc, gomethod.}
proc closeWithError*(r: gcptr[PipeReader], err: Error): Error {.gofunc, gomethod.}
proc write*(w: gcptr[PipeWriter], data: GoSlice[byte]): tuple[n: int, err: Error] {.gofunc, gomethod.}
proc close*(w: gcptr[PipeWriter]): Error {.gofunc, gomethod.}
proc closeWithError*(w: gcptr[PipeWriter], err: Error): Error {.gofunc, gomethod.}
proc pipe*(): tuple[arg0: gcptr[PipeReader], arg1: gcptr[PipeWriter]] {.gofunc.}
var errShortWrite* = errors.new("short write")
var errShortBuffer* = errors.new("short buffer")
var EOF* = errors.new("EOF")
var errUnexpectedEOF* = errors.new("unexpected EOF")
var errNoProgress* = errors.new("multiple Read calls return no data or error")
var errWhence = errors.new("Seek: invalid whence")
var errOffset = errors.new("Seek: invalid offset")
var _: StringWriter = convert(gcptr[MultiWriter], null)
var errClosedPipe* = errors.new("io: read/write on closed pipe")
var zero: GoArray[byte, 0]


proc writeString(w: Writer, s: string): tuple[n: int, err: Error] =
  if (var (sw, ok) = maybeCastInterface(w, to=StringWriter); ok):
    (result.n, result.err) = sw.writeString(s)
    return
  (result.n, result.err) = w.write(convert(GoSlice[byte], s))
  return

proc readAtLeast(r: Reader, buf: GoSlice[byte], min: int): tuple[n: int, err: Error] =
  if (len(buf) < min):
    (result.n, result.err) = (0, errShortBuffer)
    return
  while ((result.n < min) and (result.err == null)):
    var nn: int
    (nn, result.err) = r.read(slice(buf, low=result.n))
    result.n += nn
  if (result.n >= min):
    result.err = null
  elif ((result.n > 0) and (result.err == EOF)):
    result.err = errUnexpectedEOF
  return

proc readFull(r: Reader, buf: GoSlice[byte]): tuple[n: int, err: Error] =
  (result.n, result.err) = readAtLeast(r, buf, len(buf))
  return

proc copyN(dst: Writer, src: Reader, n: int64): tuple[written: int64, err: Error] =
  (result.written, result.err) = copy(dst, limitReader(src, n))
  if (result.written == n):
    (result.written, result.err) = (n, null)
    return
  if ((result.written < n) and (result.err == null)):
    result.err = EOF
  return

proc copy(dst: Writer, src: Reader): tuple[written: int64, err: Error] =
  (result.written, result.err) = copyBufferInternal(dst, src, null)
  return

proc copyBuffer(dst: Writer, src: Reader, buf: GoSlice[byte]): tuple[written: int64, err: Error] =
  if ((buf != null) and (len(buf) == 0)):
    panic("empty buffer in io.CopyBuffer")
  (result.written, result.err) = copyBufferInternal(dst, src, buf)
  return

proc copyBufferInternal(dst: Writer, src: Reader, buf: GoSlice[byte]): tuple[written: int64, err: Error] =
  var buf = buf
  if (var (wt, ok) = maybeCastInterface(src, to=WriterTo); ok):
    (result.written, result.err) = wt.writeTo(dst)
    return
  if (var (rt, ok) = maybeCastInterface(dst, to=ReaderFrom); ok):
    (result.written, result.err) = rt.readFrom(src)
    return
  if (buf == null):
    buf = make(GoSlice[byte], (32 * 1024))
  while true:
    var (nr, er) = src.read(buf)
    if (nr > 0):
      var (nw, ew) = dst.write(slice(buf, low=0, high=nr))
      if (nw > 0):
        result.written += convert(int64, nw)
      if (ew != null):
        result.err = ew
        break
      if (nr != nw):
        result.err = errShortWrite
        break
    if (er == EOF):
      break
    if (er != null):
      result.err = er
      break
  (result.written, result.err) = (result.written, result.err)
  return

proc limitReader(r: Reader, n: int64): Reader =
  return convert(gcptr[LimitedReader], make((r, n), (ref LimitedReader)))

proc read(l: gcptr[LimitedReader], p: GoSlice[byte]): tuple[n: int, err: Error] =
  var p = p
  if (l.n <= 0):
    (result.n, result.err) = (0, EOF)
    return
  if (convert(int64, len(p)) > l.n):
    p = slice(p, low=0, high=l.n)
  (result.n, result.err) = l.r.read(p)
  l.n -= convert(int64, result.n)
  return

proc newSectionReader(r: ReaderAt, off: int64, n: int64): gcptr[SectionReader] =
  return convert(gcptr[SectionReader], make((r, off, off, (off + n)), (ref SectionReader)))

proc read(s: gcptr[SectionReader], p: GoSlice[byte]): tuple[n: int, err: Error] =
  var p = p
  if (s.off >= s.limit):
    (result.n, result.err) = (0, EOF)
    return
  if (var max = (s.limit - s.off); (convert(int64, len(p)) > max)):
    p = slice(p, low=0, high=max)
  (result.n, result.err) = s.r.readAt(p, s.off)
  s.off += convert(int64, result.n)
  return

proc seek(s: gcptr[SectionReader], offset: int64, whence: int): tuple[arg0: int64, arg1: Error] =
  var offset = offset
  block:
    let condition = whence
    if condition == seekStart:
      offset += s.base
    elif condition == seekCurrent:
      offset += s.off
    elif condition == seekEnd:
      offset += s.limit
    else:
      (result.arg0, result.arg1) = (0, errWhence)
      return
  if (offset < s.base):
    (result.arg0, result.arg1) = (0, errOffset)
    return
  s.off = offset
  (result.arg0, result.arg1) = ((offset - s.base), null)
  return

proc readAt(s: gcptr[SectionReader], p: GoSlice[byte], off: int64): tuple[n: int, err: Error] =
  var (p,off) = (p,off)
  if ((off < 0) or (off >= (s.limit - s.base))):
    (result.n, result.err) = (0, EOF)
    return
  off += s.base
  if (var max = (s.limit - off); (convert(int64, len(p)) > max)):
    p = slice(p, low=0, high=max)
    (result.n, result.err) = s.r.readAt(p, off)
    if (result.err == null):
      result.err = EOF
    (result.n, result.err) = (result.n, result.err)
    return
  (result.n, result.err) = s.r.readAt(p, off)
  return

proc size(s: gcptr[SectionReader]): int64 =
  return (s.limit - s.base)

proc teeReader(r: Reader, w: Writer): Reader =
  return convert(gcptr[TeeReader], make((r, w), (ref TeeReader)))

proc read(t: gcptr[TeeReader], p: GoSlice[byte]): tuple[n: int, err: Error] =
  (result.n, result.err) = t.r.read(p)
  if (result.n > 0):
    if (var (n, err) = t.w.write(slice(p, high=result.n)); (err != null)):
      (result.n, result.err) = (n, err)
      return
  return



proc read(mr: gcptr[MultiReader], p: GoSlice[byte]): tuple[n: int, err: Error] =
  while (len(mr.readers) > 0):
    if (len(mr.readers) == 1):
      if (var (r, ok) = maybeCastInterface(mr.readers[0], to=gcptr[MultiReader]); ok):
        mr.readers = r.readers
        continue
    (result.n, result.err) = mr.readers[0].read(p)
    if ((result.n > 0) or (result.err != EOF)):
      if (result.err == EOF):
        result.err = null
      return
    mr.readers = slice(mr.readers, low=1)
  (result.n, result.err) = (0, EOF)
  return

proc multiReader(readers: GoVarArgs[Reader]): Reader =
  var r = make(GoSlice[Reader], len(readers))
  copy(r, readers)
  return convert(gcptr[MultiReader], make((r), (ref MultiReader)))

proc write(t: gcptr[MultiWriter], p: GoSlice[byte]): tuple[n: int, err: Error] =
  for _, w in t.writers:
    (result.n, result.err) = w.write(p)
    if (result.err != null):
      return
    if (result.n != len(p)):
      result.err = errShortWrite
      return
  (result.n, result.err) = (len(p), null)
  return

proc writeString(t: gcptr[MultiWriter], s: string): tuple[n: int, err: Error] =
  var p: GoSlice[byte]
  for _, w in t.writers:
    if (var (sw, ok) = maybeCastInterface(w, to=StringWriter); ok):
      (result.n, result.err) = sw.writeString(s)
    else:
      if (p == null):
        p = convert(GoSlice[byte], s)
      (result.n, result.err) = w.write(p)
    if (result.err != null):
      return
    if (result.n != len(s)):
      result.err = errShortWrite
      return
  (result.n, result.err) = (len(s), null)
  return

proc multiWriter(writers: GoVarArgs[Writer]): Writer =
  var w = make(GoSlice[Writer], len(writers))
  copy(w, writers)
  return convert(gcptr[MultiWriter], make((w), (ref MultiWriter)))



proc readInternal(p: gcptr[Pipe], b: GoSlice[byte]): tuple[n: int, err: Error] =
  p.rl.lock()
  godefer(p.rl.unlock())
  p.l.lock()
  godefer(p.l.unlock())
  while true:
    if (p.rerr != null):
      (result.n, result.err) = (0, errClosedPipe)
      return
    if (p.data != null):
      break
    if (p.werr != null):
      (result.n, result.err) = (0, p.werr)
      return
    p.rwait.wait()
  result.n = copy(b, p.data)
  p.data = slice(p.data, low=result.n)
  if (len(p.data) == 0):
    p.data = null
    p.wwait.signal()
  return

proc writeInternal(p: gcptr[Pipe], b: GoSlice[byte]): tuple[n: int, err: Error] =
  var b = b
  if (b == null):
    b = slice(zero)
  p.wl.lock()
  godefer(p.wl.unlock())
  p.l.lock()
  godefer(p.l.unlock())
  if (p.werr != null):
    result.err = errClosedPipe
    return
  p.data = b
  p.rwait.signal()
  while true:
    if (p.data == null):
      break
    if (p.rerr != null):
      result.err = p.rerr
      break
    if (p.werr != null):
      result.err = errClosedPipe
    p.wwait.wait()
  result.n = (len(b) - len(p.data))
  p.data = null
  return

proc rclose(p: gcptr[Pipe], err: Error): void =
  var err = err
  if (err == null):
    err = errClosedPipe
  p.l.lock()
  godefer(p.l.unlock())
  p.rerr = err
  p.rwait.signal()
  p.wwait.signal()

proc wclose(p: gcptr[Pipe], err: Error): void =
  var err = err
  if (err == null):
    err = EOF
  p.l.lock()
  godefer(p.l.unlock())
  p.werr = err
  p.rwait.signal()
  p.wwait.signal()

proc read(r: gcptr[PipeReader], data: GoSlice[byte]): tuple[n: int, err: Error] =
  (result.n, result.err) = r.p.readInternal(data)
  return

proc close(r: gcptr[PipeReader]): Error =
  return r.closeWithError(null)

proc closeWithError(r: gcptr[PipeReader], err: Error): Error =
  r.p.rclose(err)
  return null

proc write(w: gcptr[PipeWriter], data: GoSlice[byte]): tuple[n: int, err: Error] =
  (result.n, result.err) = w.p.writeInternal(data)
  return

proc close(w: gcptr[PipeWriter]): Error =
  return w.closeWithError(null)

proc closeWithError(w: gcptr[PipeWriter], err: Error): Error =
  w.p.wclose(err)
  return null

proc pipe(): tuple[arg0: gcptr[PipeReader], arg1: gcptr[PipeWriter]] =
  var p = gcnew(Pipe)
  p.rwait.l = gcaddr p.l
  p.wwait.l = gcaddr p.l
  var r = convert(gcptr[PipeReader], make((p), (ref PipeReader)))
  var w = convert(gcptr[PipeWriter], make((p), (ref PipeWriter)))
  (result.arg0, result.arg1) = (r, w)
  return


when isMainModule:
  main()
