include gosupport

exttypes:
  type
    ErrorString* = struct((s: string))

proc new*(text: string): Error {.gofunc.}
proc error*(e: gcptr[ErrorString]): string {.gofunc, gomethod.}


proc new(text: string): Error =
  return convert(gcptr[ErrorString], make((text), (ref ErrorString)))

proc error(e: gcptr[ErrorString]): string =
  return e.s


when isMainModule:
  main()
